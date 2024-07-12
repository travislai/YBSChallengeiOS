//
//  PhotosResponse.swift
//  YBSChallenge
//
//  Created by Travis Lai on 10/7/2024.
//

import Foundation

public struct PhotosResponse: Decodable, Hashable {
    public let photos: Photos
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
    
    public init(photos: Photos,
                stack: String) {
        self.photos = photos
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.photos = try container.decode(Photos.self, forKey: .photos)
    }
}
