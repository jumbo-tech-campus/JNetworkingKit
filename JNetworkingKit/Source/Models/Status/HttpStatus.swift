public enum HttpStatus {
    case informationalResponse
    case success
    case redirection
    case clientError
    case serverError
    case unknown

    init(_ statusCode: Int) {
        switch statusCode {
        case 100...199:
            self = .informationalResponse
        case 200...299:
            self = .success
        case 300...399:
            self = .redirection
        case 400...499:
            self = .clientError
        case 500...599:
            self = .serverError
        default:
            self = .unknown
        }
    }

    static public func isInformationalResponse(statusCode: Int) -> Bool {
        return HttpStatus(statusCode) == .informationalResponse
    }

    static public func isSuccessful(statusCode: Int) -> Bool {
        return HttpStatus(statusCode) == .success
    }

    static public func isRedirection(statusCode: Int) -> Bool {
        return HttpStatus(statusCode) == .redirection
    }

    static public func isClientError(statusCode: Int) -> Bool {
        return HttpStatus(statusCode) == .clientError
    }

    static public func isServerError(statusCode: Int) -> Bool {
        return HttpStatus(statusCode) == .serverError
    }

    static public func isUnknown(statusCode: Int) -> Bool {
        return HttpStatus(statusCode) == .unknown
    }
}
