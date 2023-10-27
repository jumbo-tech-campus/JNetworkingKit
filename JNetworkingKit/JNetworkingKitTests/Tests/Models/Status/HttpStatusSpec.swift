import Quick
import Nimble

@testable import JNetworkingKit

class HttpStatusSpec: QuickSpec {

    override class func spec() {
        describe("HttpStatus") {
            var sut: HttpStatus!

            afterEach {
                sut = nil
            }

            describe("check informational response") {
                beforeEach {
                    sut = HttpStatus(150)
                }

                it("initializes an informational response status code") {
                    expect(sut).to(equal(.informationalResponse))
                }

                it("recognizes the status code as an informational response") {
                    expect(sut.isInformationalResponse).to(equal(true))
                }
            }

            describe("check success response") {
                beforeEach {
                    sut = HttpStatus(250)
                }

                it("initializes a success response status code") {
                    expect(sut).to(equal(.success))
                }

                it("recognizes the status code as a success response") {
                    expect(sut.isSuccessful).to(equal(true))
                }
            }

            describe("check redirection response") {
                beforeEach {
                    sut = HttpStatus(350)
                }

                it("initializes an redirection response status code") {
                    expect(sut).to(equal(.redirection))
                }

                it("recognizes the status code as a redirection response") {
                    expect(sut.isRedirection).to(equal(true))
                }
            }

            describe("check client error response") {
                beforeEach {
                    sut = HttpStatus(450)
                }

                it("initializes an client error response status code") {
                    expect(sut).to(equal(.clientError))
                }

                it("recognizes the status code as a client error response") {
                    expect(sut.isClientError).to(equal(true))
                }
            }

            describe("check server error response") {
                beforeEach {
                    sut = HttpStatus(550)
                }

                it("initializes an server error response status code") {
                    expect(sut).to(equal(.serverError))
                }

                it("recognizes the status code as a server error response") {
                    expect(sut.isServerError).to(equal(true))
                }
            }

            describe("check unknown response") {
                beforeEach {
                    sut = HttpStatus(999)
                }

                it("initializes an redirection response status code") {
                    expect(sut).to(equal(.unknown))
                }

                it("recognizes the status code as a redirection response") {
                    expect(sut.isUnknown).to(equal(true))
                }
            }
        }
    }
}
