import Foundation

extension RequestParserType where Result: Codable {
    func parse(response: Response) throws -> Result {
        do {
            return try JSONDecoder().decode(Result.self, from: response.data)
        } catch let error {
            throw RequestParserError.invalidData(parserError: error)
        }
    }
}
