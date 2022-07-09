// Generated by Create API
// https://github.com/CreateAPI/CreateAPI
//
// swiftlint:disable all

import Foundation
import Get
import URLQueryEncoder

extension APIEndpoint {
	public static var bundleIDCapabilities: BundleIDCapabilities {
		BundleIDCapabilities(path: "/v1/bundleIdCapabilities")
	}

	public struct BundleIDCapabilities {
		/// Path: `/v1/bundleIdCapabilities`
		public let path: String

		public func post(_ body: AppStoreConnect_Swift_SDK.BundleIDCapabilityCreateRequest) -> Request<AppStoreConnect_Swift_SDK.BundleIDCapabilityResponse> {
			.post(path, body: body)
		}
	}
}