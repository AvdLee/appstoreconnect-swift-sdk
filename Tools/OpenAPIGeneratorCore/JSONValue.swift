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

extension JSONValue {
    /// Builds an order-preserving `JSONValue` tree from a Foundation JSON object
    /// (`NSDictionary`/`NSArray`/`NSString`/`NSNumber`/`NSNull`), preserving the
    /// enumeration order of `NSDictionary` as the insertion order of the resulting `OrderedDictionary`.
    public init(foundationObject: Any) {
        switch foundationObject {
        case let dict as NSDictionary:
            var ordered = OrderedDictionary<String, JSONValue>()
            ordered.reserveCapacity(dict.count)
            for (k, v) in dict {
                guard let key = k as? String else { continue }
                ordered[key] = JSONValue(foundationObject: v)
            }
            self = .object(ordered)
        case let array as NSArray:
            self = .array(array.map { JSONValue(foundationObject: $0) })
        case let s as NSString:
            self = .string(s as String)
        case let n as NSNumber:
            // NSNumber can represent both Bool and numeric values.
            if CFGetTypeID(n) == CFBooleanGetTypeID() {
                self = .bool(n.boolValue)
            } else {
                self = .number(n.doubleValue)
            }
        case _ as NSNull:
            self = .null
        default:
            // If JSONSerialization produced something unexpected, treat it as null rather than crash.
            self = .null
        }
    }

    /// Converts the value into a Foundation JSON object suitable for `JSONSerialization`.
    /// Objects are emitted as `NSMutableDictionary` with keys inserted in `OrderedDictionary` order.
    public func toFoundationObject() -> Any {
        switch self {
        case .object(let obj):
            let dict = NSMutableDictionary(capacity: obj.count)
            for (k, v) in obj {
                dict[k] = v.toFoundationObject()
            }
            return dict
        case .array(let arr):
            let out = NSMutableArray(capacity: arr.count)
            for v in arr {
                out.add(v.toFoundationObject())
            }
            return out
        case .string(let s):
            return s
        case .number(let d):
            return NSNumber(value: d)
        case .bool(let b):
            return NSNumber(value: b)
        case .null:
            return NSNull()
        }
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


