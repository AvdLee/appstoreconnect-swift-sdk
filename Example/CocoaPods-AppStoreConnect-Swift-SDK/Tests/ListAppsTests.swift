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
    
    /// It should report an invalid P8 private key.
    func testListAppsEndpoint() {
        let listApps = APIEndpoint<AppsResponse>.apps()
        XCTAssertEqual(listApps.method, .get)
        XCTAssertEqual(listApps.path, "apps")
    }
    
    func testListAppsFields() {
        XCTAssertEqual(ListApps.Field.key, "fields")
        
        // fields[apps]
        XCTAssertEqual(ListApps.Field.apps([]).pair.nestedKey, "apps")
        let fieldAppsCases = ListApps.Field.Apps.allCases.map { $0.rawValue }.sorted()
        let fieldAppsPossibleValues = ["betaAppLocalizations", "betaAppReviewDetail", "betaGroups", "betaLicenseAgreement", "betaTesters", "builds", "bundleId", "name", "preReleaseVersions", "primaryLocale", "sku"].sorted()
        XCTAssertEqual(fieldAppsCases, fieldAppsPossibleValues)
        
        // fields[betaLicenseAgreements]
        XCTAssertEqual(ListApps.Field.betaLicenseAgreements([]).pair.nestedKey, "betaLicenseAgreements")
        let fieldBetaLicenseAgreementsPossibleValues = ["agreementText", "app"].sorted()
        let fieldBetaLicenseAgreementsCases = ListApps.Field.BetaLicenseAgreements.allCases.map { $0.rawValue }.sorted()
        XCTAssertEqual(fieldBetaLicenseAgreementsCases, fieldBetaLicenseAgreementsPossibleValues)
        
        // fields[preReleaseVersions]
        XCTAssertEqual(ListApps.Field.preReleaseVersions([]).pair.nestedKey, "preReleaseVersions")
        let fieldPreReleaseVersionsPossibleValues = ["app", "builds", "platform", "version"].sorted()
        let fieldPreReleaseVersionsCases = ListApps.Field.PreReleaseVersions.allCases.map { $0.rawValue }.sorted()
        XCTAssertEqual(fieldPreReleaseVersionsCases, fieldPreReleaseVersionsPossibleValues)
        
        // fields[betaAppReviewDetails]
        XCTAssertEqual(ListApps.Field.betaAppReviewDetails([]).pair.nestedKey, "betaAppReviewDetails")
        let fieldBetaAppReviewDetailsPossibleValues = ["app", "contactEmail", "contactFirstName", "contactLastName", "contactPhone", "demoAccountName", "demoAccountPassword", "demoAccountRequired", "notes"].sorted()
        let fieldBetaAppReviewDetailsCases = ListApps.Field.BetaAppReviewDetails.allCases.map { $0.rawValue }.sorted()
        XCTAssertEqual(fieldBetaAppReviewDetailsCases, fieldBetaAppReviewDetailsPossibleValues)
        
        // fields[betaAppLocalizations]
        XCTAssertEqual(ListApps.Field.betaAppLocalizations([]).pair.nestedKey, "betaAppLocalizations")
        let fieldBetaAppLocalizationsPossibleValues = ["app", "description", "feedbackEmail", "locale", "marketingUrl", "privacyPolicyUrl", "tvOsPrivacyPolicy"].sorted()
        let fieldBetaAppLocalizationsCases = ListApps.Field.BetaAppLocalizations.allCases.map { $0.rawValue }.sorted()
        XCTAssertEqual(fieldBetaAppLocalizationsCases, fieldBetaAppLocalizationsPossibleValues)
        
        // fields[builds]
        XCTAssertEqual(ListApps.Field.builds([]).pair.nestedKey, "builds")
        let fieldBuildsPossibleValues = ["app", "appEncryptionDeclaration", "betaAppReviewSubmission", "betaBuildLocalizations", "betaGroups", "buildBetaDetail", "expirationDate", "expired", "iconAssetToken", "individualTesters", "minOsVersion", "preReleaseVersion", "processingState", "uploadedDate", "usesNonExemptEncryption", "version"].sorted()
        let fieldBuildsCases = ListApps.Field.Builds.allCases.map { $0.rawValue }.sorted()
        XCTAssertEqual(fieldBuildsCases, fieldBuildsPossibleValues)
        
        // fields[betaGroups]
        XCTAssertEqual(ListApps.Field.betaGroups([]).pair.nestedKey, "betaGroups")
        let fieldBetaGroupsPossibleValues = ["app", "betaTesters", "builds", "createdDate", "isInternalGroup", "name", "publicLink", "publicLinkEnabled", "publicLinkId", "publicLinkLimit", "publicLinkLimitEnabled"].sorted()
        let fieldBetaGroupsCases = ListApps.Field.BetaGroups.allCases.map { $0.rawValue }.sorted()
        XCTAssertEqual(fieldBetaGroupsCases, fieldBetaGroupsPossibleValues)
    }
    
    func testListAppsFilter() {
        XCTAssertEqual(ListApps.Filter.key, "filter")
        let filter = "test"
        
        // filter[bundleId]
        let bundleId = ListApps.Filter.bundleId([filter]).pair
        XCTAssertEqual(bundleId.nestedKey, "bundleId")
        XCTAssertEqual(bundleId.value as? String, filter)
        
        // filter[id]
        let id = ListApps.Filter.id([filter]).pair
        XCTAssertEqual(id.nestedKey, "id")
        XCTAssertEqual(id.value as? String, filter)
        
        // filter[name]
        let name = ListApps.Filter.name([filter]).pair
        XCTAssertEqual(name.nestedKey, "name")
        XCTAssertEqual(name.value as? String, filter)
        
        // filter[sku]
        let sku = ListApps.Filter.sku([filter]).pair
        XCTAssertEqual(sku.nestedKey, "sku")
        XCTAssertEqual(sku.value as? String, filter)
    }
    
    func testListAppsInclude() {
        XCTAssertEqual(ListApps.Relationship.key, "include")
        let fieldIncludeCases = ListApps.Relationship.allCases.map { $0.rawValue }.sorted()
        let fieldIncludePossibleValues = ["betaAppLocalizations", "betaAppReviewDetail", "betaGroups", "betaLicenseAgreement", "builds", "preReleaseVersions"].sorted()
        XCTAssertEqual(fieldIncludeCases, fieldIncludePossibleValues)
    }
    
    func testListAppsSort() {
        XCTAssertEqual(ListApps.Sorting.key, "sort")
        let fieldSortingCases = ListApps.Sorting.allCases.map { $0.rawValue }.sorted()
        let fieldSortingPossibleValues = ["+bundleId", "-bundleId", "+name", "-name", "+sku", "-sku"].sorted()
        XCTAssertEqual(fieldSortingCases, fieldSortingPossibleValues)
    }
    
    func testListAppsLimit() {
        XCTAssertEqual(ListApps.Limit.key, "limit")
        let limit = 42
        
        // limit
        let apps = ListApps.Limit.apps(limit).pair
        XCTAssertEqual(apps.nestedKey, nil)
        XCTAssertEqual(apps.value as? Int, limit)
        
        // limit[preReleaseVersions]
        let preReleaseVersions = ListApps.Limit.preReleaseVersions(limit).pair
        XCTAssertEqual(preReleaseVersions.nestedKey, "preReleaseVersions")
        XCTAssertEqual(preReleaseVersions.value as? Int, limit)
        
        // limit[builds]
        let builds = ListApps.Limit.builds(limit).pair
        XCTAssertEqual(builds.nestedKey, "builds")
        XCTAssertEqual(builds.value as? Int, limit)
        
        // limit[betaGroups]
        let betaGroups = ListApps.Limit.betaGroups(limit).pair
        XCTAssertEqual(betaGroups.nestedKey, "betaGroups")
        XCTAssertEqual(betaGroups.value as? Int, limit)
        
        // limit[betaAppLocalizations]
        let betaAppLocalizations = ListApps.Limit.betaAppLocalizations(limit).pair
        XCTAssertEqual(betaAppLocalizations.nestedKey, "betaAppLocalizations")
        XCTAssertEqual(betaAppLocalizations.value as? Int, limit)
    }
}
