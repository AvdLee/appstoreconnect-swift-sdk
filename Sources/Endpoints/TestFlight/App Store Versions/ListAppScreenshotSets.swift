import Foundation

public extension APIEndpoint where T == AppScreenshotSetsResponse {
    static func appScreenshotSets(
        forAppStoreVersionLocalization id: String,
        fields: [ListAppScreenshotSetsForAppStoreVersionLocalization.Field]? = nil,
        includes: [ListAppScreenshotSetsForAppStoreVersionLocalization.Include]? = nil,
        limit: Int? = nil
    ) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let includes = includes { parameters.add(includes) }
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "appStoreVersions/\(id)/appScreenshotSets",
            method: .get,
            parameters: parameters
        )
    }
}

public enum ListAppScreenshotSetsForAppStoreVersionLocalization {
    public enum Field: NestableQueryParameter {
        case appScreenshotSets([AppScreenshotSets])
        case appScreenshots([AppScreenshots])
        case appStoreVersionLocalizations([AppStoreVersionLocalizations])
        case screenshotDisplayType([ScreenshotDisplayType])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case let .appScreenshotSets(value):
                return (AppScreenshotSets.key, value.map { $0.pair.value }.joinedByCommas())

            case let .appScreenshots(value):
                return (AppScreenshots.key, value.map { $0.pair.value }.joinedByCommas())

            case let .appStoreVersionLocalizations(value):
                return (AppStoreVersionLocalizations.key, value.map { $0.pair.value }.joinedByCommas())

            case let .screenshotDisplayType(value):
                return (ScreenshotDisplayType.key, value.map { $0.pair.value }.joinedByCommas())
            }
        }
    }

    public enum Include: String, CaseIterable, NestableQueryParameter {
        case appScreenshots, appStoreVersionLocalization

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

public extension ListAppScreenshotSetsForAppStoreVersionLocalization.Field {
    enum AppScreenshotSets: String, CaseIterable, NestableQueryParameter {
        case appScreenshots, appStoreVersionLocalization, screenshotDisplayType

        static var key: String = "appScreenshotSets"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum AppScreenshots: String, CaseIterable, NestableQueryParameter {
        case appScreenshotSet, assetDeliveryState, assetToken, assetType, fileName, fileSize, imageAsset,
             sourceFileChecksum, uploadOperations, uploaded

        static var key: String = "appScreenshots"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum AppStoreVersionLocalizations: String, CaseIterable, NestableQueryParameter {
        case appPreviewSets, appScreenshotSets, appStoreVersion, description, keywords, locale, marketingUrl,
             promotionalText, supportUrl, whatsNew

        static var key: String = "appStoreVersionLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum ScreenshotDisplayType: String, CaseIterable, NestableQueryParameter {

        // TODO: Snake case.
        case APP_IPHONE_65, APP_IPHONE_58, APP_IPHONE_55, APP_IPHONE_47, APP_IPHONE_40, APP_IPHONE_35,
             APP_IPAD_PRO_3GEN_129, APP_IPAD_PRO_3GEN_11, APP_IPAD_PRO_129, APP_IPAD_105, APP_IPAD_97,
             APP_DESKTOP, APP_WATCH_SERIES_4, APP_WATCH_SERIES_3, APP_APPLE_TV,
             IMESSAGE_APP_IPHONE_65, IMESSAGE_APP_IPHONE_58, IMESSAGE_APP_IPHONE_55, IMESSAGE_APP_IPHONE_47,
             IMESSAGE_APP_IPHONE_40,
             IMESSAGE_APP_IPAD_PRO_3GEN_129, IMESSAGE_APP_IPAD_PRO_3GEN_11, IMESSAGE_APP_IPAD_PRO_129,
             IMESSAGE_APP_IPAD_105, IMESSAGE_APP_IPAD_97

        static var key: String = "screenshotDisplayType"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
