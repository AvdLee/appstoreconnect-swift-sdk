//
//  DownloadSalesAndTrendsReportsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class DownloadSalesAndTrendsReportsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.downloadSalesAndTrendsReports(
            filter: [
                .frequency(DownloadSalesAndTrendsReports.Filter.Frequency.allCases),
                .reportDate(["reportDate"]),
                .reportSubType(DownloadSalesAndTrendsReports.Filter.ReportSubType.allCases),
                .reportType(DownloadSalesAndTrendsReports.Filter.ReportType.allCases),
                .vendorNumber(["vendorNumber"]),
                .version(["version"])])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/salesReports?filter%5Bfrequency%5D=DAILY%2CWEEKLY%2CMONTHLY%2CYEARLY&filter%5BreportDate%5D=reportDate&filter%5BreportSubType%5D=SUMMARY%2CDETAILED%2COPT_IN&filter%5BreportType%5D=SALES%2CPRE_ORDER%2CNEWSSTAND%2CSUBSCRIPTION%2CSUBSCRIPTION_EVENT%2CSUBSCRIBER&filter%5BvendorNumber%5D=vendorNumber&filter%5Bversion%5D=version"
        XCTAssertEqual(absoluteString, expected)
    }
}
