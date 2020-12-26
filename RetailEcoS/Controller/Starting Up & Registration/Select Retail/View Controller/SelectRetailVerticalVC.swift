//
//  SelectRetailVerticalVC.swift
//  RetailEcoS
//  SelectRetailVerticalVC
//  Description - This application handles all the retail verticals as listed.By selecting a retail vertical appropriate modules will be activated.
//  Developed By:
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit

class SelectRetailVerticalVC: UIViewController {
    
    ///mark: property
    var retailList = ["Apparel & Fashion - AR Enabled","Beauty & Personal Care - AR Enabled","Electrical","Electronics","Eyewear - AR enabled","Footwear","Grocery","Home Appliance - 3d Enabled","Jewellery - AR Enabled","Luggage","Pharmaceuticals","Stationary & Office Supplies"]
    
    
    ///mark: outlet
    @IBOutlet weak var viewSelectVertical: UIView!
    @IBOutlet weak var viewRetailEcos: UIView!
    @IBOutlet weak var viewInfo: UIView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var selectRetailTV: UITableView!
    
    
    ///mark: action
    @IBAction func goNext(_ sender: Any) {
        
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    
    ///mark: function
    
    func initialConfig() {
        
        selectRetailTV?.register(SelectRetailCell.nib, forCellReuseIdentifier: SelectRetailCell.identifier)
        
        viewSelectVertical.shadowEffects(shadow: .DarkShadow, getView: viewSelectVertical)
        viewRetailEcos.shadowEffects(shadow: .DarkShadow, getView: viewRetailEcos)
        viewInfo.shadowEffects(shadow: .WithBorder, getView: viewInfo)
        
        selectRetailTV.delegate = self
        selectRetailTV.dataSource = self
    }
    
}


///mark: extension

extension SelectRetailVerticalVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelectRetailCell.identifier, for: indexPath) as? SelectRetailCell {
            cell.lblRetail.text = retailList[indexPath.row]
            cell.viewCell.shadowEffects(shadow: .LightShadow, getView: cell.viewCell)
            cell.btnRetailCheck.shadowEffects(shadow: .WithBorder, getView: cell.btnRetailCheck)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    ///mark: delegates
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
