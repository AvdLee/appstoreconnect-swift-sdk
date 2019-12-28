//
//  DownloadFinanceReports.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//

extension APIEndpoint where T == Void {

    /// Download finance reports filtered by your specified criteria.
    ///
    /// - Parameters:
    ///    - regionCodes: You can download consolidated or separate financial reports per territory. For a complete list of possible values, see [Financial Report Regions and Currencies](https://help.apple.com/app-store-connect/?lang=en#/dev63d64d955).
    ///    - reportDate: The date of the report you wish to download based on the [Apple Fiscal Calendar](https://itunesconnect.apple.com/WebObjects/iTunesConnect.woa/wa/jumpTo?page=fiscalcalendar). The date is specified in the YYYY-MM format.
    ///    - vendorNumber: You can find your vendor number in [Payments and Financial Reports](https://help.apple.com/app-store-connect/#/dev3a16f3fe0).
    public static func downloadFinanceReports(
        regionCodes: [DownloadFinanceReports.RegionCode],
        reportDate: String,
        vendorNumber: String) -> APIEndpoint {
        let parameters = [
            "filter[reportType]": "FINANCIAL",
            "filter[regionCode]": regionCodes.map({ $0.rawValue }).joinedByCommas(),
            "filter[reportDate]": reportDate,
            "filter[vendorNumber]": vendorNumber]
        return APIEndpoint(path: "financeReports", method: .get, parameters: parameters)
    }
}

public enum DownloadFinanceReports {
    
    public enum RegionCode: String, CaseIterable {
        case AE // United Arab Emirates
        case AU // Australia
        case BG // Bulgaria
        case BR // Brazil
        case CA // Canada
        case CH // Switzerland
        case CL // Chile
        case CN // China
        case CO // Columbia
        case CZ // Czech Republic
        case DK // Denmark
        case EG // Egypt
        case EU // Euro-Zone (Austria, Belgium, Bulgaria, Cyprus, Czech Republic, Estonia, Finland, France, Germany, Greece, Hungary, Ireland, Italy, Latvia, Lithuania, Luxembourg, Malta, Netherlands, Poland, Portugal, Romania, Slovakia, Slovenia, Spain)
        case GB // United Kingdom
        case HK // Hong Kong
        case HU // Hungary
        case ID // Indonesia
        case IL // Israel
        case IN // India
        case JP // Japan
        case KR // Korea
        case KZ // Kazakhstan
        case MX // Mexico
        case MY // Malaysia
        case NG // Nigeria
        case NO // Norway
        case NZ // New Zealand
        case PE // Peru
        case PH // Philippines
        case PK // Pakistan
        case PL // Poland
        case QA // Qatar
        case RU // Russia
        case SA // Saudi Arabia
        case SE // Sweden
        case SG // Singapore
        case TR // Turkey
        case TW // Taiwan
        case TZ // United Republic of Tanzania
        case US // Americas (Anguilla, Antigua and Barbuda, Argentina, Bahamas, Barbados, Belize, Bermuda, Bolivia, Brazil, Cayman Islands, Chile, Colombia, Costa Rica, Dominica, Dominican Republic, Ecuador, El Salvador, Grenada, Guatemala, Guyana, Honduras, Jamaica, Montserrat, Nicaragua, Panama, Paraguay, Peru, Saint Lucia, St. Kitts and Nevis, St. Vincent and The Grenadines, Suriname, Trinidad and Tobago, Turks and Caicos, United States, Uruguay, Venezuela, British Virgin Islands)
        case VN // Vietnam
        case WW // Rest of World (Albania, Algeria, Angola, Armenia, Azerbaijan, Bahrain, Belarus, Benin, Bhutan, Botswana, Brunei Darussalam, Burkina Faso, Cambodia, Cape Verde, Chad, Republic of Congo, Croatia, Egypt, Fiji, Gambia, Ghana, Guinea-Bissau, Iceland, Jordan, Kazakhstan, Kenya, Republic of Korea, Kuwait, Kyrgyzstan, People's Democratic Republic of Lao, Lebanon, Liberia, Macau, The Former Yugoslav Republic of Macedonia, Madagascar, Malawi, Malaysia, Mali, Mauritania, Mauritius, Federated States of Micronesia, Republic of Moldova, Mozambique, Namibia, Nepal, Niger, Nigeria, Oman, Pakistan, Palau, Papua New Guinea, Philippines, Qatar, Sao Tome and Principe, Senegal, Seychelles, Sierra Leone, Solomon Islands, Sri Lanka, Swaziland, Tajikistan, United Republic of Tanzania, Tunisia,Turkmenistan, Uganda, Ukraine, Uzbekistan, Vietnam, Yemen, Zimbabwe)
        case ZA // South Africa
        case ZZ // Consolidated Financial Reports (All Territories)
    }
}
