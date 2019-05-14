import Foundation

public class QueryBuilder {
    private var queryItems = [URLQueryItem]()

    public init() {

    }

    public func setParameter(queryItem: URLQueryItem) -> QueryBuilder {
        queryItems.append(queryItem)
        return self
    }

    public func setParameter(key: String, value: String?) -> QueryBuilder {
        queryItems.append(URLQueryItem(name: key, value: value))
        return self
    }

    public func setParameter(key: String, value: Int?) -> QueryBuilder {
        let stringValue = value.flatMap { String($0) }
        queryItems.append(URLQueryItem(name: key, value: stringValue))
        return self
    }

    public func setParameters(parameters: [String: String]) -> QueryBuilder {
        let queryParams = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value) }
        queryItems.append(contentsOf: queryParams)
        return self
    }

    public func build() -> String {
        var urlComponents = URLComponents()
        urlComponents.queryItems = queryItems

        return urlComponents.query ?? ""
    }
}
