//
//  File.swift
//  
//
//  Created by Steven Curtis on 09/11/2020.
//

import XCTest
@testable import NetworkLibrary

final class DictionaryExtensionTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExtension() {
        let data : [String : Any]? = ["email": "eve.holt@reqres.in", "password": "cityslicka"]
        let stringParams = data!.paramsString()
        let straightData =
        "email=eve.holt@reqres.in&password=cityslicka".data(using: .utf8)!
        let dataParams = stringParams.data(using: String.Encoding.utf8, allowLossyConversion: false)
        XCTAssertEqual(dataParams!.count, straightData.count)
    }
    
}
