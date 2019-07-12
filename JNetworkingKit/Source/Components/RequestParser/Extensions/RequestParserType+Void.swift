import Foundation

public extension RequestParserType where Result == Void {
    func parse(response: Response) throws {}
}

open class VoidRequestParser: RequestParserType {
    public typealias Result = Void
    public init() {}
}
