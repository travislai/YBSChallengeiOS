//
//  Photos.swift
//  YBSChallenge
//
//  Created by Travis Lai on 9/7/2024.
//

import Foundation

public struct Photos: Decodable, Hashable {
    public let page: Int
    public let pages: Int
    public let perPage: Int
    public let total: Int
    public let photoArray: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case pages = "pages"
        case perPage = "perpage"
        case total = "total"
        case photoArray = "photo"
    }
    
    public init(page: Int,
                pages: Int,
                perPage: Int,
                total: Int,
                photoArray: [Photo]) {
        self.page = page
        self.pages = pages
        self.perPage = perPage
        self.total = total
        self.photoArray = photoArray
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.page = try Int(container.decode(Int.self, forKey: .page))
        self.pages = try Int(container.decode(Int.self, forKey: .pages))
        self.perPage = try Int(container.decode(Int.self, forKey: .perPage))
        self.total = try Int(container.decode(Int.self, forKey: .total))
        self.photoArray = try container.decodeIfPresent([Photo].self, forKey: .photoArray) ?? []
    }
}


//public protocol Serializable: Codable {
//    var asPhotos: Photos { get throws }
//}
//
//public extension Serializable {
//    var asPhotos: Photos? {
//        get throws {
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
//            encoder.dataEncodingStrategy = .deferredToData
//            let data = try encoder.encode(self)
//            guard let serialized = try JSONSerialization.jsonObject(with: data, options: []) as? Photos else {
//                return nil
//            }
//            return serialized
//        }
//    }
//}
