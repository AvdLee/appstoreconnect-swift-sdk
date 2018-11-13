//
//  ImageAsset.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 12/11/2018.
//

import Foundation
    
/// An image asset, including its height, width, and template URL.
public struct ImageAsset: Decodable {

    /// string
    public let templateUrl: String?

    /// integer
    public let height: Int?

    /// integer
    public let width: Int?
}
