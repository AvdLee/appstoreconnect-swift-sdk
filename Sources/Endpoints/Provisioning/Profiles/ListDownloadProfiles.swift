//
//  ListDownloadProfiles.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where Request == EmptyBody, Response == ProfilesResponse {

    /// Find and list provisioning profiles and download their data.
    public static func listProfiles(
        fields: [Profiles.Field]? = nil,
        filter: [Profiles.Filter]? = nil,
        include: [Profiles.Include]? = nil,
        sort: [Profiles.Sort]? = nil,
        limit: [Profiles.Limit]? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let include = include { parameters.add(include) }
        if let sort = sort { parameters.add(sort) }
        if let limit = limit { parameters.add(limit) }

        return APIEndpoint(
            path: "profiles",
            method: .get,
            parameters: parameters)
    }
}

public enum Profiles {

    public enum Field: NestableQueryParameter {
        case certificates([Certificates])
        case devices([Devices])
        case profiles([Profiles])
        case bundleIds([BundleIds])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .certificates(let value):
                return (Certificates.key, value.map({ $0.pair.value }).joinedByCommas())
            case .devices(let value):
                return (Devices.key, value.map({ $0.pair.value }).joinedByCommas())
            case .profiles(let value):
                return (Profiles.key, value.map({ $0.pair.value }).joinedByCommas())
            case .bundleIds(let value):
                return (BundleIds.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }

    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case id([String]), name([String]), profileState([ProfileState]), profileType([ProfileType])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .id(let values):
                return ("id", values.joinedByCommas())
            case .name(let values):
                return ("name", values.joinedByCommas())
            case .profileState(let values):
                return ("profileState", values.map { $0.rawValue }.joinedByCommas())
            case .profileType(let values):
                return ("profileType", values.map { $0.rawValue }.joinedByCommas())
            }
        }
    }

    /// Relationship data to include in the response.
    public enum Include: String, CaseIterable, NestableQueryParameter {
        case bundleId, certificates, devices

        static var key: String = "include"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case idAscending = "+id"
        case idDescending = "-id"

        case nameAscending = "+name"
        case nameDescending = "-name"

        case profileStateAscending = "+profileState"
        case profileStateDescending = "-profileState"

        case profileTypeAscending = "+profileType"
        case profileTypeDescending = "-profileType"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    /// Number of included related resources to return.
    public enum Limit: NestableQueryParameter {

        /// Maximum: 200
        case profiles(Int)

        /// Maximum: 50
        case certificates(Int)

        /// Maximum: 50
        case devices(Int)

        static var key: String = "limit"
        var pair: Pair {
            switch self {
            case .profiles(let value):
                return (nil, "\(value)")
            case .certificates(let value):
                return ("certificates", "\(value)")
            case .devices(let value):
                return ("devices", "\(value)")
            }
        }
    }
}

extension Profiles.Field {

    public enum Certificates: String, CaseIterable, NestableQueryParameter {
        case certificateContent, certificateType, csrContent, displayName, expirationDate, name, platform, serialNumber

        static var key: String = "certificates"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum Devices: String, CaseIterable, NestableQueryParameter {
        case addedDate, deviceClass, model, name, platform, status, udid

        static var key: String = "devices"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum Profiles: String, CaseIterable, NestableQueryParameter {
        case bundleId, certificates, createdDate, devices, expirationDate, name, platform, profileContent, profileState, profileType, uuid

        static var key: String = "profiles"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    public enum BundleIds: String, CaseIterable, NestableQueryParameter {
        case bundleIdCapabilities, identifier, name, platform, profiles, seedId

        static var key: String = "bundleIds"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
