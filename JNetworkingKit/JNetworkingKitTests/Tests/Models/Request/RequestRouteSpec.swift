import Quick
import Nimble

@testable import JNetworkingKit

class RequestRouteSpec: QuickSpec {

    override func spec() {
        describe("RequestRoute") {
            var sut: RequestRoute!

            let pathStub = "product/{id}/{name}"
            let parametersStub = ["id": "1", "name": "Stub"]

            beforeEach {
                sut = RequestRoute(path: pathStub, parameters: parametersStub)
            }

            it("returns the correct route") {
                expect(sut.route).to(equal("product/1/Stub"))
            }

            describe("combine two RequestRoutes") {
                let lhsRoute = RequestRoute(path: "left")
                let rhsRoute = RequestRoute(path: "right")
                let lhsRouteWithParams = RequestRoute(path: "left/{leftId}", parameters: ["leftId": "1"])
                let rhsRouteWithParams = RequestRoute(path: "right/{rightId}", parameters: ["rightId": "2"])

                context("with left and right params") {
                    beforeEach {
                        sut = lhsRouteWithParams + rhsRouteWithParams
                    }

                    it("returns the correct route") {
                        expect(sut.route).to(equal("left/1/right/2"))
                    }
                }

                context("with right params") {
                    beforeEach {
                        sut = lhsRoute + rhsRouteWithParams
                    }

                    it("returns the correct route") {
                        expect(sut.route).to(equal("left/right/2"))
                    }
                }

                context("with left params") {
                    beforeEach {
                        sut = lhsRouteWithParams + rhsRoute
                    }

                    it("returns the correct route") {
                        expect(sut.route).to(equal("left/1/right"))
                    }
                }
            }
        }
    }
}
