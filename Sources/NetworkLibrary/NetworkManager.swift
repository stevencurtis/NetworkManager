//  Created by Steven Curtis

import Foundation

public enum HTTPMethod {
    case get(headers: [String : String] = [:], token: String? = nil)
    case post(headers: [String : String] = [:], token: String? = nil, body: [String: Any])
    case put(headers: [String : String] = [:], token: String? = nil)
    case delete(headers: [String : String] = [:], token: String? = nil)
    case patch(headers: [String : String] = [:], token: String? = nil)
}

extension HTTPMethod: CustomStringConvertible {
    
    func getHeaders() -> [String: String]? {
        switch self {
        case .get(headers: let headers, _):
            return headers
        case .post(headers: let headers, _, body: _):
            return headers
        case .put(headers: let headers, _):
            return headers
        case .delete(headers: let headers, _):
            return headers
        case .patch(headers: let headers, _):
            return headers
        }
    }
    
    func getToken() -> String? {
        switch self {
        case .get(_, token: let token):
            return token
        case .post(_, token: let token, body: _):
            return token
        case .put(_, token: let token):
            return token
        case .delete(_, token: let token):
            return token
        case .patch(_, token: let token):
            return token
        }
    }
    
    func getData() -> [String: Any]? {
        switch self {
        case .get:
            return nil
        case .post( _, _, body: let body):
            return body
        case .put:
            return nil
        case .delete:
            return nil
        case .patch:
            return nil
        }
    }
    
    public var method: String {
        self.description
    }
    
    public var description: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .put:
                return "PUT"
            case .delete:
                return "DELETE"
            case .patch:
                return "PATCH"
        }
    }
}

public final class NetworkManager<T: URLSessionProtocol>: NetworkManagerProtocol {
    public let session: T
    private var task: URLSessionDataTask?
    private var dataTask: Task<Data, Error>?
    
    public required init(session: T) {
        self.session = session
    }
    
    public convenience init() throws {
        guard let session = URLSession.shared as? T else {
            throw NetworkManagerError.sessionTypeMismatch
        }
        self.init(session: session)
    }
    
    public func cancel() {
        task?.cancel()
        dataTask?.cancel()
    }
    
    public func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        let request = makeRequest(url: url, method: method)
        
        task = session.dataTask(with: request) { data, httpResponse, error in
            guard error == nil else {
                if let error = error {
                    completionBlock(.failure(error))
                } else {
                    completionBlock(.failure(NetworkManagerError.httpError(.unknown)))
                }
                return
            }
            
            guard let httpResponse = httpResponse as? HTTPURLResponse else {
                completionBlock(.failure(NetworkManagerError.invalidResponse(data, httpResponse)))
                return
            }
            
            switch self.handleStatusCode(statusCode: httpResponse.statusCode) {
            case .success:
                if let data = data {
                    completionBlock(.success(data))
                } else {
                    completionBlock(.failure(NetworkManagerError.dataNotReceived))
                }
            case .failure(let error):
                completionBlock(.failure(error))
            }
        }
        task?.resume()
    }
    
    public func fetch(url: URL, method: HTTPMethod) async throws -> Data {
        dataTask = Task {
            let request = makeRequest(url: url, method: method)
            let (data, _) = try await session.data(for: request)
            return data
        }
        guard let taskData = try await dataTask?.value else {
            throw NetworkManagerError.dataNotReceived
        }
        return taskData
    }
    
    private func handleStatusCode(statusCode: Int) -> Result<Void, NetworkManagerError> {
        switch statusCode {
        case 200 ..< 300:
            return .success(())
        case 400:
            return .failure(NetworkManagerError.httpError(.badRequest))
        case 401:
            return .failure(NetworkManagerError.httpError(.unauthorized))
        case 403:
            return .failure(NetworkManagerError.httpError(.forbidden))
        case 404:
            return .failure(NetworkManagerError.httpError(.notFound))
        case 500:
            return .failure(NetworkManagerError.httpError(.serverError))
        default:
            return .failure(NetworkManagerError.httpError(.unknown))
        }
    }
    
    private func makeRequest(url: URL, method: HTTPMethod) -> URLRequest {
        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 30.0
        )
        request.httpMethod = method.method
        request.allHTTPHeaderFields = method.getHeaders()
        
        if let bearerToken = method.getToken() {
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let data = method.getData() {
            let stringParams = data.paramsString()
            let bodyData = stringParams.data(using: .utf8, allowLossyConversion: false)
            request.httpBody = bodyData
        }
        return request
    }
}
