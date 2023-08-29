//  Created by Steven Curtis

import XCTest
@testable import NetworkLibrary

final class NetworkManagerTests: XCTestCase {
    var urlSession: MockURLSession?
    var networkManager: NetworkManager<MockURLSession>?
    
    func testGetMethodNoBody() throws {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, "TEsts12")
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testSuccessfulGetURLResponse() throws {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .get(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, "TEsts12")
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testSuccessfulPatchURLResponse() throws {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .patch(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, "TEsts12")
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testSuccessfulPutURLResponse() throws {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .put(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, "TEsts12")
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testSuccessfulDeleteURLResponse() throws {
        urlSession = MockURLSession()
        let data = Data("TEsts12".utf8)
        urlSession?.data = data
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        
        networkManager?.fetch(url: url, method: .delete(), completionBlock: { result in
            XCTAssertNotNil(result)
            switch result {
            case .success(let data):
                let decodedString = String(decoding: data, as: UTF8.self)
                XCTAssertEqual(decodedString, "TEsts12")
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testFailureGetURLResponse() throws {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
                expect.fulfill()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testFailurePatchURLResponse() throws {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .patch(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
                expect.fulfill()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testFailurePutURLResponse() throws {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .put(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
                expect.fulfill()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testFailureDeleteURLResponse() throws {
        // One way of testing failure is for the URLSession to simply provide no data to return
        urlSession = MockURLSession()
        urlSession?.error = NSError(domain: "error", code: 101, userInfo: nil)
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expect = expectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .delete(), completionBlock: {result in
            XCTAssertNotNil(result)
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 101)
                expect.fulfill()
            }
        })
        waitForExpectations(timeout: 3.0)
    }
    
    func testBadlyFormattedgetURLResponse() throws {
        urlSession = MockURLSession()
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .get(), completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testBadlyFormattedputURLResponse() throws {
        urlSession = MockURLSession()
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
        networkManager?.fetch(url: url, method: .put(), completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testBadlyFormattedDeleteURLResponse() throws {
        urlSession = MockURLSession()
        networkManager = NetworkManager(session: try XCTUnwrap(urlSession))
        let expectation = XCTestExpectation(description: #function)
        let url = URL(fileURLWithPath: "http://www.google.com")
                
        networkManager?.fetch(url: url, method: .delete(), completionBlock: { result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        })
        wait(for: [expectation], timeout: 3.0)
    }
    
}
