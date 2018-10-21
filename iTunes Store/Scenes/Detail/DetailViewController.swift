//
//  DetailViewController.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/21/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController, StoryboardLoadable, Instantiatable {
    
    static var defaultStoryboardName = C.StoryboardName.main
    
    var viewModel: DetailViewModel!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    
    static func instantiate(model: DetailViewModel) -> Self {
        let viewController = loadFromStoryboard()
        viewController.viewModel = model
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackNavButton()
        addRightNavButton(image: #imageLiteral(resourceName: "cancelIcon"))
        setupUI()
        selfConfig()
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func handleRightButton() {
        
    }
    
    //MARK: Self
    func selfConfig() {
        self.navigationItem.title = C.STRING.TITLE.detail
    }
    
    func setupUI()  {
        labelTitle.text = viewModel.detailModel.trackCensoredName
        imageViewItem.downloaded(from: viewModel.detailModel.artworkUrl100)
        imageViewBackground.downloaded(from: viewModel.detailModel.artworkUrl100)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Preferences.setVisitedItem(with: viewModel.detailModel.trackId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBarColor(color: .clear)
    }
    
}
