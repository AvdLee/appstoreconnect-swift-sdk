// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swiftlint:disable all

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.AppEncryptionDeclarationDocuments {
	public func id(_ id: String) -> WithID {
		WithID(path: "\(path)/\(id)")
	}

	public struct WithID {
		/// Path: `/v1/appEncryptionDeclarationDocuments/{id}`
		public let path: String

		public func get(fieldsAppEncryptionDeclarationDocuments: [FieldsAppEncryptionDeclarationDocuments]? = nil) -> Request<AppStoreConnect_Swift_SDK.AppEncryptionDeclarationDocumentResponse> {
			.get(path, query: makeGetQuery(fieldsAppEncryptionDeclarationDocuments))
		}

		private func makeGetQuery(_ fieldsAppEncryptionDeclarationDocuments: [FieldsAppEncryptionDeclarationDocuments]?) -> [(String, String?)] {
			let encoder = URLQueryEncoder()
			encoder.encode(fieldsAppEncryptionDeclarationDocuments, forKey: "fields[appEncryptionDeclarationDocuments]", explode: false)
			return encoder.items
		}

		public enum FieldsAppEncryptionDeclarationDocuments: String, Codable, CaseIterable {
			case appEncryptionDeclaration
			case assetDeliveryState
			case assetToken
			case downloadURL = "downloadUrl"
			case fileName
			case fileSize
			case sourceFileChecksum
			case uploadOperations
			case uploaded
		}

		public func patch(_ body: AppStoreConnect_Swift_SDK.AppEncryptionDeclarationDocumentUpdateRequest) -> Request<AppStoreConnect_Swift_SDK.AppEncryptionDeclarationDocumentResponse> {
			.patch(path, body: body)
		}
	}
}