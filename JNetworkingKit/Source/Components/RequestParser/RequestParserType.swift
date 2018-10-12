import Foundation

enum RequestParserError: Error, Hashable {
    case noData
    case invalidData
    case api(code: String, message: String)
}

protocol RequestParserType {
    associatedtype Result

    func parse(response: Response) throws -> Result
}
