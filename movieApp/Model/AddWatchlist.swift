//
//  AddWatchlist.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 14/06/23.
//

import Foundation

struct AddWatchlist: Codable {
    let mediaType: String
    let mediaId: Int
    let isWatchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case isWatchlist = "watchlist"
    }
}
