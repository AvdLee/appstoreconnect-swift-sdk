// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct AppClipAdvancedExperienceImageCreateRequest: Codable {
	public var data: Data

	public struct Data: Codable {
		public var type: `Type`
		public var attributes: Attributes

		public enum `Type`: String, Codable, CaseIterable {
			case appClipAdvancedExperienceImages
		}

		public struct Attributes: Codable {
			public var fileSize: Int
			public var fileName: String

			public init(fileSize: Int, fileName: String) {
				self.fileSize = fileSize
				self.fileName = fileName
			}

			public init(from decoder: Decoder) throws {
				let values = try decoder.container(keyedBy: StringCodingKey.self)
				self.fileSize = try values.decode(Int.self, forKey: "fileSize")
				self.fileName = try values.decode(String.self, forKey: "fileName")
			}

			public func encode(to encoder: Encoder) throws {
				var values = encoder.container(keyedBy: StringCodingKey.self)
				try values.encode(fileSize, forKey: "fileSize")
				try values.encode(fileName, forKey: "fileName")
			}
		}

		public init(type: `Type`, attributes: Attributes) {
			self.type = type
			self.attributes = attributes
		}

		public init(from decoder: Decoder) throws {
			let values = try decoder.container(keyedBy: StringCodingKey.self)
			self.type = try values.decode(`Type`.self, forKey: "type")
			self.attributes = try values.decode(Attributes.self, forKey: "attributes")
		}

		public func encode(to encoder: Encoder) throws {
			var values = encoder.container(keyedBy: StringCodingKey.self)
			try values.encode(type, forKey: "type")
			try values.encode(attributes, forKey: "attributes")
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
