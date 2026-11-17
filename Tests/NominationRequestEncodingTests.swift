import XCTest
#if canImport(AppStoreConnectCore)
// Swift 6.4+: split modules. Internal API lives in Core; the umbrella re-exports the generated areas.
@testable import AppStoreConnectCore
import AppStoreConnect_Swift_SDK
#else
@testable import AppStoreConnect_Swift_SDK
#endif

final class NominationRequestEncodingTests: XCTestCase {
    func testUpdateRequestEncodesEmptyInAppEventsDataAsArray() throws {
        let request = NominationUpdateRequest(
            data: .init(
                type: .nominations,
                id: "nomination-id",
                relationships: .init(inAppEvents: .init(data: []))
            )
        )

        let payload = try JSONSerialization.jsonObject(with: JSONEncoder().encode(request)) as? [String: Any]
        let data = payload?["data"] as? [String: Any]
        let relationships = data?["relationships"] as? [String: Any]
        let inAppEvents = relationships?["inAppEvents"] as? [String: Any]

        XCTAssertNotNil(inAppEvents?["data"] as? [Any])
    }

    func testCreateRequestEncodesInAppEventsDataAsArray() throws {
        let request = NominationCreateRequest(
            data: .init(
                type: .nominations,
                attributes: .init(
                    name: "Nomination",
                    type: .appEnhancements,
                    description: "Description",
                    isSubmitted: false,
                    publishStartDate: Date(timeIntervalSince1970: 1_700_000_000)
                ),
                relationships: .init(
                    relatedApps: .init(data: [.init(type: .apps, id: "app-id")]),
                    inAppEvents: .init(data: [.init(type: .appEvents, id: "event-id")])
                )
            )
        )

        let payload = try JSONSerialization.jsonObject(with: JSONEncoder().encode(request)) as? [String: Any]
        let data = payload?["data"] as? [String: Any]
        let relationships = data?["relationships"] as? [String: Any]
        let inAppEvents = relationships?["inAppEvents"] as? [String: Any]
        let eventData = inAppEvents?["data"] as? [[String: Any]]

        XCTAssertEqual(eventData?.first?["type"] as? String, "appEvents")
        XCTAssertEqual(eventData?.first?["id"] as? String, "event-id")
    }
}
