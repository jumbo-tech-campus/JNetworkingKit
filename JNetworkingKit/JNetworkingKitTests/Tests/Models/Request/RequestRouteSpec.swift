import Quick
import Nimble

@testable import JNetworkingKit

class RouteSpec: QuickSpec {

    override func spec() {
        describe("Route") {
            let pathStub = "product/{id}/{name}"
            let parametersStub = ["id": "1", "name": "Stub"]
            var sut: RequestRoute!

            beforeEach {
                sut = RequestRoute(path: pathStub, parameters: parametersStub)
            }

            it("return the correct url") {
                expect(sut.route).to(equal("product/1/Stub"))
            }
        }
    }
}
