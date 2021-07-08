//
//  HomeCollectionViewCell.swift
//  payzah_business
//
//  Created by webwerks on 10/06/19.
//  Author by Arvind Valaki
//  Copyright © 2019 payzah. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet  var bannerImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellIdentifier() -> String {
        return "BannerCell"
    }
    
    var imageUrl: String! {
        didSet {
            self.bannerImg.load(url: URL.init(string: imageUrl)!, placeholder: UIImage.init(named: "placeholder"))
        }
    }
}
