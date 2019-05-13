public class QueryBuilder {
    private var queryParameters = [String: String]()
    private var queryPath: String?

    func setPath(path: String) -> QueryBuilder {
        queryPath = path
        return self
    }

    func setParameter(key: String, value: String?) -> QueryBuilder {
        guard let existingValue = value else {
            return self
        }
        queryParameters[key] = existingValue
        return self
    }

    func setParameter(key: String, value: Int?) -> QueryBuilder {
        guard let existingValue = value else {
            return self
        }
        queryParameters[key] = String(existingValue)
        return self
    }

    func setParameters(parameters: [String: String]) -> QueryBuilder {
        queryParameters = queryParameters.merging(parameters, uniquingKeysWith: { (first, _) in first })
        return self
    }

    public func build() -> String? {
        let queryString = queryParameters.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")

        guard let path = self.queryPath else {
            return queryString
        }
        return path + "?" + queryString
    }
}
