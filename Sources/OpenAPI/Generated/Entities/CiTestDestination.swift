// Generated by Create API
// https://github.com/CreateAPI/CreateAPI

import Foundation

public struct CiTestDestination: Codable {
	public var deviceTypeName: String?
	public var deviceTypeIdentifier: String?
	public var runtimeName: String?
	public var runtimeIdentifier: String?
	public var kind: CiTestDestinationKind?

	public init(deviceTypeName: String? = nil, deviceTypeIdentifier: String? = nil, runtimeName: String? = nil, runtimeIdentifier: String? = nil, kind: CiTestDestinationKind? = nil) {
		self.deviceTypeName = deviceTypeName
		self.deviceTypeIdentifier = deviceTypeIdentifier
		self.runtimeName = runtimeName
		self.runtimeIdentifier = runtimeIdentifier
		self.kind = kind
	}

	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: StringCodingKey.self)
		self.deviceTypeName = try values.decodeIfPresent(String.self, forKey: "deviceTypeName")
		self.deviceTypeIdentifier = try values.decodeIfPresent(String.self, forKey: "deviceTypeIdentifier")
		self.runtimeName = try values.decodeIfPresent(String.self, forKey: "runtimeName")
		self.runtimeIdentifier = try values.decodeIfPresent(String.self, forKey: "runtimeIdentifier")
		self.kind = try values.decodeIfPresent(CiTestDestinationKind.self, forKey: "kind")
	}

	public func encode(to encoder: Encoder) throws {
		var values = encoder.container(keyedBy: StringCodingKey.self)
		try values.encodeIfPresent(deviceTypeName, forKey: "deviceTypeName")
		try values.encodeIfPresent(deviceTypeIdentifier, forKey: "deviceTypeIdentifier")
		try values.encodeIfPresent(runtimeName, forKey: "runtimeName")
		try values.encodeIfPresent(runtimeIdentifier, forKey: "runtimeIdentifier")
		try values.encodeIfPresent(kind, forKey: "kind")
	}
}
