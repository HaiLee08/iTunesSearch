//
//  SearchViewController.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/14/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, StoryboardLoadable {
    
    static var defaultStoryboardName = C.StoryboardName.main

    private enum Const {
        static let interitemSpacing = 16
        static let lineSpacing = 20
        static var numberOfItemsPerRow = 1.0
    }
    
    //MARK: Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewNoResult = NoResultView.loadFromNib()
    private var searchText: String = ""
    private var viewModel = SearchViewModel()
    private var dataSource: SearchesDataSource!
    private var mediaType: MediaType = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightNavButton(image: #imageLiteral(resourceName: "ic_filter"))
        selfConfig()
        bindViewModel()
        
        view.addSubview(viewNoResult)
    
        dataSource = SearchesDataSource(viewModel: viewModel)
        collectionView.dataSource = dataSource
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
        viewModel.removeItemFromListIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarColor(color: ITunesColor.Dark.mid!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewNoResult.center = collectionView.center
    }
    
    override func handleRightButton() {
        let filterView = FilterView.loadFromNib()
        filterView.show()
        filterView.didTapOk = { mediaType in
            self.mediaType = mediaType
            self.getItems()
        }
    }
    
    //MARK: Self
    func selfConfig() {
        self.navigationItem.title = C.STRING.TITLE.search
    }
    
    func getItems() {
        viewModel.getItems(text: searchText, media: mediaType)
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
            updateNoResultView()
            break
        case .fetchStateChanged(let fetching):
            activityIndicator.isHidden = !fetching
            viewNoResult.isHidden = viewModel.state.fetching
            break
        }
    }
    
    func updateNoResultView()  {
        if viewModel.state.items.count == 0{
            viewNoResult.isHidden = false
        } else {
            viewNoResult.isHidden = true
        }
    }
}

// MARK: Orientation
extension SearchViewController {
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            Const.numberOfItemsPerRow = 2
        } else {
            Const.numberOfItemsPerRow = 1
        }
    }
}

// MARK: CollectionView
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.isVisitedBefore(index: indexPath.row) {
            (cell as? SearchCell)?.visitedItem()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchModel = viewModel.itemAtIndex(indexPath.row)
        let model = DetailViewModel(with: searchModel!)
        let detailVC = DetailViewController.instantiate(model: model)
        self.navigationController?.pushViewController(detailVC, animated: true)
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


extension SearchViewController: UISearchBarDelegate, UITextFieldDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text, searchText.count > 2  {
            textDidChange(searchBar: searchBar)
        }
    }
    
    func textDidChange(searchBar: UISearchBar) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(didEndEditing), object: searchBar)
        self.perform(#selector(didEndEditing), with: searchBar, afterDelay: 1)
    }
    
    @objc func didEndEditing(searchBar: UISearchBar) {
        searchText = searchBar.text!
        getItems()
    }
}


extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -1 * scrollView.contentOffset.y
        let transform = CGAffineTransform.identity.translatedBy(x: 0, y: y)
        searchBar.transform = transform
    }
}
