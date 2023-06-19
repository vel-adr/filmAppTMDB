//
//  RequestTokenResponse.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 17/03/23.
//

import Foundation

struct RequestTokenResponse: Codable {
    var isSuccess: Bool
    var expiresAt: String
    var requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case isSuccess = "success"
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
