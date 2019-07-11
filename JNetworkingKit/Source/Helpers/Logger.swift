import Foundation

public enum LoggedComponent: String {
    case client = "[💁‍♂️]"
    case executor = "[🚀]"
    case validator = "[🔎]"
    case parser = "[📚]"
    case operation = "[⚙️]"
}

public final class Logger {
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    private static var isLoggingEnabled: Bool = false

    static func log(_ object: Any,
                    loggedComponent: LoggedComponent,
                    fileName: String = #file,
                    line: Int = #line,
                    methodName: String = #function) {
        if isLoggingEnabled {
            // swiftlint:disable:next line_length
            print("\(loggedComponent.rawValue) \(Date().toString()): [\(sourceFileName(filePath: fileName))]:\(line) \(methodName) -> \(object)")
        }
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.last ?? ""
    }
}

func print(_ object: Any) {
    #if DEBUG
    Swift.print(object)
    #endif
}

fileprivate extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
