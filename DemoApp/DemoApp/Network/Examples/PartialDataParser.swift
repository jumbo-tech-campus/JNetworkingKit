import Foundation
import JNetworkingKit

class PartialDataRequestParser: RequestParserType {
    func parse(data: Data) throws -> [String] {
        do {
            let jsonResponse = try JSONDecoder().decode([String: Result].self, from: data)
            let partialData: [String] =  jsonResponse["first_half"] ?? []
            return partialData
        } catch let error {
            throw RequestParserError.invalidData(parserError: error)
        }
    }
}
