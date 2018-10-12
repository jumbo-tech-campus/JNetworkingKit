import Quick
import Nimble

@testable import JNetworkingKit

class RequestSpec: QuickSpec {

    override func spec() {
        describe("Request") {
            let environmentStub = Environment(server: "http://www.jumbo.com")
            let routeStub = RequestRoute(path: "{id}/{quantity}", parameters: ["id": "1", "quantity": "2"])
            var sut: Request!

            beforeEach {
                sut = Request(environment: environmentStub, route: routeStub)
            }

            it("return the correct url") {
                expect(sut.url?.absoluteString).to(equal("http://www.jumbo.com/1/2"))
            }

            describe("check if two request are equal") {

                it("recognize equal requests") {
                    let sameRequest = Request(environment: environmentStub, route: routeStub)
                    expect(sut).to(equal(sameRequest))
                }

                it("recognize different requests") {
                    let sameRequest = Request(environment: Environment(server: "http://www.test.com"), route: routeStub)
                    expect(sut).toNot(equal(sameRequest))
                }
            }
        }
    }
}
