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
}
