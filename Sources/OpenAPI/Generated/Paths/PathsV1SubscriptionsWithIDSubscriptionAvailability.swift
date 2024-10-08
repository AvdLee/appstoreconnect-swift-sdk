// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.Subscriptions.WithID {
	public var subscriptionAvailability: SubscriptionAvailability {
		SubscriptionAvailability(path: path + "/subscriptionAvailability")
	}

	public struct SubscriptionAvailability {
		/// Path: `/v1/subscriptions/{id}/subscriptionAvailability`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<AppStoreConnect_Swift_SDK.SubscriptionAvailabilityResponse> {
			Request(path: path, method: "GET", query: parameters?.asQuery, id: "subscriptions_subscriptionAvailability_getToOneRelated")
		}

		public struct GetParameters {
			public var fieldsSubscriptionAvailabilities: [FieldsSubscriptionAvailabilities]?
			public var fieldsSubscriptions: [FieldsSubscriptions]?
			public var fieldsTerritories: [FieldsTerritories]?
			public var include: [Include]?
			public var limitAvailableTerritories: Int?

			public enum FieldsSubscriptionAvailabilities: String, Codable, CaseIterable {
				case availableInNewTerritories
				case subscription
				case availableTerritories
			}

			public enum FieldsSubscriptions: String, Codable, CaseIterable {
				case name
				case productID = "productId"
				case familySharable
				case state
				case subscriptionPeriod
				case reviewNote
				case groupLevel
				case subscriptionLocalizations
				case appStoreReviewScreenshot
				case group
				case introductoryOffers
				case promotionalOffers
				case offerCodes
				case prices
				case pricePoints
				case promotedPurchase
				case subscriptionAvailability
				case winBackOffers
				case images
			}

			public enum FieldsTerritories: String, Codable, CaseIterable {
				case currency
			}

			public enum Include: String, Codable, CaseIterable {
				case subscription
				case availableTerritories
			}

			public init(fieldsSubscriptionAvailabilities: [FieldsSubscriptionAvailabilities]? = nil, fieldsSubscriptions: [FieldsSubscriptions]? = nil, fieldsTerritories: [FieldsTerritories]? = nil, include: [Include]? = nil, limitAvailableTerritories: Int? = nil) {
				self.fieldsSubscriptionAvailabilities = fieldsSubscriptionAvailabilities
				self.fieldsSubscriptions = fieldsSubscriptions
				self.fieldsTerritories = fieldsTerritories
				self.include = include
				self.limitAvailableTerritories = limitAvailableTerritories
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsSubscriptionAvailabilities, forKey: "fields[subscriptionAvailabilities]")
				encoder.encode(fieldsSubscriptions, forKey: "fields[subscriptions]")
				encoder.encode(fieldsTerritories, forKey: "fields[territories]")
				encoder.encode(include, forKey: "include")
				encoder.encode(limitAvailableTerritories, forKey: "limit[availableTerritories]")
				return encoder.items
			}
		}
	}
}
