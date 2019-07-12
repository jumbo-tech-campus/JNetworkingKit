import Foundation

public protocol RequestExecutorType {
    var client: RequestClientType { get }
    func perform(request: Request, onSuccess: @escaping (Response) -> Void, onError: @escaping (Error) -> Void)
}

extension RequestExecutorType {
    public func perform(request: Request, onSuccess: @escaping (Response) -> Void, onError: @escaping (Error) -> Void) {
        NetworkingLogger.log("Beginning to perform request", "\n\tRequest: \(request)", loggedComponent: .executor)
        client.perform(request: request, onSuccess: onSuccess, onError: onError)
    }
}
