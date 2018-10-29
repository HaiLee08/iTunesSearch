//
//  Preferences.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/21/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation

class UserPreferences {
    private static let visitedItemKey = "visitedItemKey"
    private static let removedItemKey = "removedItemKey"

    static func setItemAsVisited(with id: String) {
        setItem(with: id, key: visitedItemKey)
    }
    
    static func getVisitedItems() -> [String]? {
        return getItems(key: visitedItemKey)
    }
    
    static func setRemovedItem(with id: String) {
        setItem(with: id, key: removedItemKey)
    }
    
    static func getRemovedItems() -> [String]? {
        return getItems(key: removedItemKey)
    }
    
    // Private
    private static func setItem(with id: String, key: String) {
        var visitedModels = getVisitedItemIfExist(key: key)
        visitedModels.append(id)
        UserDefaults.standard.set(visitedModels, forKey: key)
    }
    
    private static func getItems(key: String) -> [String]? {
        if let visitedModels = UserDefaults.standard.array(forKey: key) {
            return visitedModels as? [String]
        }
        return nil
    }
    
    private static func getVisitedItemIfExist(key: String) -> [String] {
        if let visitedModels = getItems(key: key) {
            return visitedModels
        } else {
            return []
        }
    }
}


