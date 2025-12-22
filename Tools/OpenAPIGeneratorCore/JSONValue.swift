import Foundation
import OrderedCollections

public enum JSONValue: Equatable {
    case object(OrderedDictionary<String, JSONValue>)
    case array([JSONValue])
    case string(String)
    case number(Double)
    case bool(Bool)
    case null
}

extension JSONValue {
    public var objectValue: OrderedDictionary<String, JSONValue>? {
        guard case .object(let o) = self else { return nil }
        return o
    }

    public var arrayValue: [JSONValue]? {
        guard case .array(let a) = self else { return nil }
        return a
    }

    public var stringValue: String? {
        guard case .string(let s) = self else { return nil }
        return s
    }

    public var boolValue: Bool? {
        guard case .bool(let b) = self else { return nil }
        return b
    }
}

// MARK: - Codable

extension JSONValue: Codable {
    public init(from decoder: Decoder) throws {
        // Order-preserving decoding is best-effort; `OpenAPIGeneratorCore` uses
        // `JSONSerialization` + `init(foundationObject:)` for strict order round-trips.
        if let keyed = try? decoder.container(keyedBy: DynamicCodingKey.self) {
            var ordered = OrderedDictionary<String, JSONValue>()
            ordered.reserveCapacity(keyed.allKeys.count)
            for k in keyed.allKeys {
                ordered[k.stringValue] = try keyed.decode(JSONValue.self, forKey: k)
            }
            self = .object(ordered)
            return
        }

        if var unkeyed = try? decoder.unkeyedContainer() {
            var arr: [JSONValue] = []
            while !unkeyed.isAtEnd {
                arr.append(try unkeyed.decode(JSONValue.self))
            }
            self = .array(arr)
            return
        }

        let single = try decoder.singleValueContainer()
        if single.decodeNil() {
            self = .null
        } else if let b = try? single.decode(Bool.self) {
            self = .bool(b)
        } else if let d = try? single.decode(Double.self) {
            self = .number(d)
        } else {
            self = .string(try single.decode(String.self))
        }
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .object(let obj):
            var c = encoder.container(keyedBy: DynamicCodingKey.self)
            for (k, v) in obj {
                try c.encode(v, forKey: DynamicCodingKey(k))
            }
        case .array(let arr):
            var c = encoder.unkeyedContainer()
            for v in arr {
                try c.encode(v)
            }
        case .string(let s):
            var c = encoder.singleValueContainer()
            try c.encode(s)
        case .number(let d):
            var c = encoder.singleValueContainer()
            try c.encode(d)
        case .bool(let b):
            var c = encoder.singleValueContainer()
            try c.encode(b)
        case .null:
            var c = encoder.singleValueContainer()
            try c.encodeNil()
        }
    }
}

private struct DynamicCodingKey: CodingKey, Hashable {
    var stringValue: String
    var intValue: Int? { nil }

    init(_ string: String) {
        self.stringValue = string
    }

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        return nil
    }
}


