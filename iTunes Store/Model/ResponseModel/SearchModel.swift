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
    let artistName: String
   
    
//    init(artistName: String, artworkUrl100: String, collectionId: Int, collectionName: String, country: String, primaryGenreName: String, releaseDate: String) {
//        self.artistName = artistName
//        self.artworkUrl100 = artworkUrl100
//        self.collectionId = collectionId
//        self.collectionName = collectionName
//        self.country = country
//        self.primaryGenreName = primaryGenreName
//        self.releaseDate = releaseDate
//    }
}
