// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.SubscriptionPromotionalOffers {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/subscriptionPromotionalOffers/{id}`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<AppStoreConnect_Swift_SDK.SubscriptionPromotionalOfferResponse> {
			Request(path: path, method: "GET", query: parameters?.asQuery, id: "subscriptionPromotionalOffers-get_instance")
		}

		public struct GetParameters {
			public var fieldsSubscriptionPromotionalOffers: [FieldsSubscriptionPromotionalOffers]?
			public var include: [Include]?
			public var fieldsSubscriptionPromotionalOfferPrices: [FieldsSubscriptionPromotionalOfferPrices]?
			public var limitPrices: Int?

			public enum FieldsSubscriptionPromotionalOffers: String, Codable, CaseIterable {
				case duration
				case name
				case numberOfPeriods
				case offerCode
				case offerMode
				case prices
				case subscription
			}

			public enum Include: String, Codable, CaseIterable {
				case prices
				case subscription
			}

			public enum FieldsSubscriptionPromotionalOfferPrices: String, Codable, CaseIterable {
				case subscriptionPricePoint
				case territory
			}

			public init(fieldsSubscriptionPromotionalOffers: [FieldsSubscriptionPromotionalOffers]? = nil, include: [Include]? = nil, fieldsSubscriptionPromotionalOfferPrices: [FieldsSubscriptionPromotionalOfferPrices]? = nil, limitPrices: Int? = nil) {
				self.fieldsSubscriptionPromotionalOffers = fieldsSubscriptionPromotionalOffers
				self.include = include
				self.fieldsSubscriptionPromotionalOfferPrices = fieldsSubscriptionPromotionalOfferPrices
				self.limitPrices = limitPrices
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsSubscriptionPromotionalOffers, forKey: "fields[subscriptionPromotionalOffers]")
				encoder.encode(include, forKey: "include")
				encoder.encode(fieldsSubscriptionPromotionalOfferPrices, forKey: "fields[subscriptionPromotionalOfferPrices]")
				encoder.encode(limitPrices, forKey: "limit[prices]")
				return encoder.items
			}
		}

		public func patch(_ body: AppStoreConnect_Swift_SDK.SubscriptionPromotionalOfferUpdateRequest) -> Request<AppStoreConnect_Swift_SDK.SubscriptionPromotionalOfferResponse> {
			Request(path: path, method: "PATCH", body: body, id: "subscriptionPromotionalOffers-update_instance")
		}

		public var delete: Request<Void> {
			Request(path: path, method: "DELETE", id: "subscriptionPromotionalOffers-delete_instance")
		}
	}
}
