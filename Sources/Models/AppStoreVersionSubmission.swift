import Foundation

public struct AppStoreVersionSubmission: Codable {
    public let id: String

    public let links: ResourceLinks<AppStoreVersionSubmissionResponse>

    public let relationships: AppStoreVersionSubmission.Relationships?

    public private(set) var type: String = "appStoreVersionSubmissions"
}

// MARK: AppStoreVersionSubmission
extension AppStoreVersionSubmission {

    public struct Relationships: Codable {

        public let appStoreVersion: AppStoreVersionSubmission.Relationships.AppStoreVersion?

    }
}

// MARK: AppStoreVersionSubmission.Relationships
extension AppStoreVersionSubmission.Relationships {

    public struct AppStoreVersion: Codable {

        public let data: AppStoreVersionSubmission.Relationships.AppStoreVersion.Data?

        public let links: AppStoreVersionSubmission.Relationships.AppStoreVersion.Links?
    }
}

// MARK: AppStoreVersionSubmission.Relationships.AppStoreVersion
extension AppStoreVersionSubmission.Relationships.AppStoreVersion {

    public struct Data: Codable {
        public let id: String

        public private(set) var type: String = "appStoreVersions"
    }

    public struct Links: Codable {
        public let related: URL?

        public let `self`: URL?
    }
}
