//
//  DownloadFinanceReportsTests.swift
//  AppStoreConnect-Swift-SDK_Tests
//
//  Created by Pascal Edmond on 30/11/2018.
//

import XCTest
@testable import AppStoreConnect_Swift_SDK

final class DownloadFinanceReportsTests: XCTestCase {
    
    func testURLRequest() {
        let endpoint = APIEndpoint.downloadFinanceReports(
            filter: [.regionCode(["regionCode"]),
                     .reportDate(["reportDate"]),
                     .reportType(DownloadFinanceReports.Filter.ReportType.allCases),
                     .vendorNumber(["vendorNumber"])])
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/financeReports?filter%5Bregioncode%5D=regionCode&filter%5BreportType%5D=FINANCIAL&filter%5Breportdate%5D=reportDate&filter%5Bvendornumber%5D=vendorNumber"
        XCTAssertEqual(absoluteString, expected)
    }
}
