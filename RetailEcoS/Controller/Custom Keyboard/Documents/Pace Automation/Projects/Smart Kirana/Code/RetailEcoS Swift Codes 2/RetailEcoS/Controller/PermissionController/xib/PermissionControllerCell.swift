//
//  PermissionControllerCell.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-01-19.
//

import UIKit

class PermissionControllerCell: UITableViewCell {

    ///mark:outlet
    
    @IBOutlet weak var lblCell: UILabel!
    @IBOutlet weak var swtchCell: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCell.font = UIFont(name:"OpenSans",size:17)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        swtchCell.setOn(false, animated: true)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
