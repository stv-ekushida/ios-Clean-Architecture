//
//  PhotoListCell.swift
//  PinterestDemo
//
//  Created by Eiji Kushida on 2016/12/02.
//  Copyright © 2016年 Eiji Kushida. All rights reserved.
//

import UIKit

final class PhotoListCell: UICollectionViewCell {

    @IBOutlet weak var thumnailImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!

    static var identifier: String {
        get {
            return String(describing: self)
        }
    }

    var photo: Photo? {

        didSet {

            if let photo = photo {
                thumnailImageView.image = photo.image
                captionLabel.text = photo.caption
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func prepareForReuse() {
        thumnailImageView.image = nil
    }
}
