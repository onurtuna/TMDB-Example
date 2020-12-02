//
//  ApiCallTests.swift
//  ING-IMDBTests
//
//  Created by Onur Tuna on 2.12.2020.
//

import XCTest
@testable import ING_IMDB

class ApiCallTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_MovieApi() {
        let promise = expectation(description: "Api call should return 200")
        guard let apiKey = KeyManager.getTmdbApiKey() else {
            XCTFail("Api key is nil.")
            return
        }
        if apiKey.isEmpty {
            XCTFail("Api key is empty.")
            return
        }
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=\(apiKey)&page=1")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            if error != nil {
                XCTFail("Api returned error.")
                return
            }
            guard let _ = data else {
                XCTFail("Data is corrupt.")
                return
            }
            promise.fulfill()
        })
        task.resume()
        wait(for: [promise], timeout: 5)
    }

}
