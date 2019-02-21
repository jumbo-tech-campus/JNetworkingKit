import Foundation
import UIKit
import JNetworkingKit

class ImageParser: RequestParserType {
    func parse(response: Response) throws -> UIImage {
        guard let image = UIImage(data: response.data) else {
            throw RequestParserError.invalidData(parserError: nil)
        }

        return image
    }
}
