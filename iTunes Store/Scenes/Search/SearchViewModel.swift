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
        case fetchStateChanged(isFetching: Bool)
        case error(String)
    }
    
    mutating func setFetching(fetching: Bool) -> Change {
        self.fetching = fetching
        return .fetchStateChanged(isFetching: fetching)
    }
    
    mutating func setItems(_ items: [SearchModel]) -> Change {
        self.items = items
        return .items
    }
    
}

class SearchViewModel {
    private(set) var state = SearchViewState()
    var onChange: ((SearchViewState.Change) -> Void)?

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
        guard
            let currentItem = itemAtIndex(index),
            let visitedItems = UserPreferences.getVisitedItems(),
            visitedItems.contains(currentItem.trackId)
            else { return false }
        return true
    }
    
    func removeItemFromListIfNeeded() {
        guard let removedItems = UserPreferences.getRemovedItems() else { return }
        state.items = state.items.filter { !removedItems.contains($0.trackId) }
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
