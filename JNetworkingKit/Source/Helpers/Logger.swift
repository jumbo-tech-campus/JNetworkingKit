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
    case deep
}

public final class Logger {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    static public var isLoggingEnabled: Bool = false
    static public var logLevel: LogLevel = .basic

    static func log(_ baseObject: Any,
                    _ deepObject: Any,
                    loggedComponent: LoggedComponent,
                    fileName: String = #file,
                    line: Int = #line,
                    methodName: String = #function) {
        #if DEBUG
        if Logger.isLoggingEnabled {
            let totalObject = logLevel == .deep ? "\(baseObject) \(deepObject)" : "\(baseObject)"
            // swiftlint:disable:next line_length
            print("\(loggedComponent.rawValue) \(Date().toString()): [\(sourceFileName(filePath: fileName))]:\(line) \(methodName) -> \(totalObject)")
        }
        #endif
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.last ?? ""
    }
}

fileprivate extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
