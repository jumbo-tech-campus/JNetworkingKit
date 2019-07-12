import Foundation

public extension RequestParserType where Result == Void {
    func parse(response: Response) throws {
        NetworkingLogger.log("Beginning to parse response", "\n\tResponse: \(response)", loggedComponent: .parser)
    }
}

open class VoidRequestParser: RequestParserType {
    public typealias Result = Void
    public init() {}
}
