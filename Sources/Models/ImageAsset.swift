//
//  ImageAsset.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// An image asset, including its height, width, and template URL.
struct ImageAsset: Decodable {

    /// string
    let templateUrl: String?

    /// integer
    let height: Int?

    /// integer
    let width: Int?

}
