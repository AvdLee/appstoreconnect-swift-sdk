// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct ReviewSubmissionUpdateRequest: Codable {
	public var data: Data

	public struct Data: Codable, Identifiable {
		public var type: `Type`
		public var id: String
		public var attributes: Attributes?

		public enum `Type`: String, Codable, CaseIterable {
			case reviewSubmissions
		}

		public struct Attributes: Codable {
			public var platform: Platform?
			public var isSubmitted: Bool?
			public var isCanceled: Bool?

			public init(platform: Platform? = nil, isSubmitted: Bool? = nil, isCanceled: Bool? = nil) {
				self.platform = platform
				self.isSubmitted = isSubmitted
				self.isCanceled = isCanceled
			}

			public init(from decoder: Decoder) throws {
				let values = try decoder.container(keyedBy: StringCodingKey.self)
				self.platform = try values.decodeIfPresent(Platform.self, forKey: "platform")
				self.isSubmitted = try values.decodeIfPresent(Bool.self, forKey: "submitted")
				self.isCanceled = try values.decodeIfPresent(Bool.self, forKey: "canceled")
			}

			public func encode(to encoder: Encoder) throws {
				var values = encoder.container(keyedBy: StringCodingKey.self)
				try values.encodeIfPresent(platform, forKey: "platform")
				try values.encodeIfPresent(isSubmitted, forKey: "submitted")
				try values.encodeIfPresent(isCanceled, forKey: "canceled")
			}
		}

		public init(type: `Type`, id: String, attributes: Attributes? = nil) {
			self.type = type
			self.id = id
			self.attributes = attributes
		}

		public init(from decoder: Decoder) throws {
			let values = try decoder.container(keyedBy: StringCodingKey.self)
			self.type = try values.decode(`Type`.self, forKey: "type")
			self.id = try values.decode(String.self, forKey: "id")
			self.attributes = try values.decodeIfPresent(Attributes.self, forKey: "attributes")
		}

		public func encode(to encoder: Encoder) throws {
			var values = encoder.container(keyedBy: StringCodingKey.self)
			try values.encode(type, forKey: "type")
			try values.encode(id, forKey: "id")
			try values.encodeIfPresent(attributes, forKey: "attributes")
		}
	}

	public init(data: Data) {
		self.data = data
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: StringCodingKey.self)
		self.data = try values.decode(Data.self, forKey: "data")
	}

	public func encode(to encoder: Encoder) throws {
		var values = encoder.container(keyedBy: StringCodingKey.self)
		try values.encode(data, forKey: "data")
	}
}
