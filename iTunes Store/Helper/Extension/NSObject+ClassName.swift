//
//  ClassName.swift
//
//  Created by Yuşa Doğru on 5/4/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
