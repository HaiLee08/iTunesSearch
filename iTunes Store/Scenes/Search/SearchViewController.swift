//
//  SearchViewController.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/14/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    private enum Const {
        static let interitemSpacing = 16
        static let lineSpacing = 20
        static let numberOfItemsPerRow = 1.0
    }
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var searchText: String = ""
    private var viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfConfig()
        bindViewModel()
        viewModel.getItems(text: "instagram")
    }

    //MARK: Self
    func selfConfig() {
        self.navigationItem.title = C.STRING.TITLE.search
    }
    
    func bindViewModel() {
        viewModel.onChange = viewModelStateChange
    }
    
    func viewModelStateChange(change: SearchViewState.Change) {
        switch change {
        case .error:
            break
        case .items:
            collectionView.reloadData()
            break
        case .fetchStateChanged(let fetching):
            activityIndicator.isHidden = !fetching
            break
        }
    }
    
}

//MARK: CollectionView
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCell.className,
                                                      for: indexPath) as! SearchCell
        cell.item = viewModel.itemAtIndex(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.size.width - CGFloat(Const.interitemSpacing) * CGFloat(Const.numberOfItemsPerRow - 1.0)) / CGFloat(Const.numberOfItemsPerRow) - 1.0
        return CGSize(width: cellWidth, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Const.lineSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Const.interitemSpacing)
    }
}
