// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.GameCenterDetails.WithID.Relationships {
	public var challengesMinimumPlatformVersions: ChallengesMinimumPlatformVersions {
		ChallengesMinimumPlatformVersions(path: path + "/challengesMinimumPlatformVersions")
	}

	public struct ChallengesMinimumPlatformVersions {
		/// Path: `/v1/gameCenterDetails/{id}/relationships/challengesMinimumPlatformVersions`
		public let path: String

		public func patch(_ body: AppStoreConnect_Swift_SDK.GameCenterDetailChallengesMinimumPlatformVersionsLinkagesRequest) -> Request<Void> {
			Request(path: path, method: "PATCH", body: body, id: "gameCenterDetails_challengesMinimumPlatformVersions_replaceToManyRelationship")
		}
	}
}
