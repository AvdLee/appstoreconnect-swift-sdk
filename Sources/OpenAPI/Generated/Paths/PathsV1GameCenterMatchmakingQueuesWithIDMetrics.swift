// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation
import URLQueryEncoder

extension APIEndpoint.V1.GameCenterMatchmakingQueues.WithID {
	public var metrics: Metrics {
		Metrics(path: path + "/metrics")
	}

	public struct Metrics {
		/// Path: `/v1/gameCenterMatchmakingQueues/{id}/metrics`
		public let path: String
	}
}
