import JNetworkingKit
import Foundation

extension Request: Equatable {
    public static func == (lhs: Request, rhs: Request) -> Bool {
        lhs.environment.url == rhs.environment.url
            && lhs.route == rhs.route
            && lhs.method == rhs.method
            && lhs.headers == rhs.headers
            && lhs.parameters == rhs.parameters
            && compareDatas(lhsData: lhs.data, rhsData: rhs.data)
    }

    private static func compareDatas(lhsData: Data?, rhsData: Data?) -> Bool {
        switch (lhsData, rhsData) {
        case (.none, .none): return true
        case (.none, .some): return false
        case (.some, .none): return false
        case (.some(let lhsData), .some(let rhsData)):
            let lhsDictionary = NSDictionary(dictionary: parse(data: lhsData))
            let rhsDictionary = parse(data: rhsData)

            return lhsDictionary.isEqual(to: rhsDictionary)
        }
    }

    private static func parse(data: Data) -> [String: Any] {
        guard let parsed = try? JSONSerialization.jsonObject(with: data),
              let dictionary = parsed as? [String: Any] else {
            return [:]
        }

        return dictionary
    }
}
