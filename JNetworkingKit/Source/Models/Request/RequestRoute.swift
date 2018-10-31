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
    let combinedPath = "\(lhs.path)/\(rhs.path)"
    var combinedParameters = lhs.parameters

    if let rhsParameters = rhs.parameters {
        combinedParameters?.merge(rhsParameters) { (current, _) in current }
    }

    return RequestRoute(path: combinedPath, parameters: combinedParameters)
}

public func + (lhs: String, rhs: RequestRoute) -> RequestRoute {
    let combinedPath = "\(lhs)/\(rhs.path)"

    return RequestRoute(path: combinedPath, parameters: rhs.parameters)
}
