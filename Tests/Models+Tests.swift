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

extension ResourceLinks where T: Codable {
    static var test: ResourceLinks<T> {
        return ResourceLinks<T>(self: URL(string: "https://api.appstoreconnect.com")!)
    }
}

extension BetaGroup {
    static var test = BetaGroup(
        attributes: nil,
        id: "id",
        relationships: nil,
        links: .test)
}

extension PrereleaseVersion {
    static var test = PrereleaseVersion(
        attributes: nil,
        id: "id",
        links: .test,
        relationships: nil)
}

extension BetaAppLocalization {
    static var test = BetaAppLocalization(
        attributes: nil,
        id: "id",
        relationships: nil,
        links: .test)
}

extension Build {
    static var test = Build(
        attributes: nil,
        id: "id",
        relationships: nil,
        links: .test)
}

extension BetaLicenseAgreement {
    static var test = BetaLicenseAgreement(
        attributes: nil,
        id: "id",
        links: .test,
        relationships: nil)
}

extension BetaAppReviewDetail {
    static var test = BetaAppReviewDetail(
        attributes: nil,
        id: "id",
        links: .test,
        relationships: nil)
}

extension App {
    static var test = App(
        attributes: nil,
        id: "id",
        relationships: nil,
        links: .test)
}

extension BetaTester {
    static var test = BetaTester(
        attributes: nil,
        id: "id",
        relationships: nil,
        links: .test)
}

extension Device.Attributes {
    static var test = Device.Attributes(
        deviceClass: nil,
        model: nil,
        name: nil,
        platform: nil,
        status: nil,
        udid: nil,
        addedDate: nil
    )
}

extension Device {
    static var test = Device(
        attributes: .test,
        id: "id",
        links: .test)
}

extension Certificate.Attributes {
    static var test = Certificate.Attributes(
        certificateContent: nil,
        displayName: nil,
        expirationDate: nil,
        name: nil,
        platform: nil,
        serialNumber: nil,
        certificateType: nil
    )
}

extension Certificate {
    static var test = Certificate(
        attributes: .test,
        id: "id",
        links: .test
    )
}

extension BundleId {
    static var test = BundleId(
        attributes: nil,
        id: "id",
        relationships: nil,
        links: .test
    )
}

extension BuildBetaDetail {
    static var test = BuildBetaDetail(
        attributes: nil,
        id: "id",
        relationships: nil,
        links: .test)
}

extension BetaAppReviewSubmission {
    static var test = BetaAppReviewSubmission(
        attributes: nil,
        id: "id",
        links: .test,
        relationships: nil)
}
