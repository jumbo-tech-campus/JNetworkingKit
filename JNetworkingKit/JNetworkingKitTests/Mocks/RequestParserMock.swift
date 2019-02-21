import Foundation

@testable import JNetworkingKit

class RequestParserMock {
    struct Captures {
        var parse: Parse?

        struct Parse {
            var data: Data?
        }
    }

    struct Stubs {
        var parse = Parse()

        struct Parse {
            var error: Error?
            var result: String?
        }
    }

    var captures = Captures()
    var stubs = Stubs()
}

extension RequestParserMock: RequestParserType {
    func parse(data: Data) throws -> String {
        captures.parse = Captures.Parse(data: data)

        if let error = stubs.parse.error {
            throw error
        }

        return stubs.parse.result!
    }
}
