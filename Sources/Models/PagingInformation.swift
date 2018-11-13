//
//  PagingInformation.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// Paging information for data responses.
struct PagingInformation: Decodable {

    /// (Required) The paging information details.
    let paging: PagingInformation.Paging

    /// Paging details such as the total number of resources and the per-page limit.
    struct Paging: Decodable {
    
        /// (Required) The total number of resources matching your request.
        let total: Int
    
        /// (Required) The maximum number of resources to return per page, from 0 to 200.
        let limit: Int
    }
}
