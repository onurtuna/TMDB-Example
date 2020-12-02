//
//  ManagerTests.swift
//  ING-IMDBTests
//
//  Created by Onur Tuna on 2.12.2020.
//

import XCTest
@testable import ING_IMDB

class ManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_FavManager_Fav() {
        let movie = Movie()
        movie.id = 1111
        FavManager.fav(movie: movie, completion: {
            XCTAssertTrue(FavManager.isFav(movie: movie), "The movie should be fav.")
        })
    }
    
    func test_FavManager_UnFav() {
        let movie = Movie()
        movie.id = 1111
        FavManager.fav(movie: movie, completion: {
            FavManager.unFav(movie: movie, completion: {
                XCTAssertFalse(FavManager.isFav(movie: movie), "The movie should not be fav.")
            })
        })
    }
    
    func test_KeyManager_TMDBKey() {
        XCTAssertNotNil(KeyManager.getTmdbApiKey(), "Please make sure you have provided an api key.")
    }

}
