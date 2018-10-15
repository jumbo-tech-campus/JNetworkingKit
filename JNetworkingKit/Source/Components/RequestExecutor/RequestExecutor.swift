import Foundation

class RequestExecutor: RequestExecutorType {
    var client: RequestClientType {
        return URLSession.shared
    }
}
