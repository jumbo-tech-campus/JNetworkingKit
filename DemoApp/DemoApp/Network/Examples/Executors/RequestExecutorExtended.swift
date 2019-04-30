import JNetworkingKit

public class RequestExecutorExtended: RequestExecutor {
    override
    public var client: RequestClientType {
        return RequestClientExtended()
    }
}
