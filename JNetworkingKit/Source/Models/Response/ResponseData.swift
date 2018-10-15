import Foundation

public struct ResponseData<Object: Codable>: Codable {
    var data: Object
}

public struct PaginatedResponseData<Object: Codable>: Codable {
    var offset: Int
    var total: Int
    var data: [Object]
}
