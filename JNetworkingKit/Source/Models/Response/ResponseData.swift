import Foundation

struct ResponseData<Object: Codable>: Codable {
    var data: Object
}

struct PaginatedResponseData<Object: Codable>: Codable {
    var offset: Int
    var total: Int
    var data: [Object]
}
