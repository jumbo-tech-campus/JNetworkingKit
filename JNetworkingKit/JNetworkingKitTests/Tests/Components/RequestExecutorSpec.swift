import Quick
import Nimble

@testable import JNetworkingKit

class RequestExecutorSpec: QuickSpec {

    override class func spec() {
        describe("RequestExecutor") {
            var sut: RequestExecutor!

            beforeEach {
                sut = RequestExecutor()
            }

            afterEach {
                sut = nil
            }

            it("uses shared URLSession") {
                let x: RequestClientType = URLSession.shared
                expect(sut.client).to(beIdenticalTo(x))
            }
        }
    }
}
