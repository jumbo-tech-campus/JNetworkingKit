import Foundation

public struct RequestRoute {
    var path: String
    var parameters: [String: String]?

    var route: String {
        return "\(path)".inject(parameters: parameters)
    }

    public init(path: String, parameters: [String: String]? = nil) {
        self.path = path
        self.parameters = parameters
    }
}

extension RequestRoute: Equatable {
    public static func == (lhs: RequestRoute, rhs: RequestRoute) -> Bool {
        return lhs.path == rhs.path
            && lhs.parameters == rhs.parameters
    }
}

public func + (lhs: RequestRoute, rhs: RequestRoute) -> RequestRoute {
    return RequestRoute(path: "\(lhs.route)/\(rhs.route)")
}

extension RequestRoute: CustomStringConvertible {
    public var description: String {
        return "<\(type(of: self)):\n\tpath = \(path)" +
                "\n\tparameters = \(parameters ?? [:])" +
                "\n\troute = \(route)>"
    }
}
