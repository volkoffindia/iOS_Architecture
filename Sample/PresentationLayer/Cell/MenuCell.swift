//
//  DashBoardVC.swift
//  Sample
//
//  Created by Volkoff India on 15/06/21.
//

import UIKit

class MenuCell: UITableViewCell {
    
    // MARK:- Varible declaration
    @IBOutlet  var dishImg: UIImageView!
    
    @IBOutlet  var title: UILabel!
    @IBOutlet  var priceLbl: UILabel!
    @IBOutlet  var detailsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    class func cellIdentifier() -> String {
        return "MenuCell"
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
    }
    
    var item: ProductData! {
        didSet {
            
            if let product_cost = item.cost {
                self.priceLbl.text = "$ \(product_cost)"
            }
            
            self.title.text = item.name
            self.detailsLbl.text = item.description
            self.dishImg.load(url: URL.init(string: self.item.product_images ?? "")!, placeholder: UIImage.init(named: "placeholder"))
        }
    }
}
