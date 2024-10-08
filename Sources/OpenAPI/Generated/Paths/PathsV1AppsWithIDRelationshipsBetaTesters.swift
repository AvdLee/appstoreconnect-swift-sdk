// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.Apps.WithID.Relationships {
	public var betaTesters: BetaTesters {
		BetaTesters(path: path + "/betaTesters")
	}

	public struct BetaTesters {
		/// Path: `/v1/apps/{id}/relationships/betaTesters`
		public let path: String

		public func delete(_ body: AppStoreConnect_Swift_SDK.AppBetaTestersLinkagesRequest) -> Request<Void> {
			Request(path: path, method: "DELETE", body: body, id: "apps_betaTesters_deleteToManyRelationship")
		}
	}
}
