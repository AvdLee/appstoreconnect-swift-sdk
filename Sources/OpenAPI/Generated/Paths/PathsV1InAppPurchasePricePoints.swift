// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1 {
	public var inAppPurchasePricePoints: InAppPurchasePricePoints {
		InAppPurchasePricePoints(path: path + "/inAppPurchasePricePoints")
	}

	public struct InAppPurchasePricePoints {
		/// Path: `/v1/inAppPurchasePricePoints`
		public let path: String
	}
}