//
//  LoginVC.swift
//  RetailEcoS
//  LoginVC
//  description - To validate the credentials of the user 
//  Developed By
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit

class LoginVC: UIViewController {
    
    
    ///mark: property
    
    
    ///mark: outlet
    
    @IBOutlet weak var edtMail: UITextField!
    @IBOutlet weak var edtPassword: UITextField!
    @IBOutlet weak var viewLogin: UIView!
    @IBOutlet weak var viewSmartKirana: UIView!
    @IBOutlet weak var customAlertView: customAlerts!
    
    ///mark: action
    @IBAction func btnForgotPswd(_ sender: UIButton) {
    }
    
    @IBAction func btnNewMember(_ sender: UIButton) {
    }
    @IBAction func btnGuestUser(_ sender: UIButton) {
    }
    
    @IBAction func btnPswdShow(_ sender: UIButton) {
        
        sender.isSelected  = !sender.isSelected
        
        if sender.isSelected{
            
            sender.setImage(UIImage(named: "passwordOff"), for: .normal)
            edtPassword.isSecureTextEntry = true
            
        }else{
            
            sender.setImage(UIImage(named: "passwordOn"), for: .normal)
            edtPassword.isSecureTextEntry = false
        }
        
    }
    
    
    @IBAction func btnClose(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfig()
        
    }
    
    
    func initialConfig() {
        
        customAlertView.btnClick = self
        UIView.animate(withDuration: 1, animations: { [self] in
            customAlertView.viewAlert.shadowEffects(shadow: .WithBorder, getView: customAlertView.viewAlert)
            customAlertView.alpha = 1
        }, completion: nil)
        
        viewSmartKirana.shadowEffects(shadow: .DarkShadow, getView: viewSmartKirana)
        viewLogin.shadowEffects(shadow: .DarkShadow, getView: viewLogin)
        edtPassword.shadowEffects(shadow: .WithBorder, getView: edtPassword)
        edtMail.shadowEffects(shadow: .WithBorder, getView: edtMail)
    }
    
    
}


///mark: extension

extension LoginVC: alertButtonclickEvent{
    
    func alertButtonClickEvent(Btn: UIButton) {
        UIView.animate(withDuration: 1, animations: { [self] in
            customAlertView.alpha = 0
        }, completion: nil)
    }
}
