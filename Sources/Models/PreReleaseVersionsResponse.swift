//
//  PreReleaseVersionsResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of resources.
struct PreReleaseVersionsResponse: Decodable {

    /// (Required) The resource data.
    let data: [PrereleaseVersion]

    /// The requested relationship data.￼
    ///  Possible types: Build, App
    let include: [PreReleaseVersionsResponse.Included]?

    /// (Required) Navigational links that include the self-link.
    let links: PagedDocumentLinks

    /// Paging information.
    let meta: PagingInformation?
    
    enum Included: Decodable {
        case build(Build)
        case app(App)
        init(from decoder: Decoder) throws {
            if let wrapped = try? Build(from: decoder) {
                self = .build(wrapped)
                return
            }
            
            if let wrapped = try? App(from: decoder) {
                self = .app(wrapped)
                return
            }

            throw DecodingError.typeMismatch(
                Included.self,
                DecodingError.Context(codingPath: [], debugDescription: "Not convertable to \(Included.self)")
            )
        }
    }
}
