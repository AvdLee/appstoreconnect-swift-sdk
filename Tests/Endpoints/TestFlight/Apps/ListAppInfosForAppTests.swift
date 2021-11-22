//
//  ReadAppInfoOfAppTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Dawid Cieslak on 26/11/2020.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListAppInfosForAppTests: XCTestCase {

    func testURLRequest() {
        let endpoint = APIEndpoint.appInfos(
            forAppWithId: "appId",
            fields: [
                ListAppInfosForApp.Field.appInfos(ListAppInfosForApp.Field.AppInfo.allCases),
                ListAppInfosForApp.Field.apps(ListAppInfosForApp.Field.App.allCases),
                ListAppInfosForApp.Field.appInfoLocalizations(ListAppInfosForApp.Field.AppInfoLocalization.allCases),
                ListAppInfosForApp.Field.appCategories(ListAppInfosForApp.Field.AppCategory.allCases)
            ],
            include: ListAppInfosForApp.Relationship.allCases,
            limit: 10,
            next: .test
        )
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/appId/appInfos?cursor=NEXT&fields%5BappCategories%5D=parent%2Cplatforms%2Csubcategories&fields%5BappInfoLocalizations%5D=appInfo%2Clocale%2Cname%2CprivacyPolicyText%2CprivacyPolicyUrl%2Csubtitle&fields%5BappInfos%5D=app%2CappInfoLocalizations%2CappStoreAgeRating%2CappStoreState%2CbrazilAgeRating%2CkidsAgeBand%2CprimaryCategory%2CprimarySubcategoryOne%2CprimarySubcategoryTwo%2CsecondaryCategory%2CsecondarySubcategoryOne%2CsecondarySubcategoryTwo&fields%5Bapps%5D=appInfos%2CappStoreVersions%2CavailableInNewTerritories%2CavailableTerritories%2CbetaAppLocalizations%2CbetaAppReviewDetail%2CbetaGroups%2CbetaLicenseAgreement%2CbetaTesters%2Cbuilds%2CbundleId%2CcontentRightsDeclaration%2CendUserLicenseAgreement%2CgameCenterEnabledVersions%2CinAppPurchases%2CisOrEverWasMadeForKids%2Cname%2CperfPowerMetrics%2CpreOrder%2CpreReleaseVersions%2Cprices%2CprimaryLocale%2Csku&include=app%2CappInfoLocalizations%2CprimaryCategory%2CprimarySubcategoryOne%2CprimarySubcategoryTwo%2CsecondaryCategory%2CsecondarySubcategoryOne%2CsecondarySubcategoryTwo&limit=10"
        XCTAssertEqual(absoluteString, expected)
    }
}
