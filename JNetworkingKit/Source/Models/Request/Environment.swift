import Foundation

@objc
public class Environment: NSObject {
    private var server: String
    private var path: String?
    private var version: String?

    @objc
    public var url: String {
        return [server, path, version].compactMap({ $0 }).joined(separator: "/")
    }

    public init(server: String, path: String? = nil, version: String? = nil) {
        self.server = server
        self.path = path
        self.version = version
    }

    public override func isEqual(_ object: Any?) -> Bool {
        guard let environment = object as? Environment else {
            return false
        }

        return server == environment.server
            && path == environment.path
            && version == environment.version
    }
}
