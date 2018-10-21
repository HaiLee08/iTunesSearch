//
//  BaseViewController.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/17/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //MARK: NavigationItems
    //MARK: Right button
    func addRightNavButton(image: UIImage) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleRightButton))
        navigationItem.rightBarButtonItem?.tintColor = Color.white
    }
    
    @objc func handleRightButton()  { }
    
    //MARK: Back button
    func addBackNavButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(handleBackButton))
        navigationItem.leftBarButtonItem?.tintColor = Color.white
    }
    
    @objc func handleBackButton()  {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigationBarColor(color : UIColor) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(color: color), for: .default)
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
    }
}
