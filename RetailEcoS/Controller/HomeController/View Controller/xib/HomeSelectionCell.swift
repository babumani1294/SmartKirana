//
//  SelectRetailCell.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2020-12-25.
//

import UIKit
class HomeSelectionCell: UITableViewCell {
    
    ///mark: propety
    var cellBtnPressed: cellButtonPress!
    var celSwtchPressed: homeCellSwitchAction!
    
    
  
    
    var counter = (0,0,0,0,0,0,0)
    
    
    var btWithTagZeroStatus = 0
    
    ///mark: outlet
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblRetail: UILabel!
    @IBOutlet weak var imgCell: UIImageView!
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var btnNxt: UIButton!
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    
    
    ///mark: action
    
    @IBAction func btnNext(_ sender: UIButton) {
        
        celSwtchPressed.homeCellSwitchAction(cell: self, cellImage: UIImage(named: "imgHomeDelivery")!, cellTitle: "how", cellEnableDisable: true)
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnNxt.bringSubview(toFront: self.cellImg)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
