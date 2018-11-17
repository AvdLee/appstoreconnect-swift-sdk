//
//  Endpoint.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 16/11/2018.
//

import Alamofire

public class Endpoint<T: Decodable> {
    
    init() {}
    
    func path() -> String {
        fatalError()
    }
    
    var parameters = [String: Any]()
    
    @discardableResult
    public func request(using provider: APIProvider, completion: @escaping Handler<T>) -> DataRequest {
        let endpoint = APIEndpoint<T>(path: path(), parameters: parameters)
        return provider.request(endpoint, completion: completion)
    }
}
