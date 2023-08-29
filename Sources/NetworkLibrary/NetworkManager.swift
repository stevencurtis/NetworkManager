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
        return self.description
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

public class NetworkManager<T: URLSessionProtocol> {
    public let session: T
    var task: URLSessionDataTask?

    public required init(session: T) {
        self.session = session
    }
    
    public convenience init() {
        self.init(session: URLSession.shared as! T)
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    public func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = method.method
        request.allHTTPHeaderFields = method.getHeaders()
        
        if let bearerToken = method.getToken() {
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }

        if let data = method.getData() {
            let stringParams = data.paramsString()
            let bodyData = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: false)
            request.httpBody = bodyData
        }
        
        task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionBlock(.failure(error!))
                return
            }
            guard
                let _ = data,
                let httpResponse = response as? HTTPURLResponse,
                200 ..< 300 ~= httpResponse.statusCode else {
                    if let data = data {
                        completionBlock(.success(data))
                    } else {
                        completionBlock(.failure(NetworkManagerError.invalidResponse(data, response)))
                    }
                    return
            }

            if let data = data {
                completionBlock(.success(data))
            }
        }
        task?.resume()
    }
}
