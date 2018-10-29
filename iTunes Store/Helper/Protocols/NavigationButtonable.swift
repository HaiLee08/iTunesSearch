//
//  NavigationButtonable.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/29/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

@objc protocol NavigationButtonable: class {
    func addRightNavButton()
}

extension NavigationButtonable where Self: UIViewController {
    
    func addRightNavButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: nil,
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = Color.white
    }
    
    func rightBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
