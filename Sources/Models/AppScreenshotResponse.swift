import Foundation

public struct AppScreenshotResponse: Codable {
    public let data: AppScreenshot

    public let links: PagedDocumentLinks
}
