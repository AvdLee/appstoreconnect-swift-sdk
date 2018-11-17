//
//  BetaTestersResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of resources.
public struct BetaTestersResponse: Decodable {

    /// (Required) The resource data.
    public let data: [BetaTester]

    /// The requested relationship data.￼
    ///  Possible types: App, BetaGroup, Build
    public let include: [BetaTestersResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    public let links: PagedDocumentLinks

    /// Paging information.
    public let meta: PagingInformation?
    
    public enum Included: Decodable {
        case app(App)
        case betaGroup(BetaGroup)
        case build(Build)
        
        public init(from decoder: Decoder) throws {
            enum CodingKeys: String, Decodable, CodingKey {
                case type
                case apps, betaGroups, builds
            }
            
            switch try decoder.container(keyedBy: CodingKeys.self).decode(CodingKeys.self, forKey: .type) {
            case .apps:
                self = try .app(App(from: decoder))
            case .betaGroups:
                self = try .betaGroup(BetaGroup(from: decoder))
            case .builds:
                self = try .build(Build(from: decoder))
            default:
                throw DecodingError.typeMismatch(
                    Included.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
                )
            }
        }
    }
}

extension BetaTestersResponse.Included {
    
    public var app: App? {
        switch self {
        case .app(let value):
            return value
        default:
            return nil
        }
    }
    
    public var betaGroup: BetaGroup? {
        switch self {
        case .betaGroup(let value):
            return value
        default:
            return nil
        }
    }
    
    public var build: Build? {
        switch self {
        case .build(let value):
            return value
        default:
            return nil
        }
    }
}
