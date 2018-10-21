//
//  SearchModel.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/14/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

struct SearchGroup: Decodable {
    let resultCount: Int
    let results: [SearchModel]
}


struct SearchModel: Decodable {
    let trackId: UInt
    let artistName: String
    let artworkUrl100: String
    let trackCensoredName: String
   
    enum CodingKeys: String, CodingKey {
        case trackId
        case artistName
        case artworkUrl100
        case trackCensoredName
    }
    
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName) ?? ""
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100) ?? ""
        trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName) ?? ""
        trackId = try values.decodeIfPresent(UInt.self, forKey: .trackId) ?? 0
    }
}
