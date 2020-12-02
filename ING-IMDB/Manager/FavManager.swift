//
//  FavManager.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 1.12.2020.
//

import Foundation

class FavManager {
    
    class func fav(movie: Movie?, completion: () -> Void) {
        guard let movie = movie,
              let movieId = movie.id else {
            completion()
            return
        }
        var favMovies = UserDefaults.standard.value(forKey: "fav-movies") as? Array<Int>
        if favMovies?.append(movieId) == nil {
            favMovies = [movieId]
        }
        UserDefaults.standard.setValue(favMovies, forKey: "fav-movies")
        completion()
    }
    
    class func unFav(movie: Movie?, completion: () -> Void) {
        guard let movie = movie,
              let movieId = movie.id else {
            completion()
            return
        }
        var favMovies = UserDefaults.standard.value(forKey: "fav-movies") as? Array<Int>
        favMovies?.removeAll(where: { $0 == movieId })
        UserDefaults.standard.setValue(favMovies, forKey: "fav-movies")
        completion()
    }
    
    class func isFav(movie: Movie?) -> Bool {
        guard let movie = movie,
              let movieId = movie.id,
              let favMovies = UserDefaults.standard.value(forKey: "fav-movies") as? Array<Int> else {
            return false
        }
        return favMovies.contains(movieId)
    }
    
}
