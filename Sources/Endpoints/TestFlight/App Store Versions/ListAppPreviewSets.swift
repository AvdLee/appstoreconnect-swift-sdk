import Foundation

public extension APIEndpoint where T == AppPreviewSetsResponse {
    static func appPreviewSets(
        forAppStoreVersionLocalization id: String,
        fields: [ListAppPreviewSetsForAppStoreVersionLocalization.Field]? = nil,
        includes: [ListAppPreviewSetsForAppStoreVersionLocalization.Include]? = nil,
        limit: Int? = nil
    ) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let includes = includes { parameters.add(includes) }
        if let limit = limit { parameters["limit"] = limit }
        return APIEndpoint(
            path: "appStoreVersions/\(id)/appPreviewSets",
            method: .get,
            parameters: parameters
        )
    }
}

public enum ListAppPreviewSetsForAppStoreVersionLocalization {
    public enum Field: NestableQueryParameter {
        case appPreviewSets([AppPreviewSets])
        case appPreviews([AppPreviews])
        case appStoreVersionLocalizations([AppStoreVersionLocalizations])
        case previewType([PreviewType])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case let .appPreviewSets(value):
                return (AppPreviewSets.key, value.map { $0.pair.value }.joinedByCommas())

            case let .appPreviews(value):
                return (AppPreviews.key, value.map { $0.pair.value }.joinedByCommas())

            case let .appStoreVersionLocalizations(value):
                return (AppStoreVersionLocalizations.key, value.map { $0.pair.value }.joinedByCommas())

            case let .previewType(value):
                return (PreviewType.key, value.map { $0.pair.value }.joinedByCommas())
            }
        }
    }

    public enum Include: String, CaseIterable, NestableQueryParameter {
        case appPreviews, appStoreVersionLocalization

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

public extension ListAppPreviewSetsForAppStoreVersionLocalization.Field {
    enum AppPreviewSets: String, CaseIterable, NestableQueryParameter {
        case appPreviews, appStoreVersionLocalization, previewType

        static var key: String = "appPreviewSets"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum AppPreviews: String, CaseIterable, NestableQueryParameter {
        case appPreviewSet, assetDeliveryState, fileName, fileSize, mimeType, previewFrameTimeCode, previewImage,
             sourceFileChecksum, uploadOperations, uploaded, videoUrl

        static var key: String = "appPreviews"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum AppStoreVersionLocalizations: String, CaseIterable, NestableQueryParameter {
        case appPreviewSets, appScreenshotSets, appStoreVersion, description, keywords, locale, marketingUrl,
             promotionalText, supportUrl, whatsNew

        static var key: String = "appStoreVersionLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum PreviewType: String, CaseIterable, NestableQueryParameter {
        case iPhone6Point5Inch = "IPHONE_65"
        case iPhone5Point8Inch = "IPHONE_58"
        case iPhone5Point5Inch = "IPHONE_55"
        case iPhone4Point7Inch = "IPHONE_47"
        case iPhone4Inch = "IPHONE_40"
        case iPhone3Point5Inch = "IPHONE_35"
        case iPadPro3rdGen12Point9Inch = "IPAD_PRO_3GEN_129"
        case iPadPro3rdGen11Inch = "IPAD_PRO_3GEN_11"
        case iPadPro12Point9Inch = "IPAD_PRO_129"
        case iPadPro10Point5Inch = "IPAD_105"
        case iPadPro9Point7Inch = "IPAD_97"
        case mac = "DESKTOP"
        case appleWatchSeries4 = "WATCH_SERIES_4"
        case appleWatchSeries3 = "WATCH_SERIES_3"
        case appleTV = "APPLE_TV"

        static var key: String = "previewType"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
