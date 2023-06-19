//
//  MovieResponse.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 02/02/23.
//

import Foundation

struct MovieResponse: Codable {
    var results: [Result]
}

struct Result: Codable {
    var posterPath: String?
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
    }
}
