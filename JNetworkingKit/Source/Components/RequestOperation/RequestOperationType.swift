import Foundation

protocol RequestOperationType {
    associatedtype Result where Result == Parser.Result
    associatedtype Executor: RequestExecutorType
    associatedtype Parser: RequestParserType

    var executor: Executor { get set }
    var parser: Parser { get set }
    var request: Request { get set }

    func execute(onSuccess: @escaping (Result) -> Void, onError: @escaping (Error) -> Void)
}

extension RequestOperationType {
    func execute(onSuccess: @escaping (Result) -> Void, onError: @escaping (Error) -> Void) {
        executor.perform(request: request,
            onSuccess: { response in
                do {
                    let result = try self.parser.parse(response: response)
                    onSuccess(result)
                } catch let error {
                    onError(error)
                }
            },
            onError: { error in
                onError(error)
            }
        )
    }
}
