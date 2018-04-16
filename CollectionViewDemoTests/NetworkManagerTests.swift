//
//  NetworkManagerTests.swift
//  CollectionViewDemoTests
//
//  Created by Prashanthi Boravelly on 16/4/18.
//  Copyright © 2018 Prashanthi Boravelly. All rights reserved.
//

import XCTest
@testable import CollectionViewDemo

class NetworkManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInValidURL() {
        let urlString = "mcokurl"
        var customError: CustomError?
        let expect = XCTestExpectation(description: "callback")
        NetworkManager.responseData(urlString: urlString) { result in
            expect.fulfill()
            if case .failure(let error) = result {
                customError = error
            }
        }
        wait(for: [expect], timeout: 1.0)
        XCTAssertNotNil(customError)
    }
    
    func testFetchingFacts() {
        let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        var customError: CustomError?
        var responseData: Data?
        let expect = XCTestExpectation(description: "callback")
        NetworkManager.responseData(urlString: urlString) { result in
            expect.fulfill()
            switch result {
            case .success(let data):
                responseData = data
            case .failure(let error):
                customError = error
            }
        }
        wait(for: [expect], timeout: 3.0)
        XCTAssertNotNil(responseData)
        XCTAssertNil(customError)
    }
    
    func testFetchingAndDecodingFacts() {
        let urlString = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        var customError: CustomError?
        var responseFact: Fact?
        let expect = XCTestExpectation(description: "callback")
        NetworkManager.responseObject(urlString: urlString) { (result: Result<Fact, CustomError>) in
            expect.fulfill()
            switch result {
            case .success(let fact):
                responseFact = fact
            case .failure(let error):
                customError = error
            }
        }
        wait(for: [expect], timeout: 3.0)
        XCTAssertNotNil(responseFact)
        XCTAssertNil(customError)
    }
    
    
}
