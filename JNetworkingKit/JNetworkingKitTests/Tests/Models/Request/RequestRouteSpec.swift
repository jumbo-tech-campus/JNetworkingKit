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

        describe("String+Route") {
            let lhsString = "lists"
            let rhsRoute = RequestRoute(path: "list/{listId}", parameters: ["listId": "1"])
            var sut: RequestRoute!

            beforeEach {
                sut = lhsString + rhsRoute
            }

            it("return the correct url") {
                expect(sut.route).to(equal("lists/list/1"))
            }
        }

        describe("RouteWithParams+RouteWithParams") {
            let lhsRoute = RequestRoute(path: "list/{listId}", parameters: ["listId": "1"])
            let rhsRoute = RequestRoute(path: "item/{itemId}", parameters: ["itemId": "2"])
            var sut: RequestRoute!

            beforeEach {
                sut = lhsRoute + rhsRoute
            }

            it("return the correct url") {
                expect(sut.route).to(equal("list/1/item/2"))
            }
        }

        describe("Route+RouteWithParams") {
            let lhsRoute = RequestRoute(path: "lists")
            let rhsRoute = RequestRoute(path: "list/{listId}", parameters: ["listId": "1"])
            var sut: RequestRoute!

            beforeEach {
                sut = lhsRoute + rhsRoute
            }

            it("return the correct url") {
                expect(sut.route).to(equal("lists/list/1"))
            }
        }

        describe("RouteWithParams+Route") {
            let lhsRoute = RequestRoute(path: "list/{listId}", parameters: ["listId": "1"])
            let rhsRoute = RequestRoute(path: "items")
            var sut: RequestRoute!

            beforeEach {
                sut = lhsRoute + rhsRoute
            }

            it("return the correct url") {
                expect(sut.route).to(equal("list/1/items"))
            }
        }
    }
}
