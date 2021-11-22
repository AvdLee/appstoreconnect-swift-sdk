import Foundation

public struct AppStoreVersionSubmissionCreateRequest: Codable {

    public struct Data: Codable {

        public let relationships: AppStoreVersionSubmissionCreateRequest.Data.Relationships

        public private(set) var type: String = "appStoreVersionSubmissions"
    }

    public let data: AppStoreVersionSubmissionCreateRequest.Data

    init(appStoreVersionId: String) {
        self.data = .init(relationships: .init(appStoreVersion: .init(data: .init(id: appStoreVersionId))))
    }
}

// MARK: AppStoreVersionSubmissionCreateRequest.Data
extension AppStoreVersionSubmissionCreateRequest.Data {

    public struct Relationships: Codable {

        public let appStoreVersion: AppStoreVersionSubmissionCreateRequest.Data.Relationships.AppStoreVersion

    }
}

// MARK: - AppStoreVersionSubmissionCreateRequest.Data.Relationships
extension AppStoreVersionSubmissionCreateRequest.Data.Relationships {

    public struct AppStoreVersion: Codable {

        public let data: AppStoreVersionSubmissionCreateRequest.Data.Relationships.AppStoreVersion.Data

    }
}

// MARK: AppStoreVersionSubmissionCreateRequest.Data.Relationships.AppStoreVersion
extension AppStoreVersionSubmissionCreateRequest.Data.Relationships.AppStoreVersion {

    public struct Data: Codable {

        public let id: String

        public private(set) var type: String = "appStoreVersions"

    }
}
