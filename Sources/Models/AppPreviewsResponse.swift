import Foundation

public struct AppPreviewsResponse: Codable {
    public let data: [AppPreview]

    public let links: PagedDocumentLinks

    public let meta: PagingInformation?
}
