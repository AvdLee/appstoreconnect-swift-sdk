//
//  ReadAppInfoOfAppTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Dawid Cieslak on 26/11/2020.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ReadAppInfoOfAppTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.appInfo(
            appInfoId: "appInfoId",
            fields: [
                .appInfos(AppInfoForApp.Field.AppInfo.allCases),
                .appCategories(AppInfoForApp.Field.AppCategory.allCases),
                .appInfoLocalizations(AppInfoForApp.Field.AppInfoLocalization.allCases)
            ],
            include: AppInfoForApp.Relationship.allCases,
            next: .test
        )
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appInfos/appInfoId?cursor=NEXT&fields%5BappCategories%5D=parent%2Cplatforms%2Csubcategories&fields%5BappInfoLocalizations%5D=appInfo%2Clocale%2Cname%2CprivacyPolicyText%2CprivacyPolicyUrl%2Csubtitle&fields%5BappInfos%5D=app%2CappInfoLocalizations%2CappStoreAgeRating%2CappStoreState%2CbrazilAgeRating%2CkidsAgeBand%2CprimaryCategory%2CprimarySubcategoryOne%2CprimarySubcategoryTwo%2CsecondaryCategory%2CsecondarySubcategoryOne%2CsecondarySubcategoryTwo&include=app%2CappInfoLocalizations%2CprimaryCategory%2CprimarySubcategoryOne%2CprimarySubcategoryTwo%2CsecondaryCategory%2CsecondarySubcategoryOne%2CsecondarySubcategoryTwo"
        XCTAssertEqual(absoluteString, expected)
    }
}
