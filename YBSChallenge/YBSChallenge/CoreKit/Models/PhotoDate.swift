//
//  Date.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct PhotoDate: Decodable, Hashable {
    public let posted: String
    
    
    enum CodingKeys: String, CodingKey {
        case posted = "posted"
    }
    
    init(posted: String) {
        self.posted = posted
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.posted = try container.decode(String.self, forKey: .posted)
    }
}
