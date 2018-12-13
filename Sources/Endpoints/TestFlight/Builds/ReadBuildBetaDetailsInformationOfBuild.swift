//
//  ReadBuildBetaDetailsInformationOfBuild.swift
//  AppStoreConnect-Swift-SDK
//
//  Created by Pascal Edmond on 30/11/2018.
//
    
import Alamofire

extension APIEndpoint where T == BuildBetaDetailResponse {

    /// Get the beta test details for a specific build.
    ///
    /// - Parameters:
    ///   - id: (Required) An opaque resource ID that uniquely identifies the resource.
    ///   - fields: Fields to return for included related types.
    public static func buildBetaDetail(
        ofBuildWithId id: String,
        fields: [ReadBuildBetaDetailsInformationOfBuild.Field]? = nil) -> APIEndpoint {
        var parameters = [String: Any]()
        if let fields = fields { parameters.add(fields) }
        return APIEndpoint(path: "builds/\(id)/buildBetaDetail", method: .get, parameters: parameters)
    }
}

public struct ReadBuildBetaDetailsInformationOfBuild {

    /// Fields to return for included related types.
    public enum Field: NestableQueryParameter {
        case buildBetaDetails([BuildBetaDetail])

        static var key: String = "fields"
        var pair: Pair {
            switch self {
            case .buildBetaDetails(let value):
                return (BuildBetaDetail.key, value.map({ $0.pair.value }).joinedByCommas())
            }
        }
    }
}

extension ReadBuildBetaDetailsInformationOfBuild.Field {
    
    public enum BuildBetaDetail: String, CaseIterable, NestableQueryParameter {
        case autoNotifyEnabled, build, externalBuildState, internalBuildState

        static var key: String = "buildBetaDetail"
        var pair: NestableQueryParameter.Pair { return (nil, rawValue) }
    }
}
