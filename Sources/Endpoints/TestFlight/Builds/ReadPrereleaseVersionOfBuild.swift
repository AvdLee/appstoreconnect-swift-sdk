//
//  ReadPrereleaseVersionOfBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where Request == EmptyBody, Response == PrereleaseVersionResponse {

    /// Get the prerelease version for a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func prereleaseVersion(
        ofBuildWithId id: String,
        fields: [ReadPrereleaseVersionOfBuild.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(
            path: "builds/\(id)/preReleaseVersion",
            method: .get,
            parameters: parameters)
    }
}

public enum ReadPrereleaseVersionOfBuild {
    
    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case preReleaseVersions([PreReleaseVersion])
        
        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .preReleaseVersions(let value):
                return (PreReleaseVersion.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ReadPrereleaseVersionOfBuild.Field {
    
    public enum PreReleaseVersion: String, CaseIterable, NestableQueryParameter {
        case app, builds, platform, version

        static var key: String = "preReleaseVersion"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
