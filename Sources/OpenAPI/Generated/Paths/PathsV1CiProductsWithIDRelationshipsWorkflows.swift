// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.CiProducts.WithID.Relationships {
	public var workflows: Workflows {
		Workflows(path: path + "/workflows")
	}

	public struct Workflows {
		/// Path: `/v1/ciProducts/{id}/relationships/workflows`
		public let path: String

		public func get(limit: Int? = nil) -> Request<AppStoreConnect_Swift_SDK.CiProductWorkflowsLinkagesResponse> {
			Request(path: path, method: "GET", query: makeGetQuery(limit), id: "ciProducts_workflows_getToManyRelationship")
		}

		private func makeGetQuery(_ limit: Int?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(limit, forKey: "limit")
			return encoder.items
		}
	}
}
