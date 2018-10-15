import Foundation
import JNetworkingKit

class MovieListRequestParser: RequestParserType {
    func parse(response: Response) throws -> [Movie] {
//        guard let data = response.data else {
//            throw RequestParserError.noData
//        }
//
//        let response = try JSONDecoder().decode(Movie.self, from: data)
//        return response.products.data

        return [Movie]()
    }
}
