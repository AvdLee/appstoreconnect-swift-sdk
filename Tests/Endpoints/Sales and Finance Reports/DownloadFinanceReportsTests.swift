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
            regionCodes: DownloadFinanceReports.RegionCode.allCases,
            reportDate: "2018-11",
            vendorNumber: "11223344")
        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "GET")
        
        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/financeReports?filter%5BregionCode%5D=AE%2CAU%2CBG%2CBR%2CCA%2CCH%2CCL%2CCN%2CCO%2CCZ%2CDK%2CEG%2CEU%2CGB%2CHK%2CHU%2CID%2CIL%2CIN%2CJP%2CKR%2CKZ%2CMX%2CMY%2CNG%2CNO%2CNZ%2CPE%2CPH%2CPK%2CPL%2CQA%2CRU%2CSA%2CSE%2CSG%2CTR%2CTW%2CTZ%2CUS%2CVN%2CWW%2CZA%2CZZ&filter%5BreportDate%5D=2018-11&filter%5BreportType%5D=FINANCIAL&filter%5BvendorNumber%5D=11223344"
        XCTAssertEqual(absoluteString, expected)
    }
}
