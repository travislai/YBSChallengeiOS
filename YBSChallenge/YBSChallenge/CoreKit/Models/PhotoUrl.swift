//
//  PhotoUrl.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct PhotoUrl: Decodable, Hashable {
    public let type: String
    public let content: String
    
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case content = "_content"
    }
    
    init(type: String, content: String) {
        self.type = type
        self.content = content
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        self.content = try container.decode(String.self, forKey: .content)
    }
}
