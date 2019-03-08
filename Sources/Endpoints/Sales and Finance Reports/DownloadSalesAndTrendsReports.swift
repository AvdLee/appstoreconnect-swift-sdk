//
//  DownloadSalesAndTrendsReports.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == Void {

    /// Download sales and trends reports filtered by your specified criteria.
    ///
    /// - Parameters:
    ///   - filter: Frequency of the report to download. For a list of values, see Allowed Values Based on Sales Report Type below.
    public static func downloadSalesAndTrendsReports(filter: [DownloadSalesAndTrendsReports.Filter]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let filter = filter { parameters.add(filter) }
        return APIEndpoint(path: "salesReports", method: .get, parameters: parameters)
    }
}

public struct DownloadSalesAndTrendsReports {

    /// Frequency of the report to download. For a list of values, see Allowed Values Based on Sales Report Type below.
    public enum Filter: NestableQueryParameter {
        case frequency([Frequency])
        case reportDate([String])
        case reportSubType([ReportSubType])
        case reportType([ReportType])
        case vendorNumber([String])
        case version([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .frequency(let value):
                return (Frequency.key, value.map({ $0.pair.value }).joinedByCommas())
            case .reportDate(let value):
                return ("reportdate", value.joinedByCommas())
            case .reportSubType(let value):
                return (ReportSubType.key, value.map({ $0.pair.value }).joinedByCommas())
            case .reportType(let value):
                return (ReportType.key, value.map({ $0.pair.value }).joinedByCommas())
            case .vendorNumber(let value):
                return ("vendornumber", value.joinedByCommas())
            case .version(let value):
                return ("version", value.joinedByCommas())
            }
        }
    }
}

extension DownloadSalesAndTrendsReports.Filter {
    
    public enum Frequency: String, CaseIterable, NestableQueryParameter {
        case DAILY, WEEKLY, MONTHLY, YEARLY

        static var key: String = "frequency"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum ReportSubType: String, CaseIterable, NestableQueryParameter {
        case SUMMARY, DETAILED, OPT_IN

        static var key: String = "reportSubType"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
    
    public enum ReportType: String, CaseIterable, NestableQueryParameter {
        case SALES, PRE_ORDER, NEWSSTAND, SUBSCRIPTION, SUBSCRIPTION_EVENT, SUBSCRIBER

        static var key: String = "reportType"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
