//
//  AddFavorite.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 13/06/23.
//

import Foundation

struct AddFavorite: Codable {
    let mediaType: String
    let mediaId: Int
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case favorite = "favorite"
    }
}
