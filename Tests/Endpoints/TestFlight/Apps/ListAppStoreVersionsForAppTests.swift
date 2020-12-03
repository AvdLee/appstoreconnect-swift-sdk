//
//  ListAppStoreVersionsForAppTests.swift
//  AppStoreConnect-Swift-SDKTests
//
//  Created by Dawid Cieslak on 26/11/2020.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListAppStoreVersionsForAppTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.appStoreVersions(
            ofAppWithId: "APP_ID",
            fields: [
                .appStoreVersions(ListAppStoreVersionsOfApp.Field.AppStoreVersion.allCases)
            ],
            filters: [
                .appStoreState(AppStoreVersionState.allCases),
                .platform(Platform.allCases)
            ],
            limit: 10,
            next: .test
        )
        
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/apps/APP_ID/appStoreVersions?cursor=NEXT&fields%5BappStoreVersions%5D=ageRatingDeclaration%2Capp%2CappStoreReviewDetail%2CappStoreState%2CappStoreVersionLocalizations%2CappStoreVersionPhasedRelease%2CappStoreVersionSubmission%2Cbuild%2Ccopyright%2CcreatedDate%2Cdownloadable%2CearliestReleaseDate%2CidfaDeclaration%2Cplatform%2CreleaseType%2CroutingAppCoverage%2CusesIdfa%2CversionString&filter%5BappStoreState%5D=DEVELOPER_REMOVED_FROM_SALE%2CDEVELOPER_REJECTED%2CIN_REVIEW%2CINVALID_BINARY%2CMETADATA_REJECTED%2CPENDING_APPLE_RELEASE%2CPENDING_CONTRACT%2CPENDING_DEVELOPER_RELEASE%2CPREPARE_FOR_SUBMISSION%2CPREORDER_READY_FOR_SALE%2CPROCESSING_FOR_APP_STORE%2CREADY_FOR_SALE%2CREJECTED%2CREMOVED_FROM_SALE%2CWAITING_FOR_EXPORT_COMPLIANCE%2CWAITING_FOR_REVIEW%2CREPLACED_WITH_NEW_VERSION&filter%5Bplatform%5D=IOS%2CMAC_OS%2CTV_OS%2CWATCH_OS&limit=10"
        XCTAssertEqual(absoluteString, expected)
    }
}
