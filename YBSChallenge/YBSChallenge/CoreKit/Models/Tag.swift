//
//  Tag.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct Tag: Decodable, Hashable {
    public let id: String
    public let author: String
    public let authorName: String
    public let raw: String
    public let content: String
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case authorName = "authorname"
        case raw = "raw"
        case content = "_content"
    }
    
    init(id: String, author: String, authorName: String, raw: String, content: String) {
        self.id = id
        self.author = author
        self.authorName = authorName
        self.raw = raw
        self.content = content
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.authorName = try container.decode(String.self, forKey: .authorName)
        self.raw = try container.decode(String.self, forKey: .raw)
        self.content = try container.decode(String.self, forKey: .content)
    }
}
