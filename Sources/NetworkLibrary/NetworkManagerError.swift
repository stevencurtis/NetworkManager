//  Created by Steven Curtis

import Foundation

enum NetworkManagerError: Error {
    case sessionTypeMismatch
    case dataNotReceived
    case bodyInGet
    case invalidURL
    case noInternet
    case invalidResponse(Data?, URLResponse?)
    case accessForbidden
    case httpError(HTTPError)
}

enum HTTPError: Error {
    case badRequest // 400
    case unauthorized // 401
    case forbidden // 403
    case notFound // 404
    case serverError // 500
    case unknown // for other status codes

    var description: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .serverError:
            return "Internal Server Error"
        case .unknown:
            return "Unknown HTTP Error"
        }
    }
}
