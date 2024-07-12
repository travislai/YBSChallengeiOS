//
//  PhotoInfo.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct PhotoInfo: Decodable, Hashable, Identifiable {
    public let id: String
    public let secret: String
    public let server: String
    public let farm: Int
    public let dateUploaded: String
    public let isFavorite: Int
    public let originalSecret: String
    public let owner: Owner
    public let title: Title
    public let dates: PhotoDate
    public let views: String
    public let tags: Tags
    public let urls:  PhotoUrls
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case dateUploaded = "dateuploaded"
        case isFavorite = "isfavorite"
        case originalSecret = "originalsecret"
        case owner = "owner"
        case title = "title"
        case dates = "dates"
        case views = "views"
        case tags = "tags"
        case urls = "urls"
    }
    
    public init(id: String, secret: String, server: String, farm: Int, dateUploaded: String, isFavorite: Int, originalSecret: String, owner: Owner, title: Title, dates: PhotoDate, views: String, tags: Tags, urls: PhotoUrls) {
        self.id = id
        self.secret = secret
        self.server = server
        self.farm = farm
        self.dateUploaded = dateUploaded
        self.isFavorite = isFavorite
        self.originalSecret = originalSecret
        self.owner = owner
        self.title = title
        self.dates = dates
        self.views = views
        self.tags = tags
        self.urls = urls
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decode(String.self, forKey: .id)
        self.secret = try container.decode(String.self, forKey: .secret)
        self.server = try container.decode(String.self, forKey: .server)
        self.farm = try container.decode(Int.self, forKey: .farm)
        self.dateUploaded = try container.decode(String.self, forKey: .dateUploaded)
        self.isFavorite = try container.decode(Int.self, forKey: .isFavorite)
        self.originalSecret = try container.decode(String.self, forKey: .originalSecret)
        self.owner = try container.decode(Owner.self, forKey: .owner)
        self.title = try container.decode(Title.self, forKey: .title)
        self.dates = try container.decode(PhotoDate.self, forKey: .dates)
        self.views = try container.decode(String.self, forKey: .views)
        self.tags = try container.decode(Tags.self, forKey: .tags)
        self.urls = try container.decode(PhotoUrls.self, forKey: .urls)
    }
}
