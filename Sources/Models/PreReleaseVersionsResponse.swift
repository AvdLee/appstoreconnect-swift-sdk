//
//  PreReleaseVersionsResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of resources.
public struct PreReleaseVersionsResponse: Decodable {

    /// (Required) The resource data.
    public let data: [PrereleaseVersion]

    /// The requested relationship data.￼
    ///  Possible types: Build, App
    public let include: [PreReleaseVersionsResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
    
    public enum Included: Decodable {
        case build(Build)
        case app(App)
        
        public init(from decoder: Decoder) throws {
            enum CodingKeys: String, Decodable, CodingKey {
                case type
                case builds, apps
            }
            
            switch try decoder.container(keyedBy: CodingKeys.self).decode(CodingKeys.self, forKey: .type) {
            case .builds:
                self = try .build(Build(from: decoder))
            case .apps:
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

extension PreReleaseVersionsResponse.Included {

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
