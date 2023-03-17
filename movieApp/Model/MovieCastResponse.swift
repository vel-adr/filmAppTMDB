//
//  MovieCastResponse.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 02/02/23.
//

import Foundation

struct MovieCastResponse: Codable {
    var id: Int
    var cast: [CastResponse]
}

struct CastResponse: Codable {
    var name: String
    var profilePath: String?
    var character: String
    
    enum CodingKeys: String, CodingKey {
        case name, character
        case profilePath = "profile_path"
    }
}
