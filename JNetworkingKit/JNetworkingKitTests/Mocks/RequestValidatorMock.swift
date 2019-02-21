import Foundation

@testable import JNetworkingKit

class RequestValidatorMock {
    struct Captures {
        var validate: Validate?

        struct Validate {
            var response: Response?
        }
    }

    struct Stubs {
        var validate = Validate()

        struct Validate {
            var error: Error?
        }
    }

    var captures = Captures()
    var stubs = Stubs()
}

extension RequestValidatorMock: RequestValidatorType {
    var operationError: ((Error) -> Error)?  { return nil }

    func validate(response: Response) throws {
        captures.validate = Captures.Validate(response: response)

        if let error = stubs.validate.error {
            throw error
        }
    }
}
