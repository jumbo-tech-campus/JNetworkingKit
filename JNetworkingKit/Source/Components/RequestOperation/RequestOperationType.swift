import Foundation

public protocol RequestOperationType {
    associatedtype Result where Result == Parser.Result
    associatedtype Executor: RequestExecutorType
    associatedtype Parser: RequestParserType

    var executor: Executor { get set }
    var parser: Parser { get set }
    var request: Request { get set }

    func execute(onSuccess: ((Result) -> Void)?, onError: ((Error) -> Void)?)
}

extension RequestOperationType {
    public func execute(onSuccess: ((Result) -> Void)? = nil, onError: ((Error) -> Void)? = nil) {
        executor.perform(request: request,
            onSuccess: { response in
                do {
                    let result = try self.parser.parse(response: response)
                    DispatchQueue.main.async {
                        onSuccess?(result)
                    }

                } catch let error {
                    DispatchQueue.main.async {
                        onError?(error)
                    }
                }
            },
            onError: { error in
                onError?(error)
            }
        )
    }
}
