// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.AlternativeDistributionPackageVersions.WithID.Relationships {
	public var deltas: Deltas {
		Deltas(path: path + "/deltas")
	}

	public struct Deltas {
		/// Path: `/v1/alternativeDistributionPackageVersions/{id}/relationships/deltas`
		public let path: String
	}
}
