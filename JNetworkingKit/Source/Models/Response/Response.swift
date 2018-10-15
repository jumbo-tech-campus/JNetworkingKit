import Foundation

@objc
public class Response: NSObject {
    public var data: Data?
    public var headers: [AnyHashable: Any]
    public var statusCode: Int

    init(data: Data?, headers: [AnyHashable: Any] = [:], statusCode: Int) {
        self.data = data
        self.headers = headers
        self.statusCode = statusCode
    }
}
