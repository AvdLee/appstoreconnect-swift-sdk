// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.AppInfos.WithID.Relationships {
	public var secondaryCategory: SecondaryCategory {
		SecondaryCategory(path: path + "/secondaryCategory")
	}

	public struct SecondaryCategory {
		/// Path: `/v1/appInfos/{id}/relationships/secondaryCategory`
		public let path: String

		public var get: Request<AppStoreConnect_Swift_SDK.AppInfoSecondaryCategoryLinkageResponse> {
			Request(path: path, method: "GET", id: "appInfos_secondaryCategory_getToOneRelationship")
		}
	}
}
