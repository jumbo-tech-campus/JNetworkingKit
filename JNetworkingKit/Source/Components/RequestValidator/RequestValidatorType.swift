public enum RequestValidatorError: Error {
    case informational(response: Response)
    case redirection(response: Response)
    case clientError(response: Response)
    case serverError(response: Response)
    case invalidData(response: Response)

    public var response: Response {
        switch self {
        case .informational(let response),
             .redirection(let response),
             .clientError(let response),
             .serverError(let response),
             .invalidData(let response):
        return response
        }
    }
}

public protocol RequestValidatorType {
    func validate(response: Response) throws
}

extension RequestValidatorType {
    public func validate(response: Response) throws {
        // swiftlint:disable:next line_length
        Logger.log("Beginning to validate response", "\n\tResponse: \(response) Status Code: \(response.statusCode)", loggedComponent: .validator)
        switch response.statusCode {
        case 100...199:
            throw RequestValidatorError.informational(response: response)
        case 300...399:
            throw RequestValidatorError.redirection(response: response)
        case 400...499:
            throw RequestValidatorError.clientError(response: response)
        case 500...599:
            throw RequestValidatorError.serverError(response: response)
        default:
            break
        }
    }
}
