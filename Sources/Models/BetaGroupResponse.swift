//
//  BetaGroupResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
struct BetaGroupResponse: Decodable {

    /// (Required) The resource data.
    let data: BetaGroup

    /// The requested relationship data.￼
    ///  Possible types: App, Build, BetaTester
    let include: [BetaGroupResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    let links: DocumentLinks
    
    enum Included: Decodable {
        case app(App)
        case build(Build)
        case betaTester(BetaTester)
        init(from decoder: Decoder) throws {
            if let app = try? App(from: decoder) {
                self = .app(app)
                return
            }
            
            if let build = try? Build(from: decoder) {
                self = .build(build)
                return
            }
            
            if let betaTester = try? BetaTester(from: decoder) {
                self = .betaTester(betaTester)
                return
            }
            
            throw DecodingError.typeMismatch(
                Included.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
            )
        }
    }
}
