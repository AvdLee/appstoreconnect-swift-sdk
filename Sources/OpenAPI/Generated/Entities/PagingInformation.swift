// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct PagingInformation: Codable {
	public var paging: Paging

	public struct Paging: Codable {
		public var total: Int?
		public var limit: Int

		public init(total: Int? = nil, limit: Int) {
			self.total = total
			self.limit = limit
		}

		public init(from decoder: Decoder) throws {
			let values = try decoder.container(keyedBy: StringCodingKey.self)
			self.total = try values.decodeIfPresent(Int.self, forKey: "total")
			self.limit = try values.decode(Int.self, forKey: "limit")
		}

		public func encode(to encoder: Encoder) throws {
			var values = encoder.container(keyedBy: StringCodingKey.self)
			try values.encodeIfPresent(total, forKey: "total")
			try values.encode(limit, forKey: "limit")
		}
	}

	public init(paging: Paging) {
		self.paging = paging
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: StringCodingKey.self)
		self.paging = try values.decode(Paging.self, forKey: "paging")
	}

	public func encode(to encoder: Encoder) throws {
		var values = encoder.container(keyedBy: StringCodingKey.self)
		try values.encode(paging, forKey: "paging")
	}
}
