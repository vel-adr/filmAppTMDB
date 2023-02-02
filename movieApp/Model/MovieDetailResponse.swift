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
    var poster_path: String?
    var release_date: String
    var runtime: Int?
    var title: String
}

struct Genre: Codable {
    var id: Int
    var name: String
}


