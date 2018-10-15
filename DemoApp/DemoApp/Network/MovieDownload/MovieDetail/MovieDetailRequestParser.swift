import Foundation
import JNetworkingKit

class MovieDetailRequestParser: RequestParserType {
    func parse(response: Response) throws -> Movie {
        guard let data = response.data else {
            throw RequestParserError.noData
        }

        return try JSONDecoder().decode(Movie.self, from: data)
    }
}
