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

    public var toString: String {
        switch self {
        case .informationalResponse:
            return "Informational Response"
        case .success:
            return "Success"
        case .redirection:
            return "Redirection"
        case .clientError:
            return "Client Error"
        case .serverError:
            return "Server Error"
        case .unknown:
            return "Unknown"
        }
    }

    public var isInformationalResponse: Bool {
        return self == .informationalResponse
    }

    public var isSuccessful: Bool {
        return self == .success
    }

    public var isRedirection: Bool {
        return self == .redirection
    }

    public var isClientError: Bool {
        return self == .clientError
    }

    public var isServerError: Bool {
        return self == .serverError
    }

    public var isUnknown: Bool {
        return self == .unknown
    }
}

extension HttpStatus: CustomStringConvertible {
    public var description: String {
        return "<\(type(of: self)):\nhttpStatus = \(self.toString)>"
    }
}
