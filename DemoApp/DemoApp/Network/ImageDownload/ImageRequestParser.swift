import Foundation
import UIKit
import JNetworkingKit

class ImageParser: RequestParserType {
    func parse(response: Response) throws -> UIImage {
        guard let data = response.data else {
            throw RequestParserError.noData
        }

        guard let image = UIImage(data: data) else {
            throw RequestParserError.invalidData
        }

        return image
    }
}
