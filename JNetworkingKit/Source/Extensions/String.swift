import Foundation

internal extension String {
    func inject(parameters: [String: Any]?) -> String {
        var result = self

        try? NSRegularExpression(pattern: "\\{(\\w{1,})\\}")
            .matches(in: result, range: NSRange(location: 0, length: result.count))
            .reversed()
            .forEach { match in
                guard
                    let fullRange = Range(match.range, in: result),
                    let keyRange = Range(match.range(at: 1), in: result) else {
                        return
                }

                let match = String(result[fullRange])
                let key = String(result[keyRange])

                if let value = parameters?[key] {
                    result = result.replacingOccurrences(of: match, with: "\(value)")
                }
        }

        return result
    }
}
