import Foundation

@testable import JNetworkingKit

class ResponseMiddlewareMock {
    struct Captures {
        var process: Process?

        struct Process {
            var request: Request
            var response: Response
        }
    }

    var captures = Captures()
}

extension ResponseMiddlewareMock: ResponseMiddlewareType {
    func process(request: Request, response: Response) {
        captures.process = Captures.Process(request: request, response: response)
    }
}
