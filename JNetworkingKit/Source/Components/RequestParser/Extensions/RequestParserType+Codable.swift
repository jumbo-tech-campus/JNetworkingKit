import Foundation

public extension RequestParserType where Result: Codable {
    public func parse(data: Data) throws -> Result {
        do {
            return try JSONDecoder().decode(Result.self, from: data)
        } catch let error {
            throw RequestParserError.invalidData(parserError: error)
        }
    }
}
