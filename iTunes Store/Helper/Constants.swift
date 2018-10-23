//
//  Constants.swift
//
//  Created by Yuşa Doğru on 5/10/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

enum C {
    enum sceneTitle {
        static let search = "Search"
        static let detail = "Detail"
    }
    enum string {
        static let alertMessageForItemRemoved = "This content will not be shown again."
        static let remove = "Remove"
        static let cancel = "Cancel"
    }
    enum storyboard {
        static let main = "Main"
    }
}
