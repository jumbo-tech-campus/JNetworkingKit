import Foundation

extension URLSession: RequestClientType {

    public func perform(request: Request,
                        onSuccess: @escaping (Response) -> Void,
                        onError: @escaping (RequestClientError) -> Void) {
        Logger.log("Beginning to perform request", "\n\tRequest: \(request)", loggedComponent: .client)
        guard let request = request.asUrlRequest() else {
            onError(RequestClientError.invalidRequest)
            return
        }

        dataTask(with: request) { (data, response, error) in
            if let error = error {
                Logger.log("Generic client error", "\n\t\(error.localizedDescription)", loggedComponent: .client)
                return onError(RequestClientError.generic(message: error.localizedDescription))
            }

            guard let response = response as? HTTPURLResponse else {
                Logger.log("Invalid response", "\n\tRequest: \(request)", loggedComponent: .client)
                return onError(RequestClientError.invalidResponse)
            }

            guard let data = data else {
                Logger.log("Missing data", "\n\tRequest: \(request)", loggedComponent: .client)
                return onError(RequestClientError.noData)
            }
            // swiftlint:disable:next line_length
            Logger.log("Completed request successfully!", "\n\tData: \(data) Headers: \(response.allHeaderFields) statusCode: \(response.statusCode)", loggedComponent: .client)
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
        request.httpBody = self.data

        return request
    }
}
