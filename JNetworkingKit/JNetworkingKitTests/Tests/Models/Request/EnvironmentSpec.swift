import Quick
import Nimble

@testable import JNetworkingKit

class EnvironmentSpec: QuickSpec {

    override class func spec() {
        describe("Environment") {
            let serverStub = "http://www.jumbo.com"
            let pathStub = "backend"
            let versionStub: String? = nil
            var sut: Environment!

            beforeEach {
                sut = Environment(server: serverStub, path: pathStub, version: versionStub)
            }

            it("return the correct url") {
                expect(sut.url).to(equal("http://www.jumbo.com/backend"))
            }

            context("have multiple environments") {
                var newEnvironment: Environment!

                beforeEach {
                    newEnvironment = Environment(server: serverStub, path: pathStub, version: versionStub)
                }

                it("compares correctly environment with same configuration") {
                    expect(sut) == newEnvironment
                }
            }
        }
    }
}
