import Quick
import Nimble

@testable import JNetworkingKit

class RequestExecutorTypeSpec: QuickSpec {

    override class func spec() {
        describe("RequestExecutorType") {
            var clientMock: RequestClientMock!
            var requestMock: Request!
            var sut: ConcreteRequestExecutor!

            beforeEach {
                clientMock = RequestClientMock()
                requestMock = Request(url: "")
                sut = ConcreteRequestExecutor(client: clientMock)
            }

            afterEach {
                requestMock = nil
                sut = nil
            }

            context("perform execute") {
                let expectedOnSuccess: (Response) -> Void = { _ in }
                let expectedOnError: (Error) -> Void = { _ in }

                beforeEach {
                    sut.perform(request: requestMock, onSuccess: expectedOnSuccess, onError: expectedOnError)
                }

                it("forward execution to the client") {
                    expect(clientMock.captures.performRequest?.request).to(equal(requestMock))
                    expect(clientMock.captures.performRequest?.onSuccess).toNot(beNil())
                    expect(clientMock.captures.performRequest?.onError).toNot(beNil())
                }
            }
        }
    }
}

class ConcreteRequestExecutor: RequestExecutorType {
    var client: RequestClientType

    init(client: RequestClientType) {
        self.client = client
    }
}
