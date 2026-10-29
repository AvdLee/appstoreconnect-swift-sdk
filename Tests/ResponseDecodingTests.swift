import Foundation
import XCTest
@testable import AppStoreConnect_Swift_SDK

final class ResponseDecodingTests: XCTestCase {
    // Apple shows object dimensions and calendar-date data points in both metric examples:
    // https://developer.apple.com/documentation/appstoreconnectapi/get-v1-apps-_id_-metrics-betatesterusages
    // https://developer.apple.com/documentation/appstoreconnectapi/get-v1-betatesters-_id_-metrics-betatesterusages
    func test_groupedBetaTesterMetric_decodesResourceDimension() throws {
        let json = #"{"data":[{"dimensions":{"betaTesters":{"data":{"type":"betaTesters","id":"tester-1"}}},"dataPoints":[{"start":"2022-10-05","end":"2023-10-05","values":{"crashCount":1,"sessionCount":2,"feedbackCount":3}}]}],"links":{"self":"https://example.com/metrics","next":"https://example.com/next"},"meta":{"paging":{"total":1,"limit":50}}}"#
        let response = try APIProvider.jsonDecoder.decode(AppsBetaTesterUsagesV1MetricResponse.self, from: Data(json.utf8))

        XCTAssertEqual(response.data.first?.dimensions?.betaTesters?.data?.id, "tester-1")
        XCTAssertEqual(response.data.first?.dataPoints?.first?.values?.feedbackCount, 3)
        XCTAssertNotNil(response.data.first?.dataPoints?.first?.start)
        XCTAssertNotNil(response.data.first?.dataPoints?.first?.end)
        XCTAssertEqual(response.meta?.paging.total, 1)
        XCTAssertEqual(response.meta?.paging.limit, 50)
    }

    func test_groupedBetaTesterMetric_decodesStringDimension() throws {
        let json = #"{"data":[{"dimensions":{"betaTesters":{"data":"tester-1"}}}],"links":{"self":"https://example.com/metrics"}}"#
        let response = try JSONDecoder().decode(AppsBetaTesterUsagesV1MetricResponse.self, from: Data(json.utf8))

        XCTAssertEqual(response.data.first?.dimensions?.betaTesters?.data?.id, "tester-1")
    }

    func test_betaTesterMetric_decodesAppResourceDimension() throws {
        let json = #"{"data":[{"dimensions":{"apps":{"data":{"type":"apps","id":"app-1"}}},"dataPoints":[{"start":"2023-07-07","end":"2023-10-05","values":{"crashCount":1,"sessionCount":2,"feedbackCount":3}}]}],"links":{"self":"https://example.com/metrics"},"meta":{"paging":{"total":1,"limit":50}}}"#
        let response = try APIProvider.jsonDecoder.decode(BetaTesterUsagesV1MetricResponse.self, from: Data(json.utf8))

        XCTAssertEqual(response.data.first?.dataPoints?.first?.values?.feedbackCount, 3)
        XCTAssertNotNil(response.data.first?.dataPoints?.first?.start)
        XCTAssertEqual(response.data.first?.dimensions?.apps?.data?.id, "app-1")
        XCTAssertEqual(response.meta?.paging.total, 1)
        XCTAssertEqual(response.links.this, "https://example.com/metrics")
    }

    // Apple's placement example puts mediaType in attributes and image in relationships:
    // https://developer.apple.com/documentation/appstoreconnectapi/get-v1-appassetlibraryplacements-_id_
    func test_assetLibraryPlacements_decodeImageAndVideoRelationships() throws {
        let json = #"{"data":[{"type":"appAssetLibraryPlacements","id":"image-placement","attributes":{"mediaType":"IMAGE","state":"PARENT_PREPARE_FOR_SUBMISSION"},"relationships":{"image":{"data":{"type":"appAssetLibraryImages","id":"image-1"}}}},{"type":"appAssetLibraryPlacements","id":"video-placement","attributes":{"mediaType":"VIDEO","state":"PARENT_PREPARE_FOR_SUBMISSION"},"relationships":{"video":{"data":{"type":"appAssetLibraryVideos","id":"video-1"}}}}],"links":{"self":"https://example.com/placements"}}"#
        let response = try JSONDecoder().decode(AppAssetLibraryPlacementsResponse.self, from: Data(json.utf8))

        XCTAssertEqual(response.data.map(\.attributes?.state), [.parentPrepareForSubmission, .parentPrepareForSubmission])
        guard case .appAssetLibraryPlacementImageRelationships(let image) = response.data[0].relationships,
              case .appAssetLibraryPlacementVideoRelationships(let video) = response.data[1].relationships else {
            return XCTFail("Expected image and video relationships")
        }
        XCTAssertEqual(image.image?.data?.id, "image-1")
        XCTAssertEqual(video.video?.data?.id, "video-1")
    }

    // Captured in a live App Store Connect placement response: the unused
    // relationship is present as an object whose data is null.
    func test_assetLibraryPlacements_selectPopulatedRelationshipWhenBothKeysExist() throws {
        let json = #"{"data":[{"type":"appAssetLibraryPlacements","id":"image-placement","relationships":{"image":{"data":{"type":"appAssetLibraryImages","id":"image-1"}},"video":{"data":null}}},{"type":"appAssetLibraryPlacements","id":"video-placement","relationships":{"image":{"data":null},"video":{"data":{"type":"appAssetLibraryVideos","id":"video-1"}}}}],"links":{"self":"https://example.com/placements"}}"#
        let response = try JSONDecoder().decode(AppAssetLibraryPlacementsResponse.self, from: Data(json.utf8))

        guard case .appAssetLibraryPlacementImageRelationships(let image) = response.data[0].relationships,
              case .appAssetLibraryPlacementVideoRelationships(let video) = response.data[1].relationships else {
            return XCTFail("Expected the relationship with populated data")
        }
        XCTAssertEqual(image.image?.data?.id, "image-1")
        XCTAssertEqual(video.video?.data?.id, "video-1")
    }

    // Sanitized from a live in-app event localization response. Historical event
    // placements can be INACTIVE while their linked library images are ARCHIVED.
    func test_assetLibraryPlacements_decodeInactiveArchivedEventImages() throws {
        let json = #"""
        {
          "data": [
            {
              "type": "appAssetLibraryPlacements", "id": "card-placement",
              "attributes": {
                "mediaType": "IMAGE", "placementGroup": "DEFAULT_PROFILE",
                "state": "INACTIVE", "placementType": "EVENT_CARD_ASSET"
              },
              "relationships": {
                "image": {"data": {"type": "appAssetLibraryImages", "id": "card-image"}},
                "video": {"data": null}
              }
            },
            {
              "type": "appAssetLibraryPlacements", "id": "details-placement",
              "attributes": {
                "mediaType": "IMAGE", "placementGroup": "DEFAULT_PROFILE",
                "state": "INACTIVE", "placementType": "EVENT_DETAILS_PAGE_ASSET"
              },
              "relationships": {
                "image": {"data": {"type": "appAssetLibraryImages", "id": "details-image"}},
                "video": {"data": null}
              }
            }
          ],
          "included": [
            {
              "type": "appAssetLibraryImages", "id": "details-image",
              "attributes": {
                "specId": "details-spec", "fileName": "event-details.png", "state": "ARCHIVED",
                "imageAsset": {"templateUrl": "https://example.com/details/{w}x{h}.{f}", "width": 2160, "height": 3840},
                "stateDetails": null
              }
            },
            {
              "type": "appAssetLibraryImages", "id": "card-image",
              "attributes": {
                "specId": "card-spec", "fileName": "event-card.png", "state": "ARCHIVED",
                "imageAsset": {"templateUrl": "https://example.com/card/{w}x{h}.{f}", "width": 3840, "height": 2160},
                "stateDetails": null
              }
            }
          ],
          "links": {"self": "https://example.com/v1/appEventLocalizations/locale/placements"},
          "meta": {"paging": {"total": 2, "limit": 200}}
        }
        """#
        let response = try JSONDecoder().decode(AppAssetLibraryPlacementsResponse.self, from: Data(json.utf8))

        XCTAssertEqual(response.data.map(\.id), ["card-placement", "details-placement"])
        XCTAssertEqual(response.data.compactMap { $0.attributes?.state?.rawValue }, ["INACTIVE", "INACTIVE"])
        XCTAssertEqual(response.data.map(\.attributes?.placementType), [.eventCardAsset, .eventDetailsPageAsset])
        for (placement, expectedImageID) in zip(response.data, ["card-image", "details-image"]) {
            guard case .appAssetLibraryPlacementImageRelationships(let relationship) = placement.relationships else {
                return XCTFail("Expected the populated image relationship despite the null video data")
            }
            XCTAssertEqual(relationship.image?.data?.id, expectedImageID)
        }
        let included = try XCTUnwrap(response.included)
        XCTAssertEqual(included.count, 2)
        for item in included {
            guard case .appAssetLibraryImage(let image) = item,
                  case .appAssetLibraryImageArchivedAttributes(let attributes) = image.attributes else {
                return XCTFail("Expected archived image attributes")
            }
            XCTAssertEqual(attributes.state, .archived)
            XCTAssertNotNil(attributes.imageAsset)
        }
        let encoded = try JSONSerialization.jsonObject(with: JSONEncoder().encode(response.data[0])) as? [String: Any]
        XCTAssertEqual((encoded?["attributes"] as? [String: Any])?["state"] as? String, "INACTIVE")
    }

    // Based on Helm's placement fixture; confirm ACTIVE against a captured API response before upstreaming.
    func test_assetLibraryOrderingResponse_decodesIncludedActivePlacement() throws {
        let json = #"{"data":{"type":"appAssetLibraryPlacementOrderingRequests","id":"order-1"},"included":[{"type":"appAssetLibraryPlacements","id":"placement-1","attributes":{"state":"ACTIVE"}}],"links":{"self":"https://example.com/order-1"}}"#
        let response = try JSONDecoder().decode(
            AppAssetLibraryPlacementOrderingRequestResponse.self,
            from: Data(json.utf8)
        )

        XCTAssertEqual(response.data.id, "order-1")
        XCTAssertEqual(response.included?.first?.attributes?.state, .active)
    }
}
