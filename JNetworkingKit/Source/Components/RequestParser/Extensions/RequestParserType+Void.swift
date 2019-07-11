import Foundation

public extension RequestParserType where Result == Void {
    func parse(response: Response) throws {
        Logger.log("Beginning to parse response", "\n\tResponse: \(response)", loggedComponent: .parser)
    }
}

open class VoidRequestParser: RequestParserType {
    public typealias Result = Void
    public init() {}
}
