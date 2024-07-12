//
//  Photo.swift
//  YBSChallenge
//
//  Created by Travis Lai on 9/7/2024.
//

import Foundation

public struct Photo: Codable, Hashable {
    public let id: String
    public let owner: String
    public var username: String? = nil
    public let secret: String
    public let server: String
    public let title: String
    public let isPublic: Int
    public let isFriend: Int
    public let isFamily: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case title = "title"
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
    }
    
    public init(id: String,
                owner: String,
                secret: String,
                server: String,
                title: String,
                isPublic: Int,
                isFriend: Int,
                isFamily: Int) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.server = server
        self.title = title
        self.isPublic = isPublic
        self.isFriend = isFriend
        self.isFamily = isFamily
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.owner = try container.decode(String.self, forKey: .owner)
        self.secret = try container.decode(String.self, forKey: .secret)
        self.server = try container.decode(String.self, forKey: .server)
        self.title = try container.decode(String.self, forKey: .title)
        self.isPublic = try container.decode(Int.self, forKey: .isPublic)
        self.isFriend = try container.decode(Int.self, forKey: .isFriend)
        self.isFamily = try container.decode(Int.self, forKey: .isFamily)
    }
}
