import Foundation

/// An App Store Connect metric dimension may identify its resource by ID or by a resource object.
public struct MetricDimensionData: Codable, Equatable {
    public let id: String
    public let type: String?
    private let isString: Bool

    public init(id: String, type: String? = nil) {
        self.id = id
        self.type = type
        self.isString = false
    }

    public init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer()
        if let id = try? value.decode(String.self) {
            self.id = id
            self.type = nil
            self.isString = true
        } else {
            let resource = try value.decode(Resource.self)
            self.id = resource.id
            self.type = resource.type
            self.isString = false
        }
    }

    public func encode(to encoder: Encoder) throws {
        var value = encoder.singleValueContainer()
        if isString {
            try value.encode(id)
        } else {
            try value.encode(Resource(id: id, type: type))
        }
    }

    private struct Resource: Codable {
        let id: String
        let type: String?
    }
}
