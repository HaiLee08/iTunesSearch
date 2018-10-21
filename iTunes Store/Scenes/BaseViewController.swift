//
//  BaseViewController.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/17/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: NavigationItems
    //MARK: Right button
    func addRightNavButton(image: UIImage) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = Color.white
    }
    
    @objc func rightBarButtonTapped()  { }
    
    //MARK: Back button
    func addBackNavButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backBarButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = Color.white
    }
    
    @objc func backBarButtonTapped()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func applyNavigationBarColor(color : UIColor) {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.setBackgroundImage(UIImage(color: color), for: .default)
        navigationController.view.backgroundColor = .clear
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backgroundColor = .clear
    }
}
