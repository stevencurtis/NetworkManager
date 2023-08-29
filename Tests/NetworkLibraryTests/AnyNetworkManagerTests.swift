//  Created by Steven Curtis

import XCTest
@testable import NetworkLibrary

final class AnyNetworkManagerTests: XCTestCase {
    var urlSession: MockURLSession?
    var networkManager: AnyNetworkManager<MockURLSession>?
    
    func testGetMethodNoBody() {
        urlSession = MockURLSession()
        let testString = "Test String"
        let data = Data(testString.utf8)
        urlSession?.data = data
        
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, testString)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testPostMethodNoBody() {
        urlSession = MockURLSession()
        let testString = "Test String"
        let data = Data(testString.utf8)
        urlSession?.data = data
        
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .post(body: [:]), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, testString)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testPostMethodBody() {
        urlSession = MockURLSession()
        let testString = "Test String"
        let data = Data(testString.utf8)
        urlSession?.data = data
        
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .post(body: ["email": "eve.holt@reqres.in", "password": "cityslicka"]), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, testString)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testSuccessfulGetURLResponse() {
        urlSession = MockURLSession()
        let testString = "Test String"
        let data = Data(testString.utf8)
        urlSession?.data = data
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .get(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, testString)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testSuccessfulPatchURLResponse() {
        urlSession = MockURLSession()
        let testString = "Test String"
        let data = Data(testString.utf8)
        urlSession?.data = data
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .patch(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, testString)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testSuccessfulPutURLResponse() {
        urlSession = MockURLSession()
        let testString = "Test String"
        let data = Data(testString.utf8)
        urlSession?.data = data
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .put(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, testString)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testSuccessfulDeleteURLResponse() {
        urlSession = MockURLSession()
        let testString = "Test Data"
        let data = Data(testString.utf8)
        urlSession?.data = data
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .delete(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, testString)
            case .failure:
                XCTFail()
            }
        })
    }
    
    func testFailureGetURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
            }
        })
    }
    
    func testFailurePatchURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .patch(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
            }
        })
    }
    
    func testFailurePutURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .put(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
            }
        })
    }
    
    func testFailureDeleteURLResponse() {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .delete(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
            }
        })
    }
    
    func testBadlyFormattedgetURLResponse() {
        urlSession = MockURLSession()
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get(), completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
    
    func testBadlyFormattedputURLResponse() {
        urlSession = MockURLSession()
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .put(), completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
    
    func testBadlyFormattedDeleteURLResponse() {
        urlSession = MockURLSession()
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .delete(), completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
    
    func testAnyNetworkConv() {
        var networkManager: AnyNetworkManager<URLSession>?
        networkManager = try? AnyNetworkManager()
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .delete(), completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
    }
    
    func testCancellation() throws {
        var networkManager: AnyNetworkManager<MockURLSession>?

        urlSession = MockURLSession()
        let mgr = NetworkManager(session: try XCTUnwrap(urlSession))
        networkManager = try? AnyNetworkManager(manager: mgr)

        networkManager?.fetch(
            url: URL(string: "https://example.com")!,
            method: .get(headers: [:], token: ""),
            completionBlock: { _ in }
        )
        
        networkManager?.cancel()

        let mockTask = try XCTUnwrap(urlSession?.task as? MockURLSessionDataTask)
        XCTAssertTrue(mockTask.cancelTaskCalled)
    }
    
    func testAsyncFetch() async throws {
        urlSession = MockURLSession()
        let testString = "Test Data"
        let sessionData = Data(testString.utf8)
        urlSession?.data = sessionData
        
        networkManager = try? AnyNetworkManager(manager: NetworkManager(session: XCTUnwrap(urlSession)))
        let url = URL(fileURLWithPath: "http://www.google.com")
        let data = try await networkManager!.fetch(url: url, method: .get())
        let decodedString = String(decoding: data, as: UTF8.self)
        XCTAssertEqual(decodedString, testString)
    }
}
