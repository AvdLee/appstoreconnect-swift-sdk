// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1 {
	public var subscriptionIntroductoryOffers: SubscriptionIntroductoryOffers {
		SubscriptionIntroductoryOffers(path: path + "/subscriptionIntroductoryOffers")
	}

	public struct SubscriptionIntroductoryOffers {
		/// Path: `/v1/subscriptionIntroductoryOffers`
		public let path: String

		public func post(_ body: AppStoreConnect_Swift_SDK.SubscriptionIntroductoryOfferCreateRequest) -> Request<AppStoreConnect_Swift_SDK.SubscriptionIntroductoryOfferResponse> {
			Request(path: path, method: "POST", body: body, id: "subscriptionIntroductoryOffers_createInstance")
		}
	}
}
