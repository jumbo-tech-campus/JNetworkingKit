import Quick
import Nimble

@testable import JNetworkingKit

final class DataEquatableSpec: QuickSpec {
    override class func spec() {
        describe("DataEquatableSpec") {
            context("when data is a json with multiple keys") {
                it("it compares it by key-value instead of bytes") {
                    let req1 = try generateMock(range: 0..<20)
                    let req2 = try generateMock(range: 0..<20)
                    expect(req1).to(equal(req2))
                }
            }

            context("when data objects are different") {
                it("returns false") {
                    let req1 = try generateMock(range: 1..<2)
                    let req2 = try generateMock(range: 2..<3)
                    expect(req1).toNot(equal(req2))
                }
            }
        }
    }

    private class func generateMock(range: Range<Int>) throws -> Request {
        let sequence = range.map { i in
            let string = String(i)
            return (string, string)
        }
        let mockJson = Dictionary<String, String>(uniqueKeysWithValues: sequence)
        let data = try JSONEncoder().encode(mockJson)

        return Request(
            environment: .init(server: "www.mockserver.com"),
            route: .init(path: "users", parameters: ["id" : "5"]),
            method: .get,
            headers: ["authorization": "super safe token"],
            parameters: ["param1": "a", "param2": "b"],
            data: data
        )
    }
}
