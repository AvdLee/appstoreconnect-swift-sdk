// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1 {
	public var ciBuildRuns: CiBuildRuns {
		CiBuildRuns(path: path + "/ciBuildRuns")
	}

	public struct CiBuildRuns {
		/// Path: `/v1/ciBuildRuns`
		public let path: String

		public func post(_ body: AppStoreConnect_Swift_SDK.CiBuildRunCreateRequest) -> Request<AppStoreConnect_Swift_SDK.CiBuildRunResponse> {
			Request(path: path, method: "POST", body: body, id: "ciBuildRuns_createInstance")
		}
	}
}
