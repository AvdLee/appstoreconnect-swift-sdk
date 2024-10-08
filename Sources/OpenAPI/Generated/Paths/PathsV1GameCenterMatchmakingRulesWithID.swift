// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.GameCenterMatchmakingRules {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/gameCenterMatchmakingRules/{id}`
		public let path: String

		public func patch(_ body: AppStoreConnect_Swift_SDK.GameCenterMatchmakingRuleUpdateRequest) -> Request<AppStoreConnect_Swift_SDK.GameCenterMatchmakingRuleResponse> {
			Request(path: path, method: "PATCH", body: body, id: "gameCenterMatchmakingRules_updateInstance")
		}

		public var delete: Request<Void> {
			Request(path: path, method: "DELETE", id: "gameCenterMatchmakingRules_deleteInstance")
		}
	}
}
