//
//  PermissionVC.swift
//  RetailEcoS
//  PermissionVC
//  Description - To get system permission for internal function
//  Developed By:
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved


import UIKit
//gitChecks
class PermissionVC: UIViewController {

    ///mark: property
    
    
    
    
    ///mark: outlet
    @IBOutlet weak var viewInfo1: UIView!
    @IBOutlet weak var viewInfo2: UIView!
    @IBOutlet weak var viewRetailEcos: UIView!
    @IBOutlet weak var viewPermission: UIView!
    
    
    
    ///mark: action
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goNext(_ sender: UIButton) {
        performSegue(withIdentifier: "showImpInfo", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    
    ///mark: function
    
    func initialConfig() {
        viewPermission.shadowEffects(shadow: .DarkShadow, getView: viewPermission, cornerRadius: 12)
        viewRetailEcos.shadowEffects(shadow: .DarkShadow, getView: viewRetailEcos, cornerRadius: 12)
        viewInfo1.shadowEffects(shadow: .DarkShadow, getView: viewInfo1, cornerRadius: 12)
        viewInfo2.shadowEffects(shadow: .DarkShadow, getView: viewInfo2, cornerRadius: 12)
        viewInfo1.shadowEffects(shadow: .WithBorder, getView: viewInfo1, cornerRadius: 12)
        viewInfo2.shadowEffects(shadow: .WithBorder, getView: viewInfo2, cornerRadius: 12)
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        print(deviceID)
    }
 

}
