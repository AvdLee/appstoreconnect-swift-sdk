// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.Apps.WithID.Relationships {
	public var appAvailability: AppAvailability {
		AppAvailability(path: path + "/appAvailability")
	}

	public struct AppAvailability {
		/// Path: `/v1/apps/{id}/relationships/appAvailability`
		public let path: String
	}
}
