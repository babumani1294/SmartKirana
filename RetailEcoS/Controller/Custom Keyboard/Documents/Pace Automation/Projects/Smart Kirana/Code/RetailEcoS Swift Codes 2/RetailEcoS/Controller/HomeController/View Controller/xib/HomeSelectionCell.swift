//
//  SelectRetailCell.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2020-12-25.
//

import UIKit

class HomeSelectionCell: UITableViewCell {

    ///mark: propety
    
    
    ///mark: outlet
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblRetail: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblRetail.font = UIFont(name:"OpenSans",size:17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
