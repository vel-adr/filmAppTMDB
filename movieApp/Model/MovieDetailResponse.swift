//
//  APIResponseModel.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 01/02/23.
//

import Foundation

struct MovieDetailResponse: Codable {
    var genres: [Genre]
    var id: Int
    var overview: String?
    var posterPath: String?
    var releaseDate: String
    var runtime: Int?
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case genres, id, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime, title
    }
}

struct Genre: Codable {
    var id: Int
    var name: String
}


