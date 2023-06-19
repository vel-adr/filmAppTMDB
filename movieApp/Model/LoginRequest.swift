//
//  LoginRequest.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 20/03/23.
//

import Foundation

struct LoginRequest: Encodable {
    var username: String
    var password: String
    var requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case username, password
        case requestToken = "request_token"
    }
}
