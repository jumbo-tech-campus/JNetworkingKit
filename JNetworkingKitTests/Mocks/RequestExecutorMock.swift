import Foundation

@testable import JNetworkingKit

class RequestExecutorMock {
    var captures = Captures()
    var stubs = Stubs()

    struct Captures {
        var performRequest: PerformRequest?

        struct PerformRequest {
            let onSuccess: ((Response) -> Void)
            let onError: ((Error) -> Void)
        }
    }

    struct Stubs {
        lazy var performRequest = PerformRequest()

        struct PerformRequest {
            var response: Response?
            var error: Error?
        }
    }
}

extension RequestExecutorMock: RequestExecutorType {
    var client: RequestClientType {
        return RequestClientMock()
    }

    func perform(request: Request, onSuccess: @escaping (Response) -> Void, onError: @escaping (Error) -> Void) {
        captures.performRequest = Captures.PerformRequest(onSuccess: onSuccess, onError: onError)

        if let response = stubs.performRequest.response {
            onSuccess(response)
        } else if let error = stubs.performRequest.error {
            onError(error)
        }
    }
}
