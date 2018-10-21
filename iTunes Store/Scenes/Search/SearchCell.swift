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
                labelTitle?.text = item.trackCensoredName
                imageViewCoverImage?.downloadImage(from: item.artworkUrl100)
            }
        }
    }
    
    func setItemAsVisited() {
        labelTitle?.textColor = UIColor(white: 0.4, alpha: 1)
    }
    
    override func prepareForReuse() {
        imageViewCoverImage?.image = #imageLiteral(resourceName: "placeholderImage")
        labelTitle?.textColor = .white
    }
    
}


