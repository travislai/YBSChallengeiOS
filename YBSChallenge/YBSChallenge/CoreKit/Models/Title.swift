//
//  Title.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct Title: Decodable, Hashable {
    public let content: String
    
    
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
    
    init(content: String) {
        self.content = content
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.content = try container.decode(String.self, forKey: .content)
    }
}
