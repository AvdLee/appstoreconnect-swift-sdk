import Foundation
import AppStoreConnectCore
import AppStoreConnectAppStore
import AppStoreConnectTestFlight

public struct ReleasePlan: Sendable {
    public var appID: String
    public var versionString: String
    public var buildNumber: String
    public var whatsNew: String

    public init(appID: String, versionString: String, buildNumber: String, whatsNew: String) {
        self.appID = appID
        self.versionString = versionString
        self.buildNumber = buildNumber
        self.whatsNew = whatsNew
    }
}

public struct SubmittedRelease: Sendable, Equatable {
    public var versionID: String
    public var buildID: String
    public var reviewSubmissionID: String
    public var updatedLocalizationIDs: [String]
    /// Read from `included`; the type lives in Core, so this works without the GameCenter module.
    public var gameCenterAppVersionID: String?
}

public enum ReleaseError: Error, Equatable {
    case buildNotFound(String)
}

/// Submits an App Store version for review: find the build, find or create the version, attach the build,
/// set "What's New" on every localization, then create and submit a review submission.
public struct ReleaseSubmitter: Sendable {
    private let provider: APIProvider

    public init(provider: APIProvider) {
        self.provider = provider
    }

    public func submit(_ plan: ReleasePlan) async throws -> SubmittedRelease {
        let builds = try await self.provider.request(
            APIEndpoint.v1.builds.get(parameters: .init(filterVersion: [plan.buildNumber], filterApp: [plan.appID]))
        )
        guard let build = builds.data.first else {
            throw ReleaseError.buildNotFound(plan.buildNumber)
        }

        let versions = try await self.provider.request(
            APIEndpoint.v1.apps.id(plan.appID).appStoreVersions.get(parameters: .init(
                filterVersionString: [plan.versionString],
                include: [.appStoreVersionLocalizations, .gameCenterAppVersion]
            ))
        )
        let versionID = try await self.existingOrNewVersionID(versions, plan: plan)

        _ = try await self.provider.request(APIEndpoint.v1.appStoreVersions.id(versionID).patch(.init(data: .init(
            type: .appStoreVersions,
            id: versionID,
            relationships: .init(build: .init(data: .init(type: .builds, id: build.id)))
        ))))

        var localizationIDs: [String] = []
        var gameCenterAppVersionID: String?
        for item in versions.included ?? [] {
            switch item {
            case .appStoreVersionLocalization(let localization):
                _ = try await self.provider.request(APIEndpoint.v1.appStoreVersionLocalizations.id(localization.id).patch(.init(data: .init(
                    type: .appStoreVersionLocalizations,
                    id: localization.id,
                    attributes: .init(whatsNew: plan.whatsNew)
                ))))
                localizationIDs.append(localization.id)
            case .gameCenterAppVersion(let gameCenterAppVersion):
                gameCenterAppVersionID = gameCenterAppVersion.id
            default:
                break
            }
        }

        let submission = try await self.provider.request(APIEndpoint.v1.reviewSubmissions.post(.init(data: .init(
            type: .reviewSubmissions,
            attributes: .init(platform: .ios),
            relationships: .init(app: .init(data: .init(type: .apps, id: plan.appID)))
        ))))
        _ = try await self.provider.request(APIEndpoint.v1.reviewSubmissionItems.post(.init(data: .init(
            type: .reviewSubmissionItems,
            relationships: .init(
                reviewSubmission: .init(data: .init(type: .reviewSubmissions, id: submission.data.id)),
                appStoreVersion: .init(data: .init(type: .appStoreVersions, id: versionID))
            )
        ))))
        _ = try await self.provider.request(APIEndpoint.v1.reviewSubmissions.id(submission.data.id).patch(.init(data: .init(
            type: .reviewSubmissions,
            id: submission.data.id,
            attributes: .init(isSubmitted: true)
        ))))

        return SubmittedRelease(
            versionID: versionID,
            buildID: build.id,
            reviewSubmissionID: submission.data.id,
            updatedLocalizationIDs: localizationIDs,
            gameCenterAppVersionID: gameCenterAppVersionID
        )
    }

    private func existingOrNewVersionID(_ versions: AppStoreVersionsResponse, plan: ReleasePlan) async throws -> String {
        if let existing = versions.data.first {
            return existing.id
        }
        let created = try await self.provider.request(APIEndpoint.v1.appStoreVersions.post(.init(data: .init(
            type: .appStoreVersions,
            attributes: .init(platform: .ios, versionString: plan.versionString),
            relationships: .init(app: .init(data: .init(type: .apps, id: plan.appID)))
        ))))
        return created.data.id
    }
}
