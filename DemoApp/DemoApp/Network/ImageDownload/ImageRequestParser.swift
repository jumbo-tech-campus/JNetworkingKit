import Foundation
import UIKit
import JNetworkingKit

class ImageParser: RequestParserType {
    func parse(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw RequestParserError.invalidData(parserError: nil)
        }

        return image
    }
}
