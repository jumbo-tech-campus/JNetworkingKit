import Foundation

public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String: String]

public struct Request {
    public enum Method: String {
        case get
        case post
        case put
        case delete
    }

    var environment: Environment
    var route: RequestRoute?

    var method: Request.Method
    var headers: RequestHeaders
    var parameters: RequestParameters
    var data: Data?

    var url: URL? {
        return URL(string: [environment.url, route?.route].compactMap({ $0 }).joined(separator: "/"))
    }

    public var debugUrl: String {
        return url?.absoluteString ?? "unknown url"
    }

    public init(environment: Environment,
                route: RequestRoute? = nil,
                method: Request.Method = .get,
                headers: RequestHeaders = [:],
                parameters: RequestParameters = [:],
                data: Data? = nil) {
        self.environment = environment
        self.route = route
        self.method = method
        self.headers = headers
        self.parameters = parameters
        self.data = data
    }

    public init(url: String) {
        self.init(environment: Environment(server: url))
    }
}

extension Request: Equatable {
    public static func == (lhs: Request, rhs: Request) -> Bool {
        return lhs.environment.url == rhs.environment.url
            && lhs.route == rhs.route
            && lhs.method == rhs.method
            && lhs.headers == rhs.headers
            && lhs.parameters == rhs.parameters
            && lhs.data == rhs.data
    }
}
