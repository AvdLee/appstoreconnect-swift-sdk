//
//  RateLimit.swift
//  
//
//  Created by Mathias Emil Mortensen on 05/04/2023.
//

import Foundation

public struct RateLimit {
    /// Number of requests you can make per hour with the same API key.
    public let hourlyLimit: Int
    
    /// Number of requests remaining. The time frame is a "rolling hour."
    public let remainingInCurrentHour: Int
    
    /// The url of the request the rate limit were returned for.
    public let requestURL: URL?
    
    init?(value: String, requestURL: URL?) {
        let components = value.split(separator: ";", omittingEmptySubsequences: true)
        
        guard
            let limitString = components.value(for: "user-hour-lim:"),
            let remainingString = components.value(for: "user-hour-rem:")
        else {
            return nil
        }
        
        guard
            let limit = Int(limitString),
            let remaining = Int(remainingString)
        else {
            return nil
        }
        
        hourlyLimit = limit
        remainingInCurrentHour = remaining
        self.requestURL = requestURL
    }
}

private extension Sequence where Element == String.SubSequence {
    func value(for key: String) -> String? {
        first(where: { $0.contains(key) }).map { $0.replacingOccurrences(of: key, with: "") }
    }
}
