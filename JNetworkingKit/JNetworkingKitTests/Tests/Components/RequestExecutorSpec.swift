import Quick
import Nimble

@testable import JNetworkingKit

class RequestExecutorSpec: QuickSpec {

    override func spec() {
        describe("RequestExecutor") {
            var sut: RequestExecutor!

            beforeEach {
                sut = RequestExecutor()
            }

            afterEach {
                sut = nil
            }

            it("uses shared URLSession") {
                expect(sut.client).to(beIdenticalTo(URLSession.shared))
            }
        }
    }
}
