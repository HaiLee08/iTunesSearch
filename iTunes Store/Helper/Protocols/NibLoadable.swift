//
//  NibLoadable.swift
//  Premier
//  Link: github.com/iltercengiz/Premier/blob/master/Premier/Protocols/ViewLoaders/Instantiatable.swift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static var defaultNibName: String { get }
    static func loadFromNib() -> Self
}

extension NibLoadable where Self: UIView {
    
    static var defaultNibName: String {
        return String(describing: self)
    }
    
    static var defaultNib: UINib {
        return UINib(nibName: defaultNibName, bundle: nil)
    }
    
    static func loadFromNib() -> Self {
        guard let nib = Bundle.main.loadNibNamed(defaultNibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("Cannot load view from nib.")
        }
        return nib
    }
    
}
