public enum RequestValidatorError: Error {
    case informationalResponse(Response)
    case redirection(Response)
    case clientError(Response)
    case serverError(Response)

    public var response: Response {
        switch self {
        case .informationalResponse(let response),
             .redirection(let response),
             .clientError(let response),
             .serverError(let response):
        return response
        }
    }
}

public protocol RequestValidatorType {
    func validate(response: Response) throws
}

extension RequestValidatorType {
    public func validate(response: Response) throws {
        switch response.statusCode {
        case 100...199:
            throw RequestValidatorError.informationalResponse(response)
        case 300...399:
            throw RequestValidatorError.redirection(response)
        case 400...499:
            throw RequestValidatorError.clientError(response)
        case 500...599:
            throw RequestValidatorError.serverError(response)
        default:
            break
        }
    }
}
