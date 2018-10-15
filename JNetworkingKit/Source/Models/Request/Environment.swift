import Foundation

public struct Environment {
    private var server: String
    private var path: String?
    private var version: String?

    var url: String {
        return [server, path, version].compactMap({ $0 }).joined(separator: "/")
    }

    public init(server: String, path: String? = nil, version: String? = nil) {
        self.server = server
        self.path = path
        self.version = version
    }
}

extension Environment: Equatable {
    public static func == (lhs: Environment, rhs: Environment) -> Bool {
        return lhs.server == rhs.server
            && lhs.path == rhs.path
            && lhs.version == rhs.version
    }
}
