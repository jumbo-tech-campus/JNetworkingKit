import Quick
import Nimble

@testable import JNetworkingKit

class HttpStatusSpec: QuickSpec {

    override func spec() {
        describe("HttpStatus") {
            var statusCode: Int!

            describe("check informational response") {

                beforeEach {
                    statusCode = 150
                }

                afterEach {
                    statusCode = nil
                }

                it("initializes an informational response status code") {
                expect(HttpStatus.status(for: statusCode)).to(equal(.informationalResponse))
                }

                it("recognizes the status code as an informational response") {
                    expect(HttpStatus.isInformationalResponse(statusCode: statusCode)).to(equal(true))
                }
            }

            describe("check success response") {

                beforeEach {
                    statusCode = 250
                }

                afterEach {
                    statusCode = nil
                }

                it("initializes an success response status code") {
                    expect(HttpStatus.status(for: statusCode)).to(equal(.success))
                }

                it("recognizes the status code as a success response") {
                    expect(HttpStatus.isSuccessful(statusCode: statusCode)).to(equal(true))
                }
            }

            describe("check redirection response") {

                beforeEach {
                    statusCode = 350
                }

                afterEach {
                    statusCode = nil
                }

                it("initializes an redirection response status code") {
                    expect(HttpStatus.status(for: statusCode)).to(equal(.redirection))
                }

                it("recognizes the status code as a redirection response") {
                    expect(HttpStatus.isRedirection(statusCode: statusCode)).to(equal(true))
                }
            }

            describe("check client error response") {

                beforeEach {
                    statusCode = 450
                }

                afterEach {
                    statusCode = nil
                }

                it("initializes an client error response status code") {
                    expect(HttpStatus.status(for: statusCode)).to(equal(.clientError))
                }

                it("recognizes the status code as a client error response") {
                    expect(HttpStatus.isClientError(statusCode: statusCode)).to(equal(true))
                }
            }

            describe("check server error response") {

                beforeEach {
                    statusCode = 550
                }

                afterEach {
                    statusCode = nil
                }

                it("initializes an server error response status code") {
                    expect(HttpStatus.status(for: statusCode)).to(equal(.serverError))
                }

                it("recognizes the status code as a server error response") {
                    expect(HttpStatus.isServerError(statusCode: statusCode)).to(equal(true))
                }
            }

            describe("check unknown response") {

                beforeEach {
                    statusCode = 999
                }

                afterEach {
                    statusCode = nil
                }

                it("initializes an redirection response status code") {
                    expect(HttpStatus.status(for: statusCode)).to(equal(.unknown))
                }

                it("recognizes the status code as a redirection response") {
                    expect(HttpStatus.isUnknown(statusCode: statusCode)).to(equal(true))
                }
            }
        }
    }
}
