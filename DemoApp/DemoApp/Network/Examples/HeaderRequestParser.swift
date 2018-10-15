import Foundation
import JNetworkingKit

class HeaderRequestParser: RequestParserType {
    func parse(response: Response) throws -> Any {
        guard !response.headers.isEmpty else {
            throw RequestParserError.noData
        }

        print("Request headers:")
        response.headers.forEach { (key, value) in
            print("  - [\(key)] \(value)")
        }

        return ""
    }
}
