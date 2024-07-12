//
//  Tags.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct Tags: Decodable, Hashable {
    public let tag: [Tag]
    
    
    enum CodingKeys: String, CodingKey {
        case tag = "tag"
    }
    
    init(tag: [Tag]) {
        self.tag = tag
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tag = try container.decode([Tag].self, forKey: .tag)
    }
}
