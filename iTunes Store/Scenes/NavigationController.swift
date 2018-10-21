//
//  NavigationController.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/15/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
}
