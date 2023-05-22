//
//  HTTPURLResponseExtensions.swift
//  
//
//  Created by Mathias Emil Mortensen on 10/04/2023.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

extension HTTPURLResponse {
    var rateLimit: RateLimit? {
        if let value = value(forHTTPHeaderField: "X-Rate-Limit") {
            return RateLimit(value: value, requestURL: url)
        } else {
            return nil
        }
    }
}
