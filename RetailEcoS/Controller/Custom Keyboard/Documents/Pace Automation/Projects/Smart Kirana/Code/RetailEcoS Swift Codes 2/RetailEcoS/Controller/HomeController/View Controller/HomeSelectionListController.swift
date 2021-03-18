//
//  SelectRetailVerticalVC.swift
//  RetailEcoS
//  SelectRetailVerticalVC
//  Description - This application handles all the retail verticals as listed.By selecting a retail vertical appropriate modules will be activated.
//  Developed By:
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit

class HomeSelectionListController: UIViewController {
    
    ///mark: property
    var homeSelectionList = ["Postal Code","Shop From Home","Grocery","Home Delivery","Delivery Address","My Shop","Delivery Time"]
    var homeSelectionImg = [UIImage(named: "imgPostalCode"),UIImage(named: "imgShpFrmHome"),UIImage(named: "imgGrocery"),UIImage(named: "imgHomeDelivery"),UIImage(named: "imgDeliveryAddress"),UIImage(named: "imgMyShop"),UIImage(named: "imgDeliveryTime")]
    
    let minRowHeight: CGFloat = 50.0
    
    ///mark: outlet
    @IBOutlet weak var selectRetailTV: UITableView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnCountries: UIButton!
    
    
    
    
    @IBAction func btnLogin(_ sender: UIButton) {
    }
    
    @IBAction func btnHome(_ sender: UIButton) {
    }
    
    @IBAction func btnCountries(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    
    ///mark: function
    
    func initialConfig() {
        
        selectRetailTV?.register(HomeSelectionCell.nib, forCellReuseIdentifier: HomeSelectionCell.identifier)
        
        
        selectRetailTV.delegate = self
        selectRetailTV.dataSource = self
    }
    
}


///mark: extension

extension HomeSelectionListController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeSelectionList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeSelectionCell.identifier, for: indexPath) as? HomeSelectionCell {
            cell.lblRetail.text = homeSelectionList[indexPath.row]
            cell.imgCell.image = homeSelectionImg[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let tHeight = tableView.frame.height
        let temp = tHeight / CGFloat(7)
        return temp > minRowHeight ? temp : minRowHeight
    }
    
    
}
