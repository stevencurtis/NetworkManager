//  Created by Steven Curtis

import Foundation
@testable import NetworkLibrary

final class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    override func resume() {
        closure()
    }
    
    override func cancel() { }
}
