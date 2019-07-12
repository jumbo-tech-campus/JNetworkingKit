import Foundation
import UIKit
import JNetworkingKit

class ImageParser: RequestParserType {
    typealias Result = UIImage

    func parse(response: Response) throws -> UIImage {
        NetworkingLogger.log("Beginning to parse response", "Response: \(response)", loggedComponent: .parser)
        guard let image = UIImage(data: response.data) else {
            throw RequestParserError.invalidData(parserError: nil)
        }

        return image
    }
}
