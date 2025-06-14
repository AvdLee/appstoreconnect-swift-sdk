// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.GameCenterChallengeLocalizations.WithID {
	public var relationships: Relationships {
		Relationships(path: path + "/relationships")
	}

	public struct Relationships {
		/// Path: `/v1/gameCenterChallengeLocalizations/{id}/relationships`
		public let path: String
	}
}
