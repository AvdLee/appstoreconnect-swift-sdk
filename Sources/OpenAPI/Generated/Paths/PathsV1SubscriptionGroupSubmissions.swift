// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1 {
	public var subscriptionGroupSubmissions: SubscriptionGroupSubmissions {
		SubscriptionGroupSubmissions(path: path + "/subscriptionGroupSubmissions")
	}

	public struct SubscriptionGroupSubmissions {
		/// Path: `/v1/subscriptionGroupSubmissions`
		public let path: String

		public func post(_ body: AppStoreConnect_Swift_SDK.SubscriptionGroupSubmissionCreateRequest) -> Request<AppStoreConnect_Swift_SDK.SubscriptionGroupSubmissionResponse> {
			Request(path: path, method: "POST", body: body, id: "subscriptionGroupSubmissions_createInstance")
		}
	}
}
