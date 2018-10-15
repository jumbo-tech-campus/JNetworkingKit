import Foundation

public class RequestExecutor: RequestExecutorType {
    public var client: RequestClientType {
        return URLSession.shared
    }

    public init() {}
}
