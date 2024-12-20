// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.AppClipAdvancedExperienceImages {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/appClipAdvancedExperienceImages/{id}`
		public let path: String

		public func get(fieldsAppClipAdvancedExperienceImages: [FieldsAppClipAdvancedExperienceImages]? = nil) -> Request<AppStoreConnect_Swift_SDK.AppClipAdvancedExperienceImageResponse> {
			Request(path: path, method: "GET", query: makeGetQuery(fieldsAppClipAdvancedExperienceImages), id: "appClipAdvancedExperienceImages_getInstance")
		}

		private func makeGetQuery(_ fieldsAppClipAdvancedExperienceImages: [FieldsAppClipAdvancedExperienceImages]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsAppClipAdvancedExperienceImages, forKey: "fields[appClipAdvancedExperienceImages]", explode: false)
			return encoder.items
		}

		public enum FieldsAppClipAdvancedExperienceImages: String, Codable, CaseIterable {
			case fileSize
			case fileName
			case sourceFileChecksum
			case imageAsset
			case uploadOperations
			case assetDeliveryState
		}

		public func patch(_ body: AppStoreConnect_Swift_SDK.AppClipAdvancedExperienceImageUpdateRequest) -> Request<AppStoreConnect_Swift_SDK.AppClipAdvancedExperienceImageResponse> {
			Request(path: path, method: "PATCH", body: body, id: "appClipAdvancedExperienceImages_updateInstance")
		}
	}
}
