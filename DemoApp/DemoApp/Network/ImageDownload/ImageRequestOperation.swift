import Foundation
import UIKit
import JNetworkingKit

class ImageOperation: NSObject, RequestOperationType {
    typealias Result = UIImage

    var executor = RequestExecutor()
    var parser = ImageParser()
    var request: Request
    var validator = RequestValidator()

    @objc
    init(url: String) {
        self.request = Request(url: url)
    }

    @objc
    static func getImage(url: String, onSuccess: @escaping (UIImage) -> Void, onError: @escaping (Error) -> Void) {
        ImageOperation(url: url).execute(onSuccess: onSuccess, onError: onError)
    }
}
