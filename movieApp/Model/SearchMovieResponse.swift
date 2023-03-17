//
//  SearchMovieResponse.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 24/02/23.
//

import Foundation

struct SearchMovieResponse: Codable {
    var results: [SearchResult]
}

struct SearchResult: Codable {
    var id: Int
    var posterPath: String?
    var title: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id, title
    }
}
