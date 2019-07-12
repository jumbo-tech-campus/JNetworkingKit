import Foundation

public enum LoggedComponent: String {
    case client = "[💁‍♂️ Client]"
    case executor = "[🚀 Executor]"
    case validator = "[🔎 Validator]"
    case parser = "[📚 Parser]"
    case operation = "[⚙️ Operation]"
}

public enum LogLevel {
    case basic
    case verbose
}

public final class NetworkingLogger {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy hh:mm:ss:SSS"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    static public var isLoggingEnabled: Bool = false
    static public var logLevel: LogLevel = .basic

    static public func log(_ baseObject: Any,
                           _ deepObject: Any = "",
                           loggedComponent: LoggedComponent,
                           fileName: String = #file,
                           line: Int = #line,
                           methodName: String = #function) {
        if NetworkingLogger.isLoggingEnabled {
            let totalObject = logLevel == .verbose ? "\(baseObject) \(deepObject)" : "\(baseObject)"
            print("\(loggedComponent.rawValue) \(Date().toString()): " +
                "[\(sourceFileName(filePath: fileName))]:" +
                "\(line) \(methodName) -> \(totalObject)")
        }
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.last ?? ""
    }
}

fileprivate extension Date {
    func toString() -> String {
        return NetworkingLogger.dateFormatter.string(from: self as Date)
    }
}
