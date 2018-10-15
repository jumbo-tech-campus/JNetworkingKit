import Foundation
import JNetworkingKit

struct MovieRouter {
    static var list: RequestRoute {
        let path = "?apikey={apikey}&t={t}"
        let parameters = ["apikey": "1b3dce2d", "t": "Matrix"]
        return RequestRoute(path: path, parameters: parameters)
    }
}
