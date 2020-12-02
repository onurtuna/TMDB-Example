//
//  Movie.swift
//  ING-IMDB
//
//  Created by Onur Tuna on 30.11.2020.
//

import Foundation

class Movie: Codable {
    
    var isVideo: Bool?
    var voteAverage: Double?
    var popularity: Double?
    var voteCount: Int?
    var releaseDate: String?
    var isAdult: Bool?
    var imageUri: String?
    var overview: String?
    var genreIds: Array<Int>?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var posterUri: String?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case isVideo = "video"
        case voteAverage = "vote_average"
        case popularity
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case isAdult = "adult"
        case imageUri = "backdrop_path"
        case overview
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterUri = "poster_path"
        case title
    }
    
}
