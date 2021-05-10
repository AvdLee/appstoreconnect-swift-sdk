import Foundation

public extension APIEndpoint where T == AppStoreVersionLocalization {
    static func appStoreVersionLocalization(
        withId id: String,
        fields: [ReadAppStoreVersionLocalizationInformation.Field]? = nil,
        include: [ReadAppStoreVersionLocalizationInformation.Include]? = nil,
        limits: [ReadAppStoreVersionLocalizationInformation.Limit]? = nil
    ) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let include = include { parameters.add(include) }
        if let limits = limits { parameters.add(limits) }
        return APIEndpoint(
            path: "appStoreVersionLocalizations/\(id)",
            method: .get,
            parameters: parameters
        )
    }
}

public enum ReadAppStoreVersionLocalizationInformation {
    public enum Field: NestableQueryParameter {
        case appPreviewSets([Field.AppPreviewSet])
        case appScreenshotSets([Field.AppScreenshotSet])
        case appStoreVersionLocalizations([Field.AppStoreVersionLocalization])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case let .appPreviewSets(value):
                return (Field.AppPreviewSet.key, value.map { $0.pair.value }.joinedByCommas())
            case let .appScreenshotSets(value):
                return (Field.AppScreenshotSet.key, value.map { $0.pair.value }.joinedByCommas())
            case let .appStoreVersionLocalizations(value):
                return (Field.AppStoreVersionLocalization.key, value.map { $0.pair.value }.joinedByCommas())
            }
        }
    }

    public enum Include: String, CaseIterable, NestableQueryParameter {
        case appPreviewSets
        case appScreenshotSets
        case appStoreVersion

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum Limit: NestableQueryParameter {
        /// Maximum: 50
        case appPreviewSets(Int)

        /// Maximum: 50
        case appScreenshotSets(Int)

        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case let .appPreviewSets(value):
                return ("appPreviewSets", "\(value)")
            case let .appScreenshotSets(value):
                return ("appScreenshotSets", "\(value)")
            }
        }
    }
}

public extension ReadAppStoreVersionLocalizationInformation.Field {
    enum AppPreviewSet: String, CaseIterable, NestableQueryParameter {
        case appPreviews, appStoreVersionLocalization, previewType

        static var key: String = "appPreviewSets"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum AppScreenshotSet: String, CaseIterable, NestableQueryParameter {
        case appScreenshots, appStoreVersionLocalization, screenshotDisplayType

        static var key: String = "appScreenshotSets"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    enum AppStoreVersionLocalization: String, CaseIterable, NestableQueryParameter {
        case appPreviewSets, appScreenshotSets, appStoreVersion, description, keywords, locale, marketingUrl,
             promotionalText, supportUrl, whatsNew

        static var key: String = "appStoreVersionLocalizations"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
