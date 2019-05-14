import Foundation

open class RequestExecutor: RequestExecutorType {
    open var client: RequestClientType {
        return URLSession.shared
    }

    public init() {}
}
