// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1 {
	public var analyticsReportRequests: AnalyticsReportRequests {
		AnalyticsReportRequests(path: path + "/analyticsReportRequests")
	}

	public struct AnalyticsReportRequests {
		/// Path: `/v1/analyticsReportRequests`
		public let path: String

		public func post(_ body: AppStoreConnect_Swift_SDK.AnalyticsReportRequestCreateRequest) -> Request<AppStoreConnect_Swift_SDK.AnalyticsReportRequestResponse> {
			Request(path: path, method: "POST", body: body, id: "analyticsReportRequests_createInstance")
		}
	}
}