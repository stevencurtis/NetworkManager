//  Created by Steven Curtis

import Foundation

public protocol NetworkManagerProtocol {
    associatedtype aType
    var session: aType { get }
    func cancel()
    func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void)
    func fetch(url: URL, method: HTTPMethod) async throws -> Data
}

public extension NetworkManagerProtocol {
    func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        fetch(url: url, method: method, completionBlock: completionBlock)
    }
}
