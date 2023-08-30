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
        return makeTask(data: data, response: response, error: error, completionHandler: completionHandler)
    }
    
    func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        return makeTask(data: data, error: error, completionHandler: completionHandler)
    }
    
    private func makeTask(
        data: Data?,
        response: HTTPURLResponse? = nil,
        error: Error?,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let task = MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
        self.task = task
        return task
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let response = HTTPURLResponse(
            url: URL(fileURLWithPath: ""),
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
        return (data ?? Data(), response)
    }
}
