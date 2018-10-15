import Foundation

public enum RequestClientError: Error, Hashable {
    case generic(message: String)
    case invalidRequest
    case invalidResponse
    case noData
}

public protocol RequestClientType {
    func perform(request: Request,
                 onSuccess: @escaping (Response) -> Void,
                 onError: @escaping (RequestClientError) -> Void)
}
