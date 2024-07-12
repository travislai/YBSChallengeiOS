//
//  PhotoUrls.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct PhotoUrls: Decodable, Hashable {
    public let url: [PhotoUrl]
    
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
    
    init(url: [PhotoUrl]) {
        self.url = url
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decode([PhotoUrl].self, forKey: .url)
    }
}
