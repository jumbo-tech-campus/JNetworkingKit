import Foundation
import JNetworkingKit

class MovieListRequestOperation: NSObject, RequestOperationType {
    typealias Result = [Movie]

    var executor = RequestExecutor()
    var parser = MovieListRequestParser()
    var request = Request(route: MovieRouter.list)
}
