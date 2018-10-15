import Foundation
import JNetworkingKit

extension Environment {
    static var active: Environment = production

    static let develop = Environment(server: "https://develop.jumbo.com",
                                        path: "testBackend",
                                        version: "V100")

    static let production = Environment(server: "https://mobileapi.jumbo.com",
                                        version: "V3")
}

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
