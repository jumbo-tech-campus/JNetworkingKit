import Foundation

public struct ResponseData<Object: Codable>: Codable {
    public var data: Object
}

public struct PaginatedResponseData<Object: Codable>: Codable {
    public var offset: Int
    public var total: Int
    public var data: [Object]
}
