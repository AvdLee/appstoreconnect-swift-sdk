//
//  BetaGroupResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
public struct BetaGroupResponse: Decodable {

    /// (Required) The resource data.
    public let data: BetaGroup

    /// The requested relationship data.￼
    ///  Possible types: App, Build, BetaTester
    public let include: [BetaGroupResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    public let links: DocumentLinks
    
    public enum Included: Decodable {
        case app(App)
        case build(Build)
        case betaTester(BetaTester)
        
        public init(from decoder: Decoder) throws {
            enum CodingKeys: String, Decodable, CodingKey {
                case type
                case apps, builds, betaTesters
            }
            
            switch try decoder.container(keyedBy: CodingKeys.self).decode(CodingKeys.self, forKey: .type) {
            case .apps:
                self = try .app(App(from: decoder))
            case .builds:
                self = try .build(Build(from: decoder))
            case .betaTesters:
                self = try .betaTester(BetaTester(from: decoder))
            default:
                throw DecodingError.typeMismatch(
                    Included.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
                )
            }
        }
    }
}

extension BetaGroupResponse.Included {
    
    public var app: App? {
        switch self {
        case .app(let value):
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
    
    public var betaTester: BetaTester? {
        switch self {
        case .betaTester(let value):
            return value
        default:
            return nil
        }
    }
}
