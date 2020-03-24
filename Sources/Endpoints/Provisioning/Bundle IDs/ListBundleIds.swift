//
//  ListBundleIDs.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/22/19.
//

extension APIEndpoint where Request == EmptyBody, Response == BundleIdsResponse {

    /// Find and list bundle IDs that are registered to your team.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - sort: Attributes by which to sort.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func listBundleIds(
        fields: [BundleIds.Field]? = nil,
        filter: [BundleIds.Filter]? = nil,
        sort: [BundleIds.Sort]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let sort = sort { parameters.add(sort) }
        if let limit = limit { parameters["limit"] = limit }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        
        return APIEndpoint(
            path: "bundleIds",
            method: .get,
            parameters: parameters)
    }
}

public enum BundleIds {

    public enum Field: NestableQueryParameter {
        case bundleIds([BundleIds])
        case profiles([Profiles])
        case bundleIdCapabilities([BundleIdCapabilities])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .bundleIds(let values):
                return (BundleIds.key, values.map({ $0.pair.value }).joinedByCommas())
            case .profiles(let values):
                return (Profiles.key, values.map({ $0.pair.value }).joinedByCommas())
            case .bundleIdCapabilities(let values):
                return (BundleIdCapabilities.key, values.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }

    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case id([String]), identifier([String]), name([String]), platform([Platform]), seedId([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .id(let values):
                return ("id", values.joinedByCommas())
            case .identifier(let values):
                return ("identifier", values.joinedByCommas())
            case .name(let values):
                return ("name", values.joinedByCommas())
            case .platform(let values):
                return ("platform", values.map { $0.rawValue }.joinedByCommas())
            case .seedId(let values):
                return ("seedId", values.joinedByCommas())
            }
        }
    }

    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case bundleIdCapabilities, profiles

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case idAscending = "+id"
        case idDescending = "-id"

        case nameAscending = "+name"
        case nameDescending = "-name"

        case platformAscending = "+platform"
        case platformDescending = "-platform"

        case seedIdAscending = "+seedId"
        case seedIdDescending = "-seedId"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension BundleIds.Field {

    public enum BundleIds: String, CaseIterable, NestableQueryParameter {
        case bundleIdCapabilities, identifier, name, platform, profiles, seedId

        static var key: String = "bundleIds"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum Profiles: String, CaseIterable, NestableQueryParameter {
        case bundleId, certificates, createdDate, devices, expirationDate, name, platform, profileContent, profileState, profileType, uuid

        static var key: String = "profiles"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum BundleIdCapabilities: String, CaseIterable, NestableQueryParameter {
        case bundleId, capabilityType, settings

        static var key: String = "bundleIdCapabilities"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
