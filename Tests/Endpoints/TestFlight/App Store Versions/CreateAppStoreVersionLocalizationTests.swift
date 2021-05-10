@testable import AppStoreConnect_Swift_SDK
import Foundation
import XCTest

final class CreateAppStoreVersionLocalizationTests: XCTestCase {
    let id = UUID().uuidString
    let locale = "en-US"
    let appDescription = "My App Is Great"
    let url = URL(fileURLWithPath: "/usr/local/bin/appstore")
    let buildIds = ["buildId"]

    func testURLRequest() {
        let endpoint = APIEndpoint.create(appStoreVersionLocalizationForVersionWithId: self.id,
                                          locale: self.locale, description: self.appDescription,
                                          keywords: nil, marketingUrl: self.url,
                                          promotionalText: self.appDescription, supportUrl: self.url,
                                          whatsNew: "Nothing")

        let request = try? endpoint.asURLRequest()
        XCTAssertEqual(request?.httpMethod, "POST")

        let absoluteString = request?.url?.absoluteString
        let expected = "https://api.appstoreconnect.apple.com/v1/appStoreVersionLocalizations"
        XCTAssertEqual(absoluteString, expected)
        XCTAssertEqual(
            request?.httpBody,
            try? JSONEncoder().encode(AppStoreVersionLocalizationCreateRequest(
                appStoreVersionId: self.id, locale: self.locale,
                description: self.appDescription,
                keywords: nil, marketingUrl: self.url, promotionalText: self.appDescription,
                supportUrl: self.url, whatsNew: "Nothing"
            ))
        )
    }
}
