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
    
    @IBOutlet weak var label: UILabel!
    
    static func instantiate(model: DetailViewModel) -> Self {
        let viewController = loadFromStoryboard()
        viewController.viewModel = model
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        label.text = viewModel.detailModel.trackCensoredName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Preferences.setVisitedItem(with: viewModel.detailModel.trackId)
    }
    
}
