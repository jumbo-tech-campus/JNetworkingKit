import Foundation
import JNetworkingKit

extension Environment {
    static var active: Environment = production

    static let develop = Environment(server: "http://192.168.0.1",
                                        path: "test",
                                        version: "v1")

    static let production = Environment(server: "http://www.omdbapi.com")
}

//http://www.omdbapi.com/?apikey=[yourkey]&

extension Request {
    init(route: RequestRoute? = nil,
         method: Request.Method = .get,
         headers: RequestHeaders = [:],
         parameters: RequestParameters = [:],
         data: Data? = nil) {
        self.init(environment: Environment.active,
                  route: route,
                  method: method,
                  headers: headers,
                  parameters: parameters,
                  data: data)
    }
}
