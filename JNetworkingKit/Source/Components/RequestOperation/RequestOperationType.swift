import Foundation

public protocol RequestOperationType {
    associatedtype Result where Result == Parser.Result
    associatedtype Executor: RequestExecutorType
    associatedtype Parser: RequestParserType
    associatedtype Validator: RequestValidatorType

    var executor: Executor { get set }
    var parser: Parser { get set }
    var request: Request { get set }
    var validator: Validator { get set }
    var operationError: ((Error) -> Error) { get }

    func execute(onSuccess: ((Result) -> Void)?, onError: ((Error) -> Void)?)
}

public extension RequestOperationType {
    var operationError: ((Error) -> Error) { return { $0 } }

    func execute(onSuccess: ((Result) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        NetworkingLogger.log("Beginning to perform request",
                            "Request: \(request)",
                            loggedComponent: .operation)
        executor.perform(request: request,
            onSuccess: { response in
                do {
                    try self.validator.validate(response: response)
                    let result = try self.parser.parse(response: response)
                    DispatchQueue.main.async {
                        NetworkingLogger.log("Completed request successfully!",
                                             "Result: \(result)",
                                             loggedComponent: .client)
                        onSuccess?(result)
                    }

                } catch let error {
                    DispatchQueue.main.async {
                        NetworkingLogger.log("Failed to validate or parse response",
                                             "Error: \(error)" +
                                             "\n\tResponse: \(response)",
                                             loggedComponent: .client)
                        onError?(self.operationError(error))
                    }
                }
            },
            onError: { error in
                DispatchQueue.main.async {
                    NetworkingLogger.log("Failed to execute request",
                                         "Error: \(error)",
                                         loggedComponent: .client)
                    onError?(self.operationError(error))
                }
            }
        )
    }
}
