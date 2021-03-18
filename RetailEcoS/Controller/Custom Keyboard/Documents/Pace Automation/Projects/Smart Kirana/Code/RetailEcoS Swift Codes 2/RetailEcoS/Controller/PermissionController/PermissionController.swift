//
//  PermissionController.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-01-19.
//

import UIKit

class PermissionController: UIViewController {
    
    ///mark: property
    
    var permissionList = ["Using Internal GPS","Accessing Camera","Accessing your Contacts","Accessing your Album","Autofill Data","Store Card Data"]
    let minRowHeight: CGFloat = 50.0
    var headerFooterHeight = CGFloat()
    
    ///mark: outlet
    
    @IBOutlet weak var permissionControllerTv: UITableView!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var footerHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var lblFooter: UILabel!
    @IBOutlet weak var lblPermission: UILabel!
    ///mark: action
    
    @IBAction func btnGoNext(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showHomeScreen", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    func initialConfig() {
        lblHeader.font = UIFont(name:"OpenSans",size:17)
        lblFooter.font = UIFont(name:"OpenSans",size:17)
        permissionControllerTv.register(UINib(nibName: "customHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: customHeaderView.reuseIdentifier)
        
        permissionControllerTv?.register(PermissionControllerCell.nib, forCellReuseIdentifier: PermissionControllerCell.identifier)
        
        
        permissionControllerTv.delegate = self
        permissionControllerTv.dataSource = self
        
        
    }
    
}


extension PermissionController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return permissionList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PermissionControllerCell.identifier, for: indexPath) as? PermissionControllerCell {
            cell.lblCell.text = permissionList[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = tableView.frame.height
        let temp = tHeight / CGFloat(6)
        headerFooterHeight = temp
        headerHeightContraint.constant = temp
        footerHeightContraint.constant = temp
        self.view.layoutIfNeeded()
        return temp > minRowHeight ? temp : minRowHeight
    }
    
}
