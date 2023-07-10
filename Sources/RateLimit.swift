//
//  RateLimit.swift
//  
//
//  Created by Mathias Emil Mortensen on 05/04/2023.
//

import Foundation

public struct RateLimit: Codable {
    /// Rate limit entries
    public let entries: [String: Int]

    /// The url of the request the rate limit were returned for.
    public let requestURL: URL?

    init(value: String, requestURL: URL?) {
        self.requestURL = requestURL

        let items = value.split(separator: ",", omittingEmptySubsequences: true).flatMap {
            $0.trimmingCharacters(in: CharacterSet.whitespaces)
                .split(separator: ";", omittingEmptySubsequences: true)
                .map({ $0.trimmingCharacters(in: CharacterSet.whitespaces) })
        }
        entries = items.reduce(into: [:]) { partialResult, item in
            guard let colonIdx = item.firstIndex(of: ":") else {
                return
            }
            let key = item[..<colonIdx]
            let valueString = item[item.index(after: colonIdx)...]
            guard let value = Int(valueString) else {
                return
            }
            partialResult[String(key)] = value
        }
    }
}
