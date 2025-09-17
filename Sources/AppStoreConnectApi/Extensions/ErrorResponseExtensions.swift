//
//  ErrorResponseExtensions.swift
//  
//
//  Created by Antoine van der Lee on 29/07/2022.
//

import AppStoreConnectApiCore
import Foundation

extension ErrorResponse: CustomStringConvertible {
    public var description: String {
        var errorString = "Related response error(s):"
        errors?.forEach({ error in
            errorString.append("""
        \n\nThe request failed with response code \(error.status) \(error.code)

        \(error.title). \(error.detail)
        """)
        })
        return errorString
    }
}

extension ErrorResponse: ErrorResponseInterface {}
extension ErrorResponse.Error: ErrorResponseErrorItemInterface {}
