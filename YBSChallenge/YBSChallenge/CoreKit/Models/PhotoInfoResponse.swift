//
//  PhotoInfoResponse.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct PhotoInfoResponse: Decodable, Hashable {
    public let photoInfo: PhotoInfo
    
    enum CodingKeys: String, CodingKey {
        case photoInfo = "photo"
    }
    
    public init(photoInfo: PhotoInfo) {
        self.photoInfo = photoInfo
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.photoInfo = try container.decode(PhotoInfo.self, forKey: .photoInfo)
    }
}
