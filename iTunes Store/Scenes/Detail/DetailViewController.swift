//
//  DetailViewController.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/21/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName = C.storyboard.main
  
    // MARK: Properties
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var labelArtistName: UILabel!
    @IBOutlet weak var labelCountry: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    var viewModel: DetailViewModel!
    
    // MARK: Instantiate
    static func instantiate(with model: DetailViewModel) -> Self {
        let viewController = loadFromStoryboard()
        viewController.viewModel = model
        return viewController
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackNavButton()
        addRightNavButton(image: #imageLiteral(resourceName: "cancelIcon"))
        setupUI()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UserPreferences.setItemAsVisited(with: viewModel.detailModel.trackId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyNavigationBarColor(color: .clear)
    }
    
    // MARK: Actions
    override func rightBarButtonTapped() {
        presentAlertWithTitle(message: C.string.alertMessageForItemRemoved,
                              options: C.string.remove, C.string.cancel ) { [weak self] (action) in
            guard let self = self else { return }
            switch(action) { 
            case 0:
                UserPreferences.setRemovedItem(with: self.viewModel.detailModel.trackId)
                break
            case 1: break
            default:
                break
            }
        }
    }
    
    // MARK: Self
    func setupUI()  {
        self.navigationItem.title = C.sceneTitle.detail
        labelTitle.text = viewModel.detailModel.trackCensoredName
        labelCountry.text = viewModel.detailModel.country
        labelArtistName.text = viewModel.detailModel.artistName
        imageViewItem.downloadImage(from: viewModel.detailModel.artworkUrl100)
        imageViewBackground.downloadImage(from: viewModel.detailModel.artworkUrl100)
        if !viewModel.detailModel.longDescript.isEmpty {
            labelDescription.text = viewModel.detailModel.longDescript
        } else {
            labelDescription.text = viewModel.detailModel.descript
        }
        
    }
    
    
    
}



