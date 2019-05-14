import Foundation

public class QueryBuilder {
    private var queryItems = [URLQueryItem]()

    public init() {

    }

    public func setParameter(key: String, value: String?) -> QueryBuilder {
        guard let existingValue = value else {
            return self
        }
        queryItems.append(URLQueryItem(name: key, value: existingValue))
        return self
    }

    public func setParameter(key: String, value: Int?) -> QueryBuilder {
        guard let existingValue = value else {
            return self
        }
        queryItems.append(URLQueryItem(name: key, value: String(existingValue)))
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
