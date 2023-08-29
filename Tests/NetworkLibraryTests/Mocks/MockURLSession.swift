//  Created by Steven Curtis

import Foundation
@testable import NetworkLibrary

final class MockURLSession: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    
    var task: URLSessionDataTask?
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
        )
        let task = MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
        self.task = task
        return task
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let task = MockURLSessionDataTask {
            completionHandler(data, nil, error)
        }
        self.task = task
        return task
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let response = URLResponse()
        return (data ?? Data(), response)
    }
}
