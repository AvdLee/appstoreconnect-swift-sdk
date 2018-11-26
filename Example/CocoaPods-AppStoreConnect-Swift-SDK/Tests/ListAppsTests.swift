//
//  ListAppsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 22/11/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ListAppsTests: XCTestCase {
    
    func testListAppsEndpoint() {
        let bundleIds = ["bundleId"]
        let ids = ["id"]
        let names = ["name"]
        let skus = ["sku"]
        let appsLimit = 1
        let preReleaseVersionsLimit = 2
        let buildsLimit = 3
        let betaGroupsLimit = 4
        let betaAppLocalizationsLimit = 5
        
        let expectedParams: [String: String] = [
            "fields[apps]": ListApps.Field.Apps.allCases.map({ $0.rawValue }).joinedByCommas(),
            "fields[betaLicenseAgreements]": ListApps.Field.BetaLicenseAgreements.allCases.map({ $0.rawValue }).joinedByCommas(),
            "filter[bundleId]": bundleIds.joinedByCommas(),
            "filter[id]": ids.joinedByCommas(),
            "filter[name]": names.joinedByCommas(),
            "filter[sku]": skus.joinedByCommas(),
            "include": ListApps.Relationship.allCases.map({ $0.rawValue }).joinedByCommas(),
            "limit": "\(appsLimit)",
            "sort": ListApps.Sorting.allCases.map({ $0.rawValue }).joinedByCommas(),
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

        let listApps = APIEndpoint<AppsResponse>.apps(
            select: [
                .apps(ListApps.Field.Apps.allCases),
                .betaLicenseAgreements(ListApps.Field.BetaLicenseAgreements.allCases),
                .preReleaseVersions(ListApps.Field.PreReleaseVersions.allCases),
                .betaAppReviewDetails(ListApps.Field.BetaAppReviewDetails.allCases),
                .betaAppLocalizations(ListApps.Field.BetaAppLocalizations.allCases),
                .builds(ListApps.Field.Builds.allCases),
                .betaGroups(ListApps.Field.BetaGroups.allCases)],
            filters: [
                .bundleId(bundleIds),
                .id(ids),
                .name(names),
                .sku(skus)],
            include: ListApps.Relationship.allCases,
            sortBy: ListApps.Sorting.allCases,
            limits: [
                .apps(appsLimit),
                .preReleaseVersions(preReleaseVersionsLimit),
                .builds(buildsLimit),
                .betaGroups(betaGroupsLimit),
                .betaAppLocalizations(betaAppLocalizationsLimit)])
        
        XCTAssertEqual(listApps.method, .get)
        XCTAssertEqual(listApps.path, "apps")
        XCTAssertNotNil(listApps.parameters)
        if let listAppsParameters = listApps.parameters as? [String: String] {
            XCTAssertEqual(listAppsParameters.count, expectedParams.count)
            for (key, value) in expectedParams {
                XCTAssertEqual(listAppsParameters[key], value)
            }
        }
    }
}