//
//  BetaTesterResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
struct BetaTesterResponse: Decodable {

    /// (Required) The resource data.
    let data: BetaTester

    /// The requested relationship data.￼
    ///  Possible types: App, BetaGroup, Build
    let include: [BetaTesterResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    let links: DocumentLinks

}

extension BetaTesterResponse {
    
    enum Included: Decodable {
        case app(App)
        case betaGroup(BetaGroup)
        case build(Build)
        init(from decoder: Decoder) throws {
            if let wrapped = try? App(from: decoder) {
                self = .app(wrapped)
                return
            }
            
            if let wrapped = try? BetaGroup(from: decoder) {
                self = .betaGroup(wrapped)
                return
            }

            
            if let wrapped = try? Build(from: decoder) {
                self = .build(wrapped)
                return
            }
            
            throw DecodingError.typeMismatch(
                Included.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
            )
        }
    }
}
