//
//  User.swift
//  YBSChallenge
//
//  Created by Travis Lai on 10/7/2024.
//

import Foundation

public struct User: Decodable, Hashable {
    public let username: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
    }
    
    init(username: String) {
        self.username = username
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.username = try container.decode(String.self, forKey: .username)
    }
}
