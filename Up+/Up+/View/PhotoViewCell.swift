//
//  PhotoViewCell.swift
//  Up+
//
//  Created by Dream on 8/23/17.
//  Copyright © 2017 Dreamup. All rights reserved.
//

import UIKit

class PhotoViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.contentView.addSubview(imageView)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
}
