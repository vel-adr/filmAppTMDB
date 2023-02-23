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
    var poster_path: String?
    var id: Int
}
