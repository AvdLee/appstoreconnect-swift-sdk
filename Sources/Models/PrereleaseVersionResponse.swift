//
//  PrereleaseVersionResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct PrereleaseVersionResponse: Decodable {

    /// (Required) The resource data.
    public let data: PrereleaseVersion

    /// The requested relationship data.￼
    ///  Possible types: Build, App
    public let include: [PrereleaseVersionResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
    
    public enum Included: Decodable {
        case build(Build)
        case app(App)
        
        public init(from decoder: Decoder) throws {
            enum TypeCodingKeys: String, CodingKey { case type }
            
            switch try decoder.container(keyedBy: TypeCodingKeys.self).decode(String.self, forKey: .type) {
            case "builds":
                self = try .build(Build(from: decoder))
            case "apps":
                self = try .app(App(from: decoder))
            default:
                throw DecodingError.typeMismatch(
                    Included.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
                )
            }
        }
    }
}

extension PrereleaseVersionResponse.Included {

    public var build: Build? {
        switch self {
        case .build(let value):
            return value
        default:
            return nil
        }
    }
    
    public var app: App? {
        switch self {
        case .app(let value):
            return value
        default:
            return nil
        }
    }
}
