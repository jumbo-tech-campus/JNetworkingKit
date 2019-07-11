import Foundation

open class AnyRequestParser<ResultType: Codable>: RequestParserType {
    public typealias Result = ResultType

    public init() {}

    open func parse(response: Response) throws -> Result {
        Logger.log("Beginning to parse response \(response)", loggedComponent: .parser)
        do {
            return try JSONDecoder().decode(Result.self, from: response.data)
        } catch let error {
            throw RequestParserError.invalidData(parserError: error)
        }
    }
}
