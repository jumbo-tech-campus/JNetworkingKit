import Quick
import Nimble

@testable import JNetworkingKit

class RequestOperationTypeSpec: QuickSpec {

    override func spec() {
        describe("RequestOperationType") {
            var executorMock: RequestExecutorMock!
            var parserMock: RequestParserMock!
            var requestMock: Request!
            var sut: ConcreteRequestOperation!

            beforeEach {
                executorMock = RequestExecutorMock()
                parserMock = RequestParserMock()
                requestMock = Request(url: "")
                sut = ConcreteRequestOperation(executor: executorMock, parser: parserMock, request: requestMock)
            }

            afterEach {
                executorMock = nil
                parserMock = nil
                requestMock = nil
                sut = nil
            }

            context("perform execute") {
                beforeEach {
                    sut.execute(onSuccess: { _ in }, onError: { _ in })
                }

                it("executes on the executor") {
                    expect(executorMock.captures.performRequest).toNot(beNil())
                }
            }

            context("execution succeed") {
                var expectedResult: String!
                let fakeResponse = Response(data: nil, statusCode: 0)
                var callbackThread: Thread!

                context("valid data received") {
                    beforeEach {
                        executorMock.stubs.performRequest.response = fakeResponse
                        parserMock.stubs.parse.result = "Fake result"

                        sut.execute(
                            onSuccess: { result in
                                expectedResult = result
                                callbackThread = Thread.current
                            },
                            onError: { _ in }
                        )
                    }

                    afterEach {
                        expectedResult = nil
                        callbackThread = nil
                    }

                    it("parses the data") {
                        expect(parserMock.captures.parse).toEventuallyNot(beNil())
                    }

                    it("sends the response received from the executor to the parser") {
                        expect(parserMock.captures.parse?.response).toEventually(equal(fakeResponse))
                    }

                    it("forwards the data to the onSuccess callback") {
                        expect(expectedResult).toEventually(equal(parserMock.stubs.parse.result))
                    }

                    it("performs the success callback on the main thread") {
                        expect(callbackThread.isMainThread).toEventually(equal(true))
                    }
                }

                context("invalid data received") {
                    var expectedError: Error!

                    beforeEach {
                        executorMock.captures.performRequest?.onSuccess(fakeResponse)
                        parserMock.stubs.parse.error = ErrorMock.stub

                        sut.execute(
                            onSuccess: { _ in },
                            onError: { error in
                                expectedError = error
                                callbackThread = Thread.current
                            }
                        )

                        executorMock.captures.performRequest?.onSuccess(fakeResponse)
                    }

                    afterEach {
                        expectedResult = nil
                        callbackThread = nil
                    }

                    it("forwards the parser error to the onError callback") {
                        expect(expectedError).toEventuallyNot(beNil())
                    }

                    it("performs the error callback on the main thread") {
                        expect(callbackThread.isMainThread).toEventually(equal(true))
                    }
                }
            }

            context("error during execution") {
                var expectedError: Error!

                beforeEach {
                    executorMock.stubs.performRequest.error = ErrorMock.stub

                    sut.execute(
                        onSuccess: { _ in },
                        onError: { error in
                            expectedError = error
                        }
                    )
                }

                it("forward the executor error to the onError callback") {
                    expect(expectedError).toNot(beNil())
                }
            }
        }
    }
}

class ConcreteRequestOperation: RequestOperationType {
    typealias Result = String

    var executor: RequestExecutorMock
    var parser: RequestParserMock
    var request: Request

    init(executor: RequestExecutorMock, parser: RequestParserMock, request: Request) {
        self.executor = executor
        self.parser = parser
        self.request = request
    }
}
