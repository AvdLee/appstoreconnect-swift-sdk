// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.AppPricePoints.WithID.Relationships {
	public var territory: Territory {
		Territory(path: path + "/territory")
	}

	public struct Territory {
		/// Path: `/v1/appPricePoints/{id}/relationships/territory`
		public let path: String
	}
}
