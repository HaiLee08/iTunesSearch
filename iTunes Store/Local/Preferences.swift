//
//  Preferences.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/21/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation

//class VisitedItemModel: Codable {
//    var trackId: UInt = 0
//
//    init(trackId: UInt) {
//        self.trackId = trackId
//    }
//}


class Preferences {
    private static let visitedItemKey = "visitedItemKey"
    
    static func setVisitedItem(with id: UInt) {
        var visitedModels = getVisitedItemIfExist()
        visitedModels.append(id)
        UserDefaults.standard.set(visitedModels, forKey: visitedItemKey)
    }
    
    private static func getVisitedItemIfExist() -> [UInt] {
        if let visitedModels = getVisitedItems() {
            return visitedModels
        } else {
            return [UInt]()
        }
    }
    
    static func getVisitedItems() -> [UInt]? {
        if let visitedModels = UserDefaults.standard.array(forKey: visitedItemKey) {
            return visitedModels as? [UInt]
        }
        return nil
    }
}


