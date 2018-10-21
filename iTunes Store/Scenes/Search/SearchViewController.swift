//
//  SearchViewController.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/14/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: StoryboardLoadable Protocol
    static var defaultStoryboardName = C.storyboard.main

    private enum Const {
        static let interitemSpacing: CGFloat = 16.0
        static let rowHeight: CGFloat = 120.0
        static let lineSpacing: CGFloat = 20.0
        static var numberOfItemsPerRow: CGFloat = 1.0
        
        static let minSearchTextCount = 3
        static let delayForSearching: TimeInterval = 1
    }
    
    // MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewNoResult = NoResultView.loadFromNib()
    private var searchText: String = ""
    private var viewModel = SearchViewModel()
    private var dataSource: SearchesDataSource!
    private var mediaType: MediaType = .all
    private let filterView = FilterView.loadFromNib()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addRightNavButton(image: #imageLiteral(resourceName: "ic_filter"))
        setupUI()
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
        if let color = SytleGuide.color.mid {
            applyNavigationBarColor(color: color)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewNoResult.center = collectionView.center
    }
    
    override func rightBarButtonTapped() {
        filterView.show()
        filterView.didTapOk = { [weak self] mediaType in
            guard let self = self else { return }
            self.mediaType = mediaType
            self.fetchItems()
        }
    }
    
    //MARK: Self
    func setupUI() {
        self.navigationItem.title = C.sceneTitle.search
    }
    
    func fetchItems() {
        viewModel.getItems(text: searchText, media: mediaType)
    }
    
    func bindViewModel() {
        viewModel.onChange = viewModelStateChanged
    }
    
    func viewModelStateChanged(change: SearchViewState.Change) {
        switch change {
        case .error:
            // TODO:
            break
        case .items:
            collectionView.reloadData()
            viewNoResult.isHidden = !viewModel.state.items.isEmpty
            break
        case .fetchStateChanged(let isFetching):
            activityIndicator.isHidden = !isFetching
            viewNoResult.isHidden = viewModel.state.fetching
            break
        }
    }
}

// MARK: Orientation Handling
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
        if let searchCell = (cell as? SearchCell), viewModel.isVisitedBefore(index: indexPath.row) {
            searchCell.setItemAsVisited()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchModel = viewModel.itemAtIndex(indexPath.row)
        let model = DetailViewModel(with: searchModel!)
        let detailVC = DetailViewController.instantiate(with: model)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.bounds.size.width - Const.interitemSpacing * (Const.numberOfItemsPerRow - 1.0)) / Const.numberOfItemsPerRow - 1.0
        return CGSize(width: cellWidth, height: Const.rowHeight)
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
        if let searchText = searchBar.text, searchText.count >= Const.minSearchTextCount {
            textDidChange(searchBar: searchBar)
        }
    }
    
    func textDidChange(searchBar: UISearchBar) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(didEndEditing), object: searchBar)
        self.perform(#selector(didEndEditing), with: searchBar, afterDelay: Const.delayForSearching)
    }
    
    @objc func didEndEditing(searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchText = text
        }
        fetchItems()
    }
}


extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -(1 * scrollView.contentOffset.y)
        let transform = CGAffineTransform.identity.translatedBy(x: 0, y: y)
        searchBar.transform = transform
    }
}
