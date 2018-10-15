import Foundation

extension URLSession: RequestClientType {

    public func perform(request: Request,
                 onSuccess: @escaping (Response) -> Void,
                 onError: @escaping (RequestClientError) -> Void) {
        guard let request = request.asUrlRequest() else {
            onError(RequestClientError.invalidRequest)
            return
        }

        dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                onError(RequestClientError.generic(message: error?.localizedDescription ?? "Generic error."))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                return onError(RequestClientError.invalidResponse)
            }

            guard let data = data else {
                return onError(RequestClientError.noData)
            }

            onSuccess(Response(data: data, headers: response.allHeaderFields, statusCode: response.statusCode))
        }.resume()
    }
}

private extension Request {
    func asUrlRequest() -> URLRequest? {
        guard let url = url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.headers

        return request
    }
}
