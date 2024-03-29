//  Created by Steven Curtis

import Foundation

public final class AnyNetworkManager<U: URLSessionProtocol>: NetworkManagerProtocol {
    public let session: U
    private let fetchClosure: (URL, HTTPMethod, @escaping (Result<Data, Error>) -> Void) -> ()
    private let cancelClosure: () -> ()
    private let fetchAsyncClosure: (URL, HTTPMethod) async throws -> Data
    
    public func cancel() {
        cancelClosure()
    }
    
    public init<T: NetworkManagerProtocol>(manager: T) throws {
        fetchClosure = manager.fetch
        fetchAsyncClosure = manager.fetch(url:method:)
        if let sessionAsU = manager.session as? U {
            session = sessionAsU
        } else {
            throw NetworkManagerError.sessionTypeMismatch
        }
        cancelClosure = manager.cancel
    }
    
    public convenience init() throws {
        let manager = NetworkManager<URLSession>(session: URLSession.shared)
        try self.init(manager: manager)
    }
    
    public func fetch(
        url: URL,
        method: HTTPMethod,
        completionBlock: @escaping (Result<Data, Error>) -> Void
    ) {
        fetchClosure(url, method, completionBlock)
    }
    
    public func fetch(url: URL, method: HTTPMethod) async throws -> Data {
        try await fetchAsyncClosure(url, method)
    }
}
