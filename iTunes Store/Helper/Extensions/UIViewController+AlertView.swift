//
//  UIViewController+AlertView.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/21/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlertWithTitle(title: String = "", message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
}
