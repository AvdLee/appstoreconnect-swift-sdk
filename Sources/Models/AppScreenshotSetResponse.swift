import Foundation

public struct AppScreenshotSetResponse: Codable {
    public let data: AppScreenshotSet

    public let included: [AppScreenshot]?

    public let links: PagedDocumentLinks
}
