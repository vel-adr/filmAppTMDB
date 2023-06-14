//
//  TMDBResponse.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 13/06/23.
//

import Foundation

struct TMDBResponse: Codable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
