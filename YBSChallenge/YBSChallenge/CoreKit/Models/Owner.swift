//
//  Owner.swift
//  YBSChallenge
//
//  Created by Travis Lai on 11/7/2024.
//

import Foundation

public struct Owner: Decodable, Hashable {
    public let nsId: String
    public let username: String
    public let realName: String
    public let iconServer: String
    public let iconFarm: Int
    public let pathAlias: String
    
    
    enum CodingKeys: String, CodingKey {
        case nsId = "nsid"
        case username = "username"
        case realName = "realname"
        case iconServer = "iconserver"
        case iconFarm = "iconfarm"
        case pathAlias = "path_alias"
    }
    
    init(nsId: String, username: String, realName: String, iconServer: String, iconFarm: Int, pathAlias: String) {
        self.nsId = nsId
        self.username = username
        self.realName = realName
        self.iconServer = iconServer
        self.iconFarm = iconFarm
        self.pathAlias = pathAlias
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nsId = try container.decode(String.self, forKey: .nsId)
        self.username = try container.decode(String.self, forKey: .username)
        self.realName = try container.decode(String.self, forKey: .realName)
        self.iconServer = try container.decode(String.self, forKey: .iconServer)
        self.iconFarm = try container.decode(Int.self, forKey: .iconFarm)
        self.pathAlias = try container.decode(String.self, forKey: .pathAlias)
    }
}
