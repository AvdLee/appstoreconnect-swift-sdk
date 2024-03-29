// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V3 {
	public var appPricePoints: AppPricePoints {
		AppPricePoints(path: path + "/appPricePoints")
	}

	public struct AppPricePoints {
		/// Path: `/v3/appPricePoints`
		public let path: String
	}
}
