// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.ScmRepositories.WithID.Relationships {
	public var pullRequests: PullRequests {
		PullRequests(path: path + "/pullRequests")
	}

	public struct PullRequests {
		/// Path: `/v1/scmRepositories/{id}/relationships/pullRequests`
		public let path: String
	}
}
