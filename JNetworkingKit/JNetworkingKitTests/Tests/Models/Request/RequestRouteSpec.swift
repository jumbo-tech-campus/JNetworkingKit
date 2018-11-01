import Quick
import Nimble

@testable import JNetworkingKit

class RouteSpec: QuickSpec {

    override func spec() {
        describe("Route") {
            var sut: RequestRoute!

            context("Init") {
                let pathStub = "product/{id}/{name}"
                let parametersStub = ["id": "1", "name": "Stub"]

                beforeEach {
                    sut = RequestRoute(path: pathStub, parameters: parametersStub)
                }

                it("return the correct url") {
                    expect(sut.route).to(equal("product/1/Stub"))
                }
            }

            describe("Add") {
                let lhsRoute = RequestRoute(path: "left")
                let rhsRoute = RequestRoute(path: "right")
                let lhsRouteWithParams = RequestRoute(path: "left/{leftId}", parameters: ["leftId": "1"])
                let rhsRouteWithParams = RequestRoute(path: "right/{rightId}", parameters: ["rightId": "2"])

                context("String plus Route") {
                    let lhsString = "string"

                    beforeEach {
                        sut = lhsString + rhsRouteWithParams
                    }

                    it("return the correct url") {
                        expect(sut.route).to(equal("string/right/2"))
                    }
                }

                context("Route plus Route") {
                    context("with left and right params") {
                        beforeEach {
                            sut = lhsRouteWithParams + rhsRouteWithParams
                        }

                        it("return the correct url") {
                            expect(sut.route).to(equal("left/1/right/2"))
                        }
                    }

                    context("with right params") {
                        beforeEach {
                            sut = lhsRoute + rhsRouteWithParams
                        }

                        it("return the correct url") {
                            expect(sut.route).to(equal("left/right/2"))
                        }
                    }

                    context("with left params") {
                        beforeEach {
                            sut = lhsRouteWithParams + rhsRoute
                        }

                        it("return the correct url") {
                            expect(sut.route).to(equal("left/1/right"))
                        }
                    }
                }
            }
        }
    }
}
