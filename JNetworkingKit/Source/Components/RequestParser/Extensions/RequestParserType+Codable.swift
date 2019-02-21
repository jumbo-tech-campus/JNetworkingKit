import Foundation

extension RequestParserType where Result: Codable {
    func parse(response: Response) throws -> Result {
        guard let jsonResponse = try? JSONDecoder().decode(Result.self, from: response.data) else {
            throw RequestParserError.invalidData
        }

        return jsonResponse
    }
}
