//  Created by Steven Curtis

import Foundation

public protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
