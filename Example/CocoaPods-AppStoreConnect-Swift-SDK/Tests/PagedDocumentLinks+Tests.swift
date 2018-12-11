//
//  PagedDocumentLinks+Tests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Pascal Edmond on 11/12/2018.
//

import Foundation
@testable import AppStoreConnect_Swift_SDK

extension PagedDocumentLinks {
    static var test = PagedDocumentLinks(
        first: URL(string: "https://api.appstoreconnect.com?cursor=FIRST")!,
        next: URL(string: "https://api.appstoreconnect.com?cursor=NEXT")!,
        self: URL(string: "https://api.appstoreconnect.com")!)
}
