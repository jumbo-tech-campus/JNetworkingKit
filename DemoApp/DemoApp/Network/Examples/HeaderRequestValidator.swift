import Foundation
import JNetworkingKit

class HeaderRequestValidator: RequestValidatorType {
    func validate(response: Response) throws -> Any {
        guard !response.headers.isEmpty else {
            throw RequestValidatorError.invalidData(response: response)
        }

        print("Request headers:")
        response.headers.forEach { (key, value) in
            print("  - [\(key)] \(value)")
        }

        return ""
    }
}
