//
//  BuildResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a single resource.
struct BuildResponse: Decodable {

    /// (Required) The resource data.
    let data: Build

    /// The requested relationship data.￼
    ///  Possible types: PrereleaseVersion, BetaTester, BetaBuildLocalization, AppEncryptionDeclaration, BetaAppReviewSubmission, App, BuildBetaDetail
    let include: [BuildResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    let links: DocumentLinks
    
    enum Included: Decodable {
        case app(App)
        case build(Build)
        case betaTester(BetaTester)
        init(from decoder: Decoder) throws {
            if let wrapped = try? App(from: decoder) {
                self = .app(wrapped)
                return
            }
            
            if let wrapped = try? Build(from: decoder) {
                self = .build(wrapped)
                return
            }
            
            if let wrapped = try? BetaTester(from: decoder) {
                self = .betaTester(wrapped)
                return
            }
            
            throw DecodingError.typeMismatch(
                Included.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
            )
        }
    }
}
