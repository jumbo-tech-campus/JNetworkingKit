import Foundation

public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String: String]

public struct Request: Equatable {
    public enum Method: String {
        case get
        case post
        case put
        case delete
        case head
        case patch
    }

    public private(set) var environment: Environment
    public private(set) var route: RequestRoute?

    public private(set) var method: Request.Method
    public private(set) var headers: RequestHeaders
    public private(set) var parameters: RequestParameters
    public private(set) var data: Data?

    public var url: URL? {
        return URL(string: [environment.url, route?.route].compactMap({ $0 }).joined(separator: "/"))
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

extension Request: CustomStringConvertible {
    public var description: String {
        let routeString = route?.description ?? "nil"
        let dataString = data?.description ?? "nil"
        return "<\(type(of: self)):\n\tenvironment = \(environment)" +
                "\n\troute = \(routeString)" +
                "\n\tmethod = \(method)" +
                "\n\theaders = \(headers)\n\tparameters = \(parameters)\n\tdata = \(dataString)>"
    }
}

extension Request {
    public static func == (lhs: Request, rhs: Request) -> Bool {
        lhs.environment.url == rhs.environment.url
            && lhs.route == rhs.route
            && lhs.method == rhs.method
            && lhs.headers == rhs.headers
            && lhs.parameters == rhs.parameters
            && compareDatas(lhsData: lhs.data, rhsData: rhs.data)
    }

    private static func compareDatas(lhsData: Data?, rhsData: Data?) -> Bool {
        switch (lhsData, rhsData) {
        case (.none, .none): return true
        case (.none, .some): return false
        case (.some, .none): return false
        case (.some(let lhsData), .some(let rhsData)):
            let lhsDictionary = NSDictionary(dictionary: parse(data: lhsData))
            let rhsDictionary = parse(data: rhsData)

            return lhsDictionary.isEqual(to: rhsDictionary)
        }
    }

    private static func parse(data: Data) -> [String: Any] {
        guard let parsed = try? JSONSerialization.jsonObject(with: data),
              let dictionary = parsed as? [String: Any] else {
            return [:]
        }

        return dictionary
    }
}
