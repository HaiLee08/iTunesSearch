//
//  Assets.swift
//
//  Created by Yuşa Doğru on 6/22/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation
import UIKit

enum Icon {
    case all_ingredient
    case arrow
    case logo
    case flag
    
    var image: UIImage {
        switch self {
        case .all_ingredient: return UIImage(named: "ic_all_ingredients")!
        case .arrow: return UIImage(named: "arrow.png")!
        case .logo: return UIImage(named: "logo.png")!
        case .flag: return UIImage(named: "flag.png")!
        }
    }
    
    enum Tab {
        static let home = UIImage(named: "tabIconHome")!
        static let search = UIImage(named: "tabIconSearch")!
        static let bookmark = UIImage(named: "tabIconHome")!
        static let shop = UIImage(named: "tabIconHome")!
        static let menu = UIImage(named: "tabIconMenu")!
    }
}



struct ITunesColor {

    struct Dark {
        static let dark = UIColor(hexString: "101319")
        static let mid = UIColor(hexString: "171A21")
        static let light = UIColor(white: 230.0/255.0, alpha: 1)
    }

}
