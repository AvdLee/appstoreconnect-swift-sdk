import Foundation
import XCTest
@testable import AppStoreConnect_Swift_SDK

final class PlacementRequestEncodingTests: XCTestCase {
    func testImagePlacementEncodesVersionLocalizationAndGroup() throws {
        let request = AppAssetLibraryPlacementCreateRequest(data: .init(
            type: .appAssetLibraryPlacements,
            attributes: .init(placementType: .appScreenshot, placementGroup: "IPHONE_67"),
            relationships: .init(
                image: .init(data: .init(type: .appAssetLibraryImages, id: "image-1")),
                appStoreVersionLocalization: .init(data: .init(type: .appStoreVersionLocalizations, id: "locale-1"))
            )
        ))

        let json = try encodedJSONObject(request)
        let data = try XCTUnwrap(json["data"] as? [String: Any])
        XCTAssertEqual(data["type"] as? String, "appAssetLibraryPlacements")
        XCTAssertEqual((data["attributes"] as? [String: Any])?["placementGroup"] as? String, "IPHONE_67")
        XCTAssertEqual((data["attributes"] as? [String: Any])?["placementType"] as? String, "APP_SCREENSHOT")
        let relationships = try XCTUnwrap(data["relationships"] as? [String: Any])
        XCTAssertEqual(((relationships["image"] as? [String: Any])?["data"] as? [String: Any])?["id"] as? String, "image-1")
        XCTAssertEqual(((relationships["appStoreVersionLocalization"] as? [String: Any])?["data"] as? [String: Any])?["id"] as? String, "locale-1")
        XCTAssertNil(relationships["video"])
    }

    func testVideoPlacementEncodesTreatmentLocalization() throws {
        let request = AppAssetLibraryPlacementCreateRequest(data: .init(
            type: .appAssetLibraryPlacements,
            attributes: .init(placementType: .appPreview, placementGroup: "IPHONE_67"),
            relationships: .init(
                video: .init(data: .init(type: .appAssetLibraryVideos, id: "video-1")),
                appStoreVersionExperimentTreatmentLocalization: .init(data: .init(
                    type: .appStoreVersionExperimentTreatmentLocalizations, id: "treatment-1"
                ))
            )
        ))

        let data = try XCTUnwrap(encodedJSONObject(request)["data"] as? [String: Any])
        let relationships = try XCTUnwrap(data["relationships"] as? [String: Any])
        XCTAssertEqual(((relationships["video"] as? [String: Any])?["data"] as? [String: Any])?["type"] as? String, "appAssetLibraryVideos")
        XCTAssertEqual(((relationships["appStoreVersionExperimentTreatmentLocalization"] as? [String: Any])?["data"] as? [String: Any])?["id"] as? String, "treatment-1")
        XCTAssertNil(relationships["image"])
    }

    func testPlacementOrderingEncodesOrderedIDsAndVersionLocalization() throws {
        let request = AppAssetLibraryPlacementOrderingRequestCreateRequest(data: .init(
            type: .appAssetLibraryPlacementOrderingRequests,
            attributes: .init(placementGroup: "IPHONE_67"),
            relationships: .init(
                orderedPlacements: .init(data: [
                    .init(type: .appAssetLibraryPlacements, id: "placement-2"),
                    .init(type: .appAssetLibraryPlacements, id: "placement-1")
                ]),
                appStoreVersionLocalization: .init(data: .init(type: .appStoreVersionLocalizations, id: "locale-1"))
            )
        ))

        let data = try XCTUnwrap(encodedJSONObject(request)["data"] as? [String: Any])
        XCTAssertEqual(data["type"] as? String, "appAssetLibraryPlacementOrderingRequests")
        XCTAssertEqual((data["attributes"] as? [String: Any])?["placementGroup"] as? String, "IPHONE_67")
        let relationships = try XCTUnwrap(data["relationships"] as? [String: Any])
        let ordered = try XCTUnwrap((relationships["orderedPlacements"] as? [String: Any])?["data"] as? [[String: Any]])
        XCTAssertEqual(ordered.compactMap { $0["id"] as? String }, ["placement-2", "placement-1"])
        XCTAssertEqual(((relationships["appStoreVersionLocalization"] as? [String: Any])?["data"] as? [String: Any])?["id"] as? String, "locale-1")
    }

    private func encodedJSONObject<T: Encodable>(_ request: T) throws -> [String: Any] {
        try XCTUnwrap(JSONSerialization.jsonObject(with: JSONEncoder().encode(request)) as? [String: Any])
    }
}
