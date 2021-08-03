import Foundation

public class QueryBuilder {
    private var queryItems = [URLQueryItem]()

    public init() {

    }

    @discardableResult
    public func setParameter(queryItem: URLQueryItem) -> QueryBuilder {
        queryItems.append(queryItem)
        return self
    }

    public func setParameter(key: String, value: String?) -> QueryBuilder {
        return setParameter(queryItem: URLQueryItem(name: key, value: value))
    }

    public func setParameter(key: String, value: Int?) -> QueryBuilder {
        let stringValue = value.flatMap { String($0) }
        return setParameter(queryItem: URLQueryItem(name: key, value: stringValue))
    }

    public func setParameters(parameters: [String: String]) -> QueryBuilder {
        parameters
            .map { URLQueryItem(name: $0, value: $1) }
            .forEach { setParameter(queryItem: $0) }

        return self
    }

    public func build() -> String {
        let itemsWithValue = queryItems.filter { $0.value != nil }

        var urlComponents = URLComponents()
        urlComponents.queryItems = itemsWithValue.isEmpty ? nil : itemsWithValue

        return urlComponents.url?.absoluteString ?? ""
    }
}
