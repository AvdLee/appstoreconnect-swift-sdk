//
//  DownloadFinanceReports.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == Void {

    /// Download finance reports filtered by your specified criteria.
    ///
    /// - Parameters:
    ///   - filter: You can download consolidated or separate financial reports per territory. For a complete list of possible values, see Financial Report Regions and Currencies.
    public static func downloadFinanceReports(filter: [DownloadFinanceReports.Filter]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let filter = filter { parameters.add(filter) }
        return APIEndpoint(path: "financeReports", method: .get, parameters: parameters)
    }
}

public struct DownloadFinanceReports {
    
    /// You can download consolidated or separate financial reports per territory. For a complete list of possible values, see Financial Report Regions and Currencies.
    public enum Filter: NestableQueryParameter {
        case regionCode([String])
        case reportDate([String])
        case reportType([ReportType])
        case vendorNumber([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .regionCode(let value):
                return ("regioncode", value.joinedByCommas())
            case .reportDate(let value):
                return ("reportdate", value.joinedByCommas())
            case .reportType(let value):
                return (ReportType.key, value.map({ $0.pair.value }).joinedByCommas())
            case .vendorNumber(let value):
                return ("vendornumber", value.joinedByCommas())
            }
        }
    }
}

extension DownloadFinanceReports.Filter {
    
    public enum ReportType: String, CaseIterable, NestableQueryParameter {
        case FINANCIAL

        static var key: String = "reportType"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
