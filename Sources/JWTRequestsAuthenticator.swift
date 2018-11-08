//
//  JWTAuthenticator.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Antoine van der Lee on 08/11/2018.
//

import Foundation
import Alamofire

final class JWTRequestsAuthenticator {

    enum Error: Swift.Error {
        case bearerGenerationFailed
    }

    private var cachedBearer: Bearer?

    func createBearer() throws -> Bearer {
        if let cachedBearer = cachedBearer, !cachedBearer.isExpired {
            return cachedBearer
        }

        throw Error.bearerGenerationFailed
    }
}

extension JWTRequestsAuthenticator: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let bearer = try createBearer()
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + bearer, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}
