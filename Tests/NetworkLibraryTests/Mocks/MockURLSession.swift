//  Created by Steven Curtis

import Foundation
@testable import NetworkLibrary

final class MockURLSession: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    
    func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = HTTPURLResponse(
            url: URL(fileURLWithPath: ""),
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        
        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
    }
}
