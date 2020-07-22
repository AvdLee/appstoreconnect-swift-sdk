//
//  ListDevices.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/24/19.
//

import Foundation

extension APIEndpoint where T == DevicesResponse {

    /// Find and list devices registered to your team.
    public static func listDevices(
        fields: [Devices.Field]? = nil,
        filter: [Devices.Filter]? = nil,
        sort: [Devices.Sort]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {

        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let sort = sort { parameters.add(sort) }
        if let limit = limit {
            parameters["limit"] = limit
        } else if let nextLimit = next?.nextLimit {
            parameters["limit"] = nextLimit
        }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        
        return APIEndpoint(
            path: "devices",
            method: .get,
            parameters: parameters)
    }
}

public enum Devices {

    public enum Field: String, CaseIterable, NestableQueryParameter {
        case devices

        static var key: String = "devices"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case id([String]), name([String]), platform([Platform]), status([DeviceStatus]), udid([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .id(let values):
                return ("id", values.joinedByCommas())
            case .name(let values):
                return ("name", values.joinedByCommas())
            case .platform(let values):
                return ("platform", values.map { $0.rawValue }.joinedByCommas())
            case .status(let values):
                return ("status", values.map { $0.rawValue }.joinedByCommas())
            case .udid(let values):
                return ("udid", values.joinedByCommas())
            }
        }
    }

    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case idAscending = "+id"
        case idDescending = "-id"

        case nameAscending = "+name"
        case nameDescending = "-name"

        case platformAscending = "+platform"
        case platformDescending = "-platform"

        case statusAscending = "+status"
        case statusDescending = "-status"

        case udidAscending = "+udid"
        case udidDescending = "-udid"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}

extension Devices.Field {

    public enum Devices: String, CaseIterable, NestableQueryParameter {
        case addedDate, deviceClass, model, name, platform, status, udid

        static var key: String = "devices"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
