// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.Profiles.WithID.Relationships {
	public var bundleID: BundleID {
		BundleID(path: path + "/bundleId")
	}

	public struct BundleID {
		/// Path: `/v1/profiles/{id}/relationships/bundleId`
		public let path: String

		public var get: Request<AppStoreConnect_Swift_SDK.ProfileBundleIDLinkageResponse> {
			Request(path: path, method: "GET", id: "profiles_bundleId_getToOneRelationship")
		}
	}
}
