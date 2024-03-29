//
//  Instantiatable.swift
//  Premier
//  Link: github.com/iltercengiz/Premier/blob/master/Premier/Protocols/ViewLoaders/Instantiatable.swift
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import UIKit

protocol Instantiatable {
    static func instantiate() -> Self
}

extension Instantiatable where Self: NibLoadable {
    static func instantiate() -> Self {
        return loadFromNib()
    }
}

extension Instantiatable where Self: StoryboardLoadable {
    static func instantiate() -> Self {
        return loadFromStoryboard()
    }
}
