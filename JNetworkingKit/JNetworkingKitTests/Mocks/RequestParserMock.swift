import Foundation

@testable import JNetworkingKit

class RequestParserMock {
    var captures = Captures()
    var stubs = Stubs()

    struct Captures {
        var parse: Parse?

        struct Parse {
            var response: Response?
        }
    }

    struct Stubs {
        lazy var parse = Parse()

        struct Parse {
            var error: Error?
            var result: String?
        }
    }
}

extension RequestParserMock: RequestParserType {
    func parse(response: Response) throws -> String {
        captures.parse = Captures.Parse(response: response)

        if let error = stubs.parse.error {
            throw error
        }

        return stubs.parse.result!
    }
}
