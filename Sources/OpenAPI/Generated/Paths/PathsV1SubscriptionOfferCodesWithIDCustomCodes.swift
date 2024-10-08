// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.SubscriptionOfferCodes.WithID {
	public var customCodes: CustomCodes {
		CustomCodes(path: path + "/customCodes")
	}

	public struct CustomCodes {
		/// Path: `/v1/subscriptionOfferCodes/{id}/customCodes`
		public let path: String

		public func get(parameters: GetParameters? = nil) -> Request<AppStoreConnect_Swift_SDK.SubscriptionOfferCodeCustomCodesResponse> {
			Request(path: path, method: "GET", query: parameters?.asQuery, id: "subscriptionOfferCodes_customCodes_getToManyRelated")
		}

		public struct GetParameters {
			public var fieldsSubscriptionOfferCodeCustomCodes: [FieldsSubscriptionOfferCodeCustomCodes]?
			public var fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]?
			public var limit: Int?
			public var include: [Include]?

			public enum FieldsSubscriptionOfferCodeCustomCodes: String, Codable, CaseIterable {
				case customCode
				case numberOfCodes
				case createdDate
				case expirationDate
				case active
				case offerCode
			}

			public enum FieldsSubscriptionOfferCodes: String, Codable, CaseIterable {
				case name
				case customerEligibilities
				case offerEligibility
				case duration
				case offerMode
				case numberOfPeriods
				case totalNumberOfCodes
				case active
				case subscription
				case oneTimeUseCodes
				case customCodes
				case prices
			}

			public enum Include: String, Codable, CaseIterable {
				case offerCode
			}

			public init(fieldsSubscriptionOfferCodeCustomCodes: [FieldsSubscriptionOfferCodeCustomCodes]? = nil, fieldsSubscriptionOfferCodes: [FieldsSubscriptionOfferCodes]? = nil, limit: Int? = nil, include: [Include]? = nil) {
				self.fieldsSubscriptionOfferCodeCustomCodes = fieldsSubscriptionOfferCodeCustomCodes
				self.fieldsSubscriptionOfferCodes = fieldsSubscriptionOfferCodes
				self.limit = limit
				self.include = include
			}

			public var asQuery: [(String, String?)] {
				let encoder = URLQueryEncoder(explode: false)
				encoder.encode(fieldsSubscriptionOfferCodeCustomCodes, forKey: "fields[subscriptionOfferCodeCustomCodes]")
				encoder.encode(fieldsSubscriptionOfferCodes, forKey: "fields[subscriptionOfferCodes]")
				encoder.encode(limit, forKey: "limit")
				encoder.encode(include, forKey: "include")
				return encoder.items
			}
		}
	}
}
