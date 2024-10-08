// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1 {
	public var routingAppCoverages: RoutingAppCoverages {
		RoutingAppCoverages(path: path + "/routingAppCoverages")
	}

	public struct RoutingAppCoverages {
		/// Path: `/v1/routingAppCoverages`
		public let path: String

		public func post(_ body: AppStoreConnect_Swift_SDK.RoutingAppCoverageCreateRequest) -> Request<AppStoreConnect_Swift_SDK.RoutingAppCoverageResponse> {
			Request(path: path, method: "POST", body: body, id: "routingAppCoverages_createInstance")
		}
	}
}
