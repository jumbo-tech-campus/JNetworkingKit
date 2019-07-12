import Foundation

@objc
public class Response: NSObject {
    public var data: Data
    public var headers: [AnyHashable: Any]
    public var statusCode: Int

    public init(data: Data, headers: [AnyHashable: Any] = [:], statusCode: Int) {
        self.data = data
        self.headers = headers
        self.statusCode = statusCode
    }
}

extension Response {
    override public var description: String {
        return "<\(type(of: self)):\n\tdata = \(data)\n\theaders = \(headers)\n\tstatusCode = \(statusCode)>"
    }
}
