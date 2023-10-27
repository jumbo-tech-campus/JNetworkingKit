import Quick
import Nimble

@testable import JNetworkingKit

class RequestRouteSpec: QuickSpec {

    override class func spec() {
        describe("RequestRoute") {
            var sut: RequestRoute!
            var pathStub: String!
            var parametersStub: [String: String]!

            beforeEach {
                pathStub = "product/{id}/{name}"
                parametersStub = ["id": "1", "name": "Stub"]
                sut = RequestRoute(path: pathStub, parameters: parametersStub)
            }

            afterEach {
                sut = nil
                parametersStub = nil
                pathStub = nil
            }

            it("returns the route") {
                expect(sut.route).to(equal("product/1/Stub"))
            }

            describe("combine a route") {
                var lhsRoute: RequestRoute!
                var rhsRoute: RequestRoute!
                var lhsRouteWithParams: RequestRoute!
                var rhsRouteWithParams: RequestRoute!

                beforeEach {
                    lhsRoute = RequestRoute(path: "left")
                    rhsRoute = RequestRoute(path: "right")
                    lhsRouteWithParams = RequestRoute(path: "left/{leftId}", parameters: ["leftId": "1"])
                    rhsRouteWithParams = RequestRoute(path: "right/{rightId}", parameters: ["rightId": "2"])
                }

                afterEach {
                    lhsRoute = nil
                    rhsRoute = nil
                    lhsRouteWithParams = nil
                    rhsRouteWithParams = nil
                }

                context("with parameters to route with parameters") {
                    beforeEach {
                        sut = lhsRouteWithParams + rhsRouteWithParams
                    }

                    afterEach {
                        sut = nil
                    }

                    it("returns the route") {
                        expect(sut.route).to(equal("left/1/right/2"))
                    }
                }

                context("without parameters to route with parameters") {
                    beforeEach {
                        sut = lhsRoute + rhsRouteWithParams
                    }

                    afterEach {
                        sut = nil
                    }

                    it("returns the route") {
                        expect(sut.route).to(equal("left/right/2"))
                    }
                }

                context("with parameters to route without parameters") {
                    beforeEach {
                        sut = lhsRouteWithParams + rhsRoute
                    }

                    afterEach {
                        sut = nil
                    }

                    it("returns the route") {
                        expect(sut.route).to(equal("left/1/right"))
                    }
                }
            }
        }
    }
}
