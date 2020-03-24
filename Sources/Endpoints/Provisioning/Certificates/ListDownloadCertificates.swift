//
//  ListDownloadCertificates.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Patrick Balestra on 12/14/2019.
//

extension APIEndpoint where Request == EmptyBody, Response == CertificatesResponse {

    /// Find and list certificates and download their data.
    ///
    /// - Parameters:
    ///   - fields: Fields to return for included related types.
    ///   - filter: Attributes, relationships, and IDs by which to filter.
    ///   - sort: Attributes by which to sort.
    ///   - limit: Number of resources to return.
    ///   - next: The next URL to use as a base. See `PagedDocumentLinks`.
    public static func listDownloadCertificates(
        fields: [Certificates.Field]? = nil,
        filter: [Certificates.Filter]? = nil,
        sort: [Certificates.Sort]? = nil,
        limit: Int? = nil,
        next: PagedDocumentLinks? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        if let filter = filter { parameters.add(filter) }
        if let sort = sort { parameters.add(sort) }
        if let limit = limit { parameters["limit"] = limit }
        if let nextCursor = next?.nextCursor { parameters["cursor"] = nextCursor }
        return APIEndpoint(
            path: "certificates",
            method: .get,
            parameters: parameters)
    }
}

public enum Certificates {

    public enum Field: String, CaseIterable, NestableQueryParameter {
        case certificateContent, certificateType, csrContent, displayName, expirationDate, name, platform, serialNumber

        static var key: String = "certificates"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }

    /// Attributes, relationships, and IDs by which to filter.
    public enum Filter: NestableQueryParameter {
        case id([String]), serialNumber([String]), certificateType(CertificateType), displayName([String])

        static var key: String = "filter"
        var pair: Pair {
            switch self {
            case .id(let value):
                return ("id", value.joinedByCommas())
            case .serialNumber(let value):
                return ("serialNumber", value.joinedByCommas())
            case .certificateType(let value):
                return ("certificateType", value.rawValue)
            case .displayName(let value):
                return ("displayName", value.joinedByCommas())
            }
        }
    }

    /// Attributes by which to sort.
    public enum Sort: String, CaseIterable, NestableQueryParameter {
        case certificateTypeAscending = "+certificateType"
        case certificateTypeDescending = "-certificateType"

        case displayNameAscending = "+displayName"
        case displayNameDescending = "-displayName"

        case idAscending = "+id"
        case idDescending = "-id"

        case serialNumberAscending = "+serialNumber"
        case serialNumberDescending = "-serialNumber"

        static var key: String = "sort"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
