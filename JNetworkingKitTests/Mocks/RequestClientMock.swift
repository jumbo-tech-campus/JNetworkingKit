import Foundation

@testable import JNetworkingKit

class RequestClientMock {
    var captures = Captures()

    struct Captures {
        var performRequest: PerformRequest?

        struct PerformRequest {
            var request: Request?
            var onSuccess: ((Response) -> Void)?
            var onError: ((RequestClientError) -> Void)?
        }
    }
}

extension RequestClientMock: RequestClientType {
    func perform(request: Request, onSuccess: @escaping (Response) -> Void, onError: @escaping (RequestClientError) -> Void) {
        captures.performRequest = Captures.PerformRequest(request: request, onSuccess: onSuccess, onError: onError)
    }
}
