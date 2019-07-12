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
        return "<\(type(of: self)):\ndata = \(data)\nheaders = \(headers)\nstatusCode = \(statusCode)>"
    }
}
