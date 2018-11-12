//
//  BuildIndividualTestersLinkagesResponse.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// A response containing a list of related resource IDs.
struct BuildIndividualTestersLinkagesResponse: Decodable {

    /// (Required) The object types and IDs of the related resources.
    let data: [BuildIndividualTestersLinkagesResponse.Data]

    /// (Required) Navigational links including the self-link and links to the related data.
    let links: PagedDocumentLinks

    /// Paging information.
    let meta: PagingInformation?

}

extension BuildIndividualTestersLinkagesResponse {
    
    struct Data: Decodable {
    
        /// (Required) The opaque resource ID that uniquely identifies the resource.
        let `id`: String
    
        /// (Required) The resource type.Value: betaTesters
        let type: String
    
    }
}
