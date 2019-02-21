import Foundation

public enum RequestParserError: Error {
    case invalidData(parserError: Error?)
    case api(code: String, message: String)
}

public protocol RequestParserType {
    associatedtype Result

    func parse(data: Data) throws -> Result
}
