import Foundation
import OrderedCollections

extension JSONValue {
    /// Serializes the value to JSON bytes in the same key order held by the `.object` dictionaries.
    public func toJSONData(prettyPrinted: Bool = false) throws -> Data {
        var out = ""
        out.reserveCapacity(1024)
        _OrderPreservingJSONWriter.write(self, to: &out, prettyPrinted: prettyPrinted, indentLevel: 0)
        return Data(out.utf8)
    }
}

private enum _OrderPreservingJSONWriter {
    static func write(_ v: JSONValue, to out: inout String, prettyPrinted: Bool, indentLevel: Int) {
        switch v {
        case .object(let obj):
            out.append("{")
            if prettyPrinted, !obj.isEmpty { out.append("\n") }
            var first = true
            for (k, vv) in obj {
                if !first { out.append(prettyPrinted ? ",\n" : ",") }
                first = false
                if prettyPrinted { out.append(String(repeating: "  ", count: indentLevel + 1)) }
                writeString(k, to: &out)
                out.append(prettyPrinted ? ": " : ":")
                write(vv, to: &out, prettyPrinted: prettyPrinted, indentLevel: indentLevel + 1)
            }
            if prettyPrinted, !obj.isEmpty {
                out.append("\n")
                out.append(String(repeating: "  ", count: indentLevel))
            }
            out.append("}")

        case .array(let arr):
            out.append("[")
            if prettyPrinted, !arr.isEmpty { out.append("\n") }
            for i in arr.indices {
                if i != arr.startIndex { out.append(prettyPrinted ? ",\n" : ",") }
                if prettyPrinted { out.append(String(repeating: "  ", count: indentLevel + 1)) }
                write(arr[i], to: &out, prettyPrinted: prettyPrinted, indentLevel: indentLevel + 1)
            }
            if prettyPrinted, !arr.isEmpty {
                out.append("\n")
                out.append(String(repeating: "  ", count: indentLevel))
            }
            out.append("]")

        case .string(let s):
            writeString(s, to: &out)

        case .number(let s):
            // Stored as a JSON lexical number; emit as-is.
            out.append(s)

        case .bool(let b):
            out.append(b ? "true" : "false")

        case .null:
            out.append("null")
        }
    }

    private static func writeString(_ s: String, to out: inout String) {
        out.append("\"")
        for scalar in s.unicodeScalars {
            switch scalar {
            case "\"": out.append("\\\"")
            case "\\": out.append("\\\\")
            case "\n": out.append("\\n")
            case "\r": out.append("\\r")
            case "\t": out.append("\\t")
            default:
                if scalar.value < 0x20 {
                    out.append("\\u")
                    out.append(String(format: "%04X", scalar.value))
                } else {
                    out.append(String(scalar))
                }
            }
        }
        out.append("\"")
    }
}


