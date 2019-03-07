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
    public var operationError: ((Error) -> Error) { return { $0 } }

    public func execute(onSuccess: ((Result) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        executor.perform(request: request,
            onSuccess: { response in
                do {
                    try self.validator.validate(response: response)
                    let result = try self.parser.parse(response: response)
                    DispatchQueue.main.async {
                        onSuccess?(result)
                    }

                } catch let error {
                    DispatchQueue.main.async {
                        onError?(self.operationError(error))
                    }
                }
            },
            onError: { error in
                DispatchQueue.main.async {
                    onError?(self.operationError(error))
                }
            }
        )
    }
}
