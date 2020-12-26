//
//  ViewController.swift
//  RetailEcoS
//
//  Developed By:
//  © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit

class ViewController: UIViewController {
    
    ///mark: property
    
    
    ///mark: outlet
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var viewAbout: UIView!
    @IBOutlet weak var viewRetail: UIView!
    @IBOutlet weak var btnPermission: UIButton!
    @IBOutlet weak var btnTermsCondition: UIButton!
    
    
    
    
    ///mark: Action
    @IBAction func btnPermission(_ sender: Any) {

    }

    @IBAction func btnTermsCondition(_ sender: Any) {

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    
    ///mark: function
    func initialConfig() {
        
        viewDescription.shadowEffects(shadow: .DarkShadow, getView: viewDescription)
        viewDescription.shadowEffects(shadow: .WithBorder, getView: viewDescription)
        viewAbout.shadowEffects(shadow: .DarkShadow, getView: viewAbout)
        viewRetail.shadowEffects(shadow: .DarkShadow, getView: viewRetail)
        btnPermission.shadowEffects(shadow: .LightShadow, getView: btnPermission)
        btnTermsCondition.shadowEffects(shadow: .LightShadow, getView: btnTermsCondition)
    }
    
}

