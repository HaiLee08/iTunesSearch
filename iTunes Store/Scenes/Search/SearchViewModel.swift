//
//  SearchViewModel.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/14/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

struct SearchViewState {
    fileprivate(set) var fetching = false
    fileprivate(set) var items: [SearchModel] = []
}

extension SearchViewState {
    enum Change {
        case items
        case fetchStateChanged(fetching: Bool)
        case error(String)
    }
    
    mutating func setFetching(fetching: Bool) -> Change {
        self.fetching = fetching
        return .fetchStateChanged(fetching: fetching)
    }
    
    mutating func setItems(_ items: [SearchModel]) -> Change {
        self.items = items
        return .items
    }
    
}

class SearchViewModel {
    fileprivate(set) var state = SearchViewState()
    var onChange: ((SearchViewState.Change) -> Void)?
    
    //MARK: DataSource
    var numberOfItems: Int {
        return state.items.count
    }
    
    func itemAtIndex(_ index: Int) -> SearchModel? {
        if state.items.count > index {
            return state.items[index]
        }
        return nil
    }
    
    func isVisitedBefore(index: Int) -> Bool{
        if let currentItem = itemAtIndex(index), let visitedItems = Preferences.getVisitedItems() {
            if visitedItems.contains(currentItem.trackId) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func removeItemFromListIfNeeded() {
        guard let removedItems = Preferences.getRemovedItems() else { return }
        state.items = state.items.filter { !removedItems.contains($0.trackId) }
//        print(willBeRemovedItems)
        self.onChange?(.items)
        
    }
}


//MARK: Service
extension SearchViewModel {
    
    func getItems(text: String = "", media: MediaType = .all) {
        onChange?(state.setFetching(fetching: true))
        NetworkManager.shared.search(text: text, media: media,completion: { (result) in
            self.onChange?(self.state.setFetching(fetching: false))
            self.onChange?(self.state.setItems(result.results))
            self.removeItemFromListIfNeeded()
        }) { (error) in
            self.onChange?(.error(error))
            self.onChange?(self.state.setFetching(fetching: false))
        }
    }
}
