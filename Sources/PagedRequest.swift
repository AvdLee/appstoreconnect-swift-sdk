//
//  PagedRequest.swift
//  
//
//  Created by Andy Johnson on 05/08/2022.
//

import Foundation

/// An AsyncSequence of responses to requests from an API endpoint
///
/// If the endpoint generates more than a single page of responses the sequence will emit each response page in turn until all have been received.
public struct PagedRequest<T>: AsyncSequence, AsyncIteratorProtocol where T: Decodable {
    public typealias Element = T
    
    let request: Request<T>
    let provider: APIProvider
    
    init(request: Request<T>, provider: APIProvider) {
        self.request = request
        self.provider = provider
    }
    
    private var currentElement: T!
    
    public mutating func next() async throws -> T? {
        guard !Task.isCancelled else {
            return nil
        }
                    
        if let current = currentElement {
            currentElement = try await provider.request(request, pageAfter: current)
        } else {
            currentElement = try await provider.request(request)
        }
        
        return currentElement
    }
    
    public func makeAsyncIterator() -> Self {
        self
    }
}
