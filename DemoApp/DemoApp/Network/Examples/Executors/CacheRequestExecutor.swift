import Foundation
import JNetworkingKit

class CacheRequestExecutor: RequestExecutorType {
    static var cachedResponse: Response?

    var client: RequestClientType {
        return URLSession.shared
    }

    func perform(request: Request, onSuccess: @escaping (Response) -> Void, onError: @escaping (Error) -> Void) {
        if let cachedResponse = CacheRequestExecutor.cachedResponse {
            print("Skipping network request")
            onSuccess(cachedResponse)
            return
        }

        print("Performing network request")

        client.perform(request: request,
        onSuccess: { (response) in
            CacheRequestExecutor.cachedResponse = response
            onSuccess(response)
        },
        onError: { (error) in
            onError(error)
        })
    }
}
