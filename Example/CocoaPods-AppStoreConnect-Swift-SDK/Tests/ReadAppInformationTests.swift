//
//  ReadAppInformationTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 23/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

class ReadAppInformationTests: XCTestCase {

    func testReadAppInformationEndpoint() {

        let preReleaseVersionsLimit = 2
        let buildsLimit = 3
        let betaGroupsLimit = 4
        let betaAppLocalizationsLimit = 5
        
        let expectedParams: [String: String] = [
            "fields[apps]": ListApps.Field.Apps.allCases.map({ $0.rawValue }).joinedByCommas(),
            "fields[betaLicenseAgreements]": ListApps.Field.BetaLicenseAgreements.allCases.map({ $0.rawValue }).joinedByCommas(),
            "include": ListApps.Relationship.allCases.map({ $0.rawValue }).joinedByCommas(),
            "fields[preReleaseVersions]": ListApps.Field.PreReleaseVersions.allCases.map({ $0.rawValue }).joinedByCommas(),
            "limit[preReleaseVersions]": "\(preReleaseVersionsLimit)",
            "fields[betaAppReviewDetails]": ListApps.Field.BetaAppReviewDetails.allCases.map({ $0.rawValue }).joinedByCommas(),
            "fields[betaAppLocalizations]": ListApps.Field.BetaAppLocalizations.allCases.map({ $0.rawValue }).joinedByCommas(),
            "fields[builds]": ListApps.Field.Builds.allCases.map({ $0.rawValue }).joinedByCommas(),
            "fields[betaGroups]": ListApps.Field.BetaGroups.allCases.map({ $0.rawValue }).joinedByCommas(),
            "limit[builds]": "\(buildsLimit)",
            "limit[betaGroups]": "\(betaGroupsLimit)",
            "limit[betaAppLocalizations]": "\(betaAppLocalizationsLimit)"
        ]
        let appId = "appId"
        let appInformation = APIEndpoint<AppResponse>.app(
            with: appId,
            select: [
                .apps(ReadAppInformation.Field.Apps.allCases),
                .betaLicenseAgreements(ReadAppInformation.Field.BetaLicenseAgreements.allCases),
                .preReleaseVersions(ReadAppInformation.Field.PreReleaseVersions.allCases),
                .betaAppReviewDetails(ReadAppInformation.Field.BetaAppReviewDetails.allCases),
                .betaAppLocalizations(ReadAppInformation.Field.BetaAppLocalizations.allCases),
                .builds(ReadAppInformation.Field.Builds.allCases),
                .betaGroups(ReadAppInformation.Field.BetaGroups.allCases)],
            include: ReadAppInformation.Relationship.allCases,
            limits: [
                .preReleaseVersions(preReleaseVersionsLimit),
                .builds(buildsLimit),
                .betaGroups(betaGroupsLimit),
                .betaAppLocalizations(betaAppLocalizationsLimit)])
        
        XCTAssertEqual(appInformation.method, .get)
        XCTAssertEqual(appInformation.path, "apps/\(appId)")
        XCTAssertNotNil(appInformation.parameters)
        if let listAppsParameters = appInformation.parameters as? [String: String] {
            XCTAssertEqual(listAppsParameters.count, expectedParams.count)
            for (key, value) in expectedParams {
                XCTAssertEqual(listAppsParameters[key], value)
            }
        }
    }
}
