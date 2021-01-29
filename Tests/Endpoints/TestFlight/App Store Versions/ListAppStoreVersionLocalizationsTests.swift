//
//  ListAppStoreVersionLocalizationsTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Kirill Budevich on 1/29/21.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListAppStoreVersionLocalizationsTests: XCTestCase {
    
    func testURLRequestMethod() {
        let endpoint = APIEndpoint.appStoreVersionLocalizations(ofAppStoreVersionWithId: "appStoreId")
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
    }
    
    func testFilledParamsURLRequest() {
        let endpoint = APIEndpoint.appStoreVersionLocalizations(
            ofAppStoreVersionWithId: "appStoreId",
            fields: [
                .appStoreVersionLocalizations([
                    .appPreviewSets,
                    .appScreenshotSets,
                    .appStoreVersion,
                    .description,
                    .keywords,
                    .locale,
                    .marketingUrl,
                    .promotionalText,
                    .supportUrl,
                    .whatsNew
                ])
            ],
            limit: 50)
        let request = try? endpoint.asURLRequest()

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersions/appStoreId/appStoreVersionLocalizations?fields%5BappStoreVersionLocalizations%5D=appPreviewSets%2CappScreenshotSets%2CappStoreVersion%2Cdescription%2Ckeywords%2Clocale%2CmarketingUrl%2CpromotionalText%2CsupportUrl%2CwhatsNew&limit=50"
        XCTAssertEqual(absoluteString, expected)
    }
    
    func testEmptyParamsURLRequest() {
        let endpoint = APIEndpoint.appStoreVersionLocalizations(ofAppStoreVersionWithId: "appStoreId")
        let request = try? endpoint.asURLRequest()

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersions/appStoreId/appStoreVersionLocalizations"
        XCTAssertEqual(absoluteString, expected)
    }
}
