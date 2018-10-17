//
//  SearchBar+TextField.swift
//  iTunes Store
//
//  Created by Yuşa Doğru on 10/17/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

public extension UISearchBar {
    
    public var textField: UITextField? {
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }

}
