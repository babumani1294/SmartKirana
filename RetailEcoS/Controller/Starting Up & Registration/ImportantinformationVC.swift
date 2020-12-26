//
//  ImportantinformationVC.swift
//  RetailEcoS
//  ImportantinformationVC
//  Description - Informing the customer the neecessity to understand and except the terms and conditions of service
//  Developed By:
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved


import UIKit

class ImportantinformationVC: UIViewController {

    ///mark; property
    
    
    
    ///mark: outlet
    @IBOutlet weak var viewLogo: UIView!
    @IBOutlet weak var viewImpInfo: UIView!
    
    
    
    ///mark: action
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func goNext(_ sender: UIButton) {
//        performSegue(withIdentifier: "showImpInfo", sender: self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    

   ///mark: functions
    func initialConfig() {
        viewLogo.shadowEffects(shadow: .DarkShadow, getView: viewLogo)
        viewImpInfo.shadowEffects(shadow: .DarkShadow, getView: viewImpInfo)
    }
    

}
