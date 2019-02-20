public enum HttpStatus {
    case informationalResponse
    case success
    case redirection
    case clientError
    case serverError
    case unknown

    static public func status(for statusCode: Int) -> HttpStatus {
        switch statusCode {
        case 100...199:
            return .informationalResponse
        case 200...299:
            return .success
        case 300...399:
            return .redirection
        case 400...499:
            return .clientError
        case 500...599:
            return .serverError
        default:
            return .unknown
        }
    }

    static public func isInformationalResponse(statusCode: Int) -> Bool {
        return HttpStatus.status(for: statusCode) == .informationalResponse
    }

    static public func isSuccessful(statusCode: Int) -> Bool {
        return HttpStatus.status(for: statusCode) == .success
    }

    static public func isRedirection(statusCode: Int) -> Bool {
        return HttpStatus.status(for: statusCode) == .redirection
    }

    static public func isClientError(statusCode: Int) -> Bool {
        return HttpStatus.status(for: statusCode) == .clientError
    }

    static public func isServerError(statusCode: Int) -> Bool {
        return HttpStatus.status(for: statusCode) == .serverError
    }

    static public func isUnknown(statusCode: Int) -> Bool {
        return HttpStatus.status(for: statusCode) == .unknown
    }
}
