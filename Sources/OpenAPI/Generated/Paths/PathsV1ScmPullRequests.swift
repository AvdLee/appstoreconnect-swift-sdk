// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1 {
	public var scmPullRequests: ScmPullRequests {
		ScmPullRequests(path: path + "/scmPullRequests")
	}

	public struct ScmPullRequests {
		/// Path: `/v1/scmPullRequests`
		public let path: String
	}
}
