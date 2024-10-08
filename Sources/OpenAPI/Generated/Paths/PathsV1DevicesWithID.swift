// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.Devices {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/devices/{id}`
		public let path: String

		public func get(fieldsDevices: [FieldsDevices]? = nil) -> Request<AppStoreConnect_Swift_SDK.DeviceResponse> {
			Request(path: path, method: "GET", query: makeGetQuery(fieldsDevices), id: "devices_getInstance")
		}

		private func makeGetQuery(_ fieldsDevices: [FieldsDevices]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsDevices, forKey: "fields[devices]", explode: false)
			return encoder.items
		}

		public enum FieldsDevices: String, Codable, CaseIterable {
			case name
			case platform
			case udid
			case deviceClass
			case status
			case model
			case addedDate
		}

		public func patch(_ body: AppStoreConnect_Swift_SDK.DeviceUpdateRequest) -> Request<AppStoreConnect_Swift_SDK.DeviceResponse> {
			Request(path: path, method: "PATCH", body: body, id: "devices_updateInstance")
		}
	}
}
