import Foundation
import JNetworkingKit

struct MovieRouter {
    static var list: RequestRoute {
        let path = "apikey={apikey}&"
        let parameters = ["apikey": "<YOUR-OMDB-KEY>"]
        let query = QueryBuilder()
            .setParameter(key: "t", value: "Matrix")
            .setParameter(key: "type", value: "movie")
            .build()

        return RequestRoute(path: path + query, parameters: parameters)
    }
}
