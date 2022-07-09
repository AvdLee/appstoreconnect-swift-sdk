import Foundation

public struct UploadOperation: Codable {
    public let length: Int?
    public let method: String?
    public let offset: Int?
    public let requestHeaders: [UploadOperationHeader]?
    public let url: String?
}
