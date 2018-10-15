import Foundation
import JNetworkingKit

class MovieDetailRequestOperation: NSObject, RequestOperationType {
    typealias Result = Movie

    var executor = RequestExecutor()
    var parser = MovieDetailRequestParser()
    var request = Request(route: MovieRouter.list)
}
