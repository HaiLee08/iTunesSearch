//
//  SearchCell.swift
//  itunessearch
//
//  Created by Yuşa Doğru on 10/14/18.
//  Copyright © 2018 Yuşa Doğru. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var imageViewCoverImage: UIImageView?
    @IBOutlet weak var labelTitle: UILabel?
    
    var item: SearchModel? {
        didSet {
            if let item = item {
//                imageViewCoverImage?.setImage(urlString: cuisine.simpleImage)
                labelTitle?.text = item.artistName
            }
        }
    }
    
}
