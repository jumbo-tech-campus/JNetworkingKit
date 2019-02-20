import Foundation

@testable import JNetworkingKit

class RequestValidatorMock {
    var captures = Captures()
    var stubs = Stubs()

    struct Captures {
        var validate: Validate?

        struct Validate {
            var response: Response?
        }
    }

    struct Stubs {
        lazy var validate = Validate()

        struct Validate {
            var error: Error?
        }
    }
}

extension RequestValidatorMock: RequestValidatorType {
    func validate(response: Response) throws {
        captures.validate = Captures.Validate(response: response)

        if let error = stubs.validate.error {
            throw error
        }
    }
}
