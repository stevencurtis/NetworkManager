//  Created by Steven Curtis

import Foundation

// the MockHTTPManager does not use the session within the response
public class MockNetworkManager <T: URLSessionProtocol>: NetworkManagerProtocol {
    public func cancel() { }
    
    public var outputData = "".data(using: .utf8)
    public var willSucceed = true
    public var didFetch = false
    public let session: T

    public required init(session: T) {
      self.session = session
    }
    
    public func fetch(url: URL, method: HTTPMethod, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        didFetch = true
        if let dta = outputData {
            if willSucceed {
                completionBlock(.success(dta))
            } else {
                completionBlock(.failure(ErrorModel(errorDescription: "Error from Mock HTTPManager")))
            }
        }
    }
}
