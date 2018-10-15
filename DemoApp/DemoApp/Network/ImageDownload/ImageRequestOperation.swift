import Foundation
import UIKit
import JNetworkingKit

class ImageOperation: NSObject, RequestOperationType {
    typealias Result = UIImage

    var executor: RequestExecutor = RequestExecutor()
    var parser: ImageParser = ImageParser()
    var request: Request

    @objc
    init(url: String) {
        self.request = Request(url: url)
    }

    @objc
    static func getImage(url: String, onSuccess: @escaping (UIImage) -> Void, onError: @escaping (Error) -> Void) {
        ImageOperation(url: url).execute(onSuccess: onSuccess, onError: onError)
    }
}
