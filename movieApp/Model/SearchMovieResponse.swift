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
    var poster_path: String?
    var title: String
}
