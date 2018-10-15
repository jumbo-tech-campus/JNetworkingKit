import Foundation

@objc
class Response: NSObject {
    var data: Data?
    var headers: [AnyHashable: Any]
    var statusCode: Int

    init(data: Data?, headers: [AnyHashable: Any] = [:], statusCode: Int) {
        self.data = data
        self.headers = headers
        self.statusCode = statusCode
    }
}
