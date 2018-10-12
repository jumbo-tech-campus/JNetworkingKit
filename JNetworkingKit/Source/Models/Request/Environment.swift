import Foundation

struct Environment {
    var server: String
    var path: String?
    var version: String?

    var url: String {
        return [server, path, version].compactMap({ $0 }).joined(separator: "/")
    }

    init(server: String, path: String? = nil, version: String? = nil) {
        self.server = server
        self.path = path
        self.version = version
    }
}

extension Environment: Equatable {
    static func == (lhs: Environment, rhs: Environment) -> Bool {
        return lhs.server == rhs.server
            && lhs.path == rhs.path
            && lhs.version == rhs.version
    }
}
