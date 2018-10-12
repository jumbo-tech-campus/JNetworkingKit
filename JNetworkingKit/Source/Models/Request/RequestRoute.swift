import Foundation

struct RequestRoute {
    var path: String
    var parameters: [String: String]?

    var route: String {
        return "\(path)".inject(parameters: parameters)
    }

    init(path: String, parameters: [String: String]? = nil) {
        self.path = path
        self.parameters = parameters
    }
}

extension RequestRoute: Equatable {
    static func == (lhs: RequestRoute, rhs: RequestRoute) -> Bool {
        return lhs.path == rhs.path
            && lhs.parameters == rhs.parameters
    }
}
