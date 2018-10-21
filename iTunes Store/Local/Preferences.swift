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
    private static let removedItemKey = "removedItemKey"

    static func setVisitedItem(with id: UInt) {
        setItem(with: id, key: visitedItemKey)
    }
    
    static func getVisitedItems() -> [UInt]? {
        return getItems(key: visitedItemKey)
    }
    
    static func setRemovedItem(with id: UInt) {
        setItem(with: id, key: removedItemKey)
    }
    
    static func getRemovedItems() -> [UInt]? {
        return getItems(key: removedItemKey)
    }
    
    private static func setItem(with id: UInt, key: String) {
        var visitedModels = getVisitedItemIfExist(key: key)
        visitedModels.append(id)
        UserDefaults.standard.set(visitedModels, forKey: key)
    }
    
    private static func getItems(key: String) -> [UInt]? {
        if let visitedModels = UserDefaults.standard.array(forKey: key) {
            return visitedModels as? [UInt]
        }
        return nil
    }
    
    private static func getVisitedItemIfExist(key: String) -> [UInt] {
        if let visitedModels = getItems(key: key) {
            return visitedModels
        } else {
            return [UInt]()
        }
    }
}


