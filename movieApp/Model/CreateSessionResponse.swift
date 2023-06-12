//
//  CreateSessionResponse.swift
//  movieApp
//
//  Created by Anselmus Pavel Adriska on 20/03/23.
//

import Foundation

struct CreateSessionResponse: Codable {
    var success: Bool
    var sessionId: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
