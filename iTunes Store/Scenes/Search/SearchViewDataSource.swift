//
//  SearchViewDataSource.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/17/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class SearchesDataSource: NSObject {
    
    fileprivate let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

extension SearchesDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.className,
                                                      for: indexPath) as! SearchCell
        cell.item = viewModel.itemAtIndex(indexPath.row)
        return cell
    }
    
}
