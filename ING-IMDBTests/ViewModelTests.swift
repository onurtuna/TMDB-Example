//
//  ViewModelTests.swift
//  ING-IMDBTests
//
//  Created by Onur Tuna on 2.12.2020.
//

import XCTest
@testable import ING_IMDB

class ViewModelTests: XCTestCase {

    var movieViewModelSut: MovieViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        movieViewModelSut = MovieViewModel()
    }

    override func tearDownWithError() throws {
        movieViewModelSut = nil
        super.tearDown()
    }
    
    func test_currentPage_Increment() {
        let promise = expectation(description: "The current page should be 2")
        movieViewModelSut.moviesFetched = {
            XCTAssertEqual(self.movieViewModelSut.currentPage, 2)
            promise.fulfill()
        }
        movieViewModelSut.fetchMovies()
        wait(for: [promise], timeout: 5)
    }
    
    func test_MovieFetch_Performance() {
        measure {
            movieViewModelSut.fetchMovies()
        }
    }

}
