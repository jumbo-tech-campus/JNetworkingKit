public protocol ResponseMiddlewareType {
    func process(request: Request, response: Response)
}
