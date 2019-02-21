import Foundation

public enum RequestParserError: Error, Hashable {
    case invalidData
    case api(code: String, message: String)
}

public protocol RequestParserType {
    associatedtype Result

    func parse(response: Response) throws -> Result
}
