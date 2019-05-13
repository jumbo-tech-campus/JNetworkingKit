import Quick
import Nimble

@testable import JNetworkingKit

class QueryBuilderSpec: QuickSpec {
    override func spec() {
        describe("QueryBuilderSpec") {
            let pathStub = "http://www.validurl.com"
            let dictionaryStub = ["dict1":"dictvalue1", "dict2":"dictvalue2"]
            let parameterStringStub = (key: "paramString1", value: "value1")
            let parameterIntStub = (key: "paramInt1", value: 1)

            var sut: QueryBuilder!

            beforeEach {
                sut = QueryBuilder()
            }

            afterEach {
                sut = nil
            }

            describe("create a get query") {
                var query: String!
                var url: URL?

                afterEach {
                    query = nil
                }

                context("all fields are set") {
                    beforeEach {
                        query = sut.setPath(path: pathStub)
                            .setParameters(parameters: dictionaryStub)
                            .setParameter(key: parameterStringStub.key, value: parameterStringStub.value)
                            .setParameter(key: parameterIntStub.key, value: parameterIntStub.value)
                            .build()
                        url = URL(string: query)
                    }

                    it("creates a Valid url") {
                        expect(url).toNot(beNil())
                    }

                    it("creates a final url containing all dictionary values"){
                        expect(query).to(contain(["dict1=dictvalue1", "dict2=dictvalue2"]))
                    }

                    it("creates a final url containing the string parameter"){
                        expect(query).to(contain(["paramString1=value1"]))
                    }

                    it("creates a final url containing the int parameter as string"){
                        expect(query).to(contain(["paramInt1=1"]))
                    }

                    it("creates a final url starting with the path plus ? character"){
                        expect(query.prefix(pathStub.count + 1)) == "http://www.validurl.com?"
                    }
                }

                context("all fields are set except path") {
                    beforeEach {
                        query = sut.setParameters(parameters: dictionaryStub)
                            .setParameter(key: parameterStringStub.key, value: parameterStringStub.value)
                            .setParameter(key: parameterIntStub.key, value: parameterIntStub.value)
                            .build()
                        url = URL(string: pathStub + "?" + query)
                    }

                    it("creates a Valid url if a path is added") {
                        expect(url).toNot(beNil())
                    }

                    it("creates a query containing all dictionary values"){
                        expect(query).to(contain(["dict1=dictvalue1", "dict2=dictvalue2"]))
                    }

                    it("creates a query containing the string parameter"){
                        expect(query).to(contain(["paramString1=value1"]))
                    }

                    it("creates a query containing the int parameter as string"){
                        expect(query).to(contain(["paramInt1=1"]))
                    }
                }

                context("only one parameter") {
                    beforeEach {
                        query = sut.setParameter(key: parameterStringStub.key, value: parameterStringStub.value).build()
                    }

                    it("creates a valid query parameter") {
                        expect(query) == "paramString1=value1"
                    }
                }

                context("no fields are set") {
                    beforeEach {
                        query = sut.build()
                    }

                    it("returns a empty string") {
                        expect(query).to(beEmpty())
                    }
                }
            }
        }
    }
}
