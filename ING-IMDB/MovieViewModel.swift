//
//  MovieViewModel.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 30.11.2020.
//

import Foundation

fileprivate struct MovieResult: Codable {
    
    var totalResults: Int?
    var page: Int?
    var totalPages: Int?
    var results: Array<Movie>?
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page = "page"
        case totalPages = "total_pages"
        case results = "results"
    }
    
}

class MovieViewModel {
    
    var movies: Array<Movie>?
    var currentPage = 1
    
    var moviesFetched: (() -> Void)?
    var errorOccured: ((String) -> Void)?
    
    func fetchMovies(of page:Int? = 1) {
        guard let apiKey = KeyManager.getTmdbApiKey() else {
            errorOccured?("There is a problem with your API key file. Refer the README file for more information.")
            return
        }
        if apiKey.isEmpty {
            errorOccured?("Please make sure that you have provided an API key. Refer the README file for more information.")
            return
        }
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=\(apiKey)&page=\(page ?? 1)")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            if error != nil {
                self.errorOccured?(error?.localizedDescription.description ?? "An error occured")
                return
            }
            guard let data = data else {
                self.errorOccured?("An error occured")
                return
            }
            do {
                if let movies = try JSONDecoder().decode(MovieResult.self, from: data).results {
                    if self.movies?.append(contentsOf: movies) == nil {
                        self.movies = movies
                    }
                    self.currentPage += 1
                }
                self.moviesFetched?()
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
}
