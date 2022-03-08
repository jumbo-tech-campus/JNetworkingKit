import Quick
import Nimble

@testable import JNetworkingKit

class QueryBuilderSpec: QuickSpec {
    override func spec() {
        describe("QueryBuilder") {
            let pathStub = "http://www.validurl.com"
            let dictionaryStub = ["dict1":"dictvalue1", "dict2":"dictvalue2"]
            let parameterStringStub = (key: "paramString1", value: "value1")
            let parameterStringSpaceStub = (key: "paramString2", value: "value2 ")
            let parameterIntStub = (key: "paramInt1", value: 1)
            let parameterQueryItemStub = URLQueryItem(name: "paramQuery1", value: "value1")
            let parameterNilStub: (key: String, value: String?) = (key: "paramNil", value: nil)

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
                        query = sut.setParameters(parameters: dictionaryStub)
                            .setParameter(key: parameterStringStub.key, value: parameterStringStub.value)
                            .setParameter(key: parameterStringSpaceStub.key, value: parameterStringSpaceStub.value)
                            .setParameter(key: parameterIntStub.key, value: parameterIntStub.value)
                            .setParameter(key: parameterNilStub.key, value: parameterNilStub.value)
                            .setParameter(queryItem: parameterQueryItemStub)
                            .build()
                        url = URL(string: pathStub + "?" + query)
                    }

                    it("creates a Valid url if a path is added") {
                        expect(url).toNot(beNil())
                    }

                    it("creates a query containing all dictionary values"){
                        expect(query).to(contain(dictionaryStub.map { (key, value) in
                            "\(key)=\(value)" }))
                    }

                    it("creates a query containing the string parameter"){
                        expect(query).to(contain(["\(parameterStringStub.key)=\(parameterStringStub.value)"]))
                    }

                    it("creates a query containing the encoded string parameter"){
                        expect(query).to(contain(["\(parameterStringSpaceStub.key)=\(parameterStringSpaceStub.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"]))
                    }

                    it("creates a query containing the int parameter as string"){
                        expect(query).to(contain(["\(parameterIntStub.key)=\(parameterIntStub.value)"]))
                    }

                    it("creates a query containing the query item parameter as string"){
                        let valueString: String = parameterQueryItemStub.value ?? ""
                        expect(query).to(contain(["\(parameterQueryItemStub.name)=\(valueString)"]))
                    }

                    it("creates a query without a empty nil parameter"){
                        expect(query).toNot(contain([parameterNilStub.key]))
                    }
                }

                context("only one parameter") {
                    beforeEach {
                        query = sut
                            .setParameter(key: parameterStringStub.key, value: parameterStringStub.value)
                            .build()
                    }

                    it("creates a valid query parameter") {
                        expect(query) == "?\(parameterStringStub.key)=\(parameterStringStub.value)"
                    }
                }

                context("two of the same parameters") {
                    beforeEach {
                        query = sut
                            .setParameter(key: parameterStringStub.key, value: parameterStringStub.value)
                            .setParameter(key: parameterStringStub.key, value: parameterStringStub.value)
                            .build()
                    }

                    it("creates a valid query parameter containing both parameters") {
                        expect(query) == "?\(parameterStringStub.key)=\(parameterStringStub.value)&\(parameterStringStub.key)=\(parameterStringStub.value)"
                    }
                }

                context("only nil parameter is set") {
                    beforeEach {
                        query = sut
                            .setParameter(key: parameterNilStub.key, value: parameterNilStub.value)
                            .build()
                    }

                    it("returns only the parameter key as a query") {
                        expect(query) == ""
                    }
                }

                context("one valid and one nil parameter is set") {
                    beforeEach {
                        query = sut
                            .setParameter(key: parameterStringStub.key, value: parameterStringStub.value)
                            .setParameter(key: parameterNilStub.key, value: parameterNilStub.value)
                            .build()
                    }

                    it("returns only the parameter key as a query") {
                        expect(query) == "?\(parameterStringStub.key)=\(parameterStringStub.value)"
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

