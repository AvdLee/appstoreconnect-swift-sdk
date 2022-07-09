import Foundation

public struct AppScreenshotsResponse: Codable {
    public let data: [AppScreenshot]

    public let links: PagedDocumentLinks

    public let meta: PagingInformation?
}
