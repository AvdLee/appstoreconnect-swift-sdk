// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.AnalyticsReportInstances {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/analyticsReportInstances/{id}`
		public let path: String

		public func get(fieldsAnalyticsReportInstances: [FieldsAnalyticsReportInstances]? = nil) -> Request<AppStoreConnect_Swift_SDK.AnalyticsReportInstanceResponse> {
			Request(path: path, method: "GET", query: makeGetQuery(fieldsAnalyticsReportInstances), id: "analyticsReportInstances_getInstance")
		}

		private func makeGetQuery(_ fieldsAnalyticsReportInstances: [FieldsAnalyticsReportInstances]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsAnalyticsReportInstances, forKey: "fields[analyticsReportInstances]", explode: false)
			return encoder.items
		}

		public enum FieldsAnalyticsReportInstances: String, Codable, CaseIterable {
			case granularity
			case processingDate
			case segments
		}
	}
}