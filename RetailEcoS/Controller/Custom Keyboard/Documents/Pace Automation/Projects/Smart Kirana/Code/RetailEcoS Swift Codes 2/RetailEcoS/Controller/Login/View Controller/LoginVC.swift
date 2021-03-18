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
    var isValidEmail : (Bool,String)?
    var isValidPswd: (PasswordConditions,Bool,String)?
    var userStatus : checkUserState = .NewUser{
        didSet{
            switch userStatus{
            case .NewUser:
                print("")
            case .ExistingUser:
                self.btnLoginReset.setTitle("Reset it", for: .normal)
                
                UIView.animate(withDuration: 3, animations: {
                    
                    self.lblConfirmation.alpha = 1
                    self.btnLoginReset.alpha = 1
                    self.btnShowPswd2.alpha = 0
                    print(self.btnLoginReset.titleLabel?.text)
                    self.edtMailPassword.text = ""
                    self.edtMailPassword.placeholder = "Enter Your Email Id"
                    self.edtRepeatPswdPassword.text = ""
                    self.edtRepeatPswdPassword.placeholder = "Enter your Password"
                    self.edtRepeatPswdPassword.alpha = 1
                    self.btnShowPswd.alpha = 1
                    self.changeTitle(lbl: (self.lblWelcome,"Welcome To",UIColor.black,1,UIFont.boldSystemFont(ofSize: 20.0)))
                    self.changeTitle(lbl: (self.lblTitle,"Log in with your Email and Password",UIColor.black,1,UIFont.systemFont(ofSize: 14)))
                    self.changeTitle(lbl: (self.lblSubTitle,"Enter atleast 8 characters",UIColor.darkGray,0,UIFont.systemFont(ofSize: 14)))
                    self.changeTitle(lbl: (self.lblConfirmation,"Forget your Password",UIColor.darkGray,1,UIFont.systemFont(ofSize: 14)))
                    
                })
            case .PasswordCreate:
                print("")
            }
        }
    }
    var finalPassword : String?
    
    ///mark: outlet
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblConfirmation: UILabel!
    @IBOutlet weak var edtMailPassword: UITextField!
    @IBOutlet weak var edtRepeatPswdPassword: UITextField!
    @IBOutlet weak var customAlertView: customAlerts!
    @IBOutlet weak var btnShowPswd2: UIButton!
    @IBOutlet weak var btnShowPswd: UIButton!
    @IBOutlet weak var btnLoginReset: UIButton!
    
    
    ///mark: action
    
    
    @IBAction func btnPswdShow(_ sender: UIButton) {
        
        
        switch sender.tag {
        case 0:
            sender.isSelected  = !sender.isSelected
            if sender.isSelected{
                
                sender.setImage(UIImage(named: "passwordOff"), for: .normal)
                edtMailPassword.isSecureTextEntry = true
            }else{
                
                sender.setImage(UIImage(named: "passwordOn"), for: .normal)
                edtMailPassword.isSecureTextEntry = false
            }
            
            
        case 1:
            sender.isSelected  = !sender.isSelected
            if sender.isSelected{
                
                sender.setImage(UIImage(named: "passwordOff"), for: .normal)
                edtRepeatPswdPassword.isSecureTextEntry = true
            }else{
                
                sender.setImage(UIImage(named: "passwordOn"), for: .normal)
                edtRepeatPswdPassword.isSecureTextEntry = false
            }
            
        default:
            print("")
        }
        
        
        
        
        
    }
    @IBAction func btnLoginReset(_ sender: UIButton) {
        
        //        validateCredentials(){
        //            UIView.animate(withDuration: 3, animations: {
        //                self.userStatus = .PasswordCreate
        //                self.edtMailPassword.text = ""
        //                self.edtMailPassword.placeholder = "Enter Password"
        //                self.edtRepeatPswdPassword.placeholder = "Repeat Password"
        //                self.edtRepeatPswdPassword.alpha = 1
        //                self.btnShowPswd.alpha = 1
        //                self.changeTitle(lbl: (self.lblWelcome,"Welcome To",UIColor.black,1,UIFont.boldSystemFont(ofSize: 20.0)))
        //                self.changeTitle(lbl: (self.lblTitle,"Create a Password",UIColor.black,1,UIFont.boldSystemFont(ofSize: 20.0)))
        //                self.changeTitle(lbl: (self.lblSubTitle,"Enter atleast 8 characters",UIColor.darkGray,1,UIFont.systemFont(ofSize: 14)))
        //
        //
        //            }, completion: { (finished: Bool) in
        //
        //                UIView.animate(withDuration: 1, animations: {
        //                    self.lblConfirmation.alpha = 0
        //                    self.btnLoginReset.alpha = 0
        //                })
        //
        //
        //            })
        //        }
    }
    @IBAction func btnShowHome(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfig()
        
    }
    
    
    ///mark: functions
    
    func initialConfig() {
        
        customAlertView.btnClick = self
        edtMailPassword.delegate = self
        edtRepeatPswdPassword.delegate = self
        
        edtMailPassword.setUnderLine()
        edtRepeatPswdPassword.setUnderLine()
        
        self.changeTitle(lbl: (self.lblWelcome,"Welcome To",UIColor.black,1,UIFont.boldSystemFont(ofSize: 20.0)))
        self.changeTitle(lbl: (self.lblTitle,"You can Log in just using your email",UIColor.darkGray,1,UIFont.systemFont(ofSize: 14)))
        self.changeTitle(lbl: (self.lblSubTitle,"Enter your email",UIColor.black,1,UIFont.boldSystemFont(ofSize: 20.0)))
        self.changeTitle(lbl: (self.lblConfirmation,"Already have an account ? ",UIColor.black,1,UIFont.systemFont(ofSize: 14)))
        edtRepeatPswdPassword.alpha = 0
        btnShowPswd.alpha = 0
        btnShowPswd2.alpha = 0
        
    }
    func validateCredentials(completion: () -> Void) {
        
        switch userStatus {
        case .NewUser:
            guard let getEmail = edtMailPassword.text else {
                return
            }
            
//            btnShowPswd2.alpha = 0
            
            isValidEmail = self.validateEmail(getEmail: getEmail)
            
            isValidEmail!.0 ? completion() :  UIView.animate(withDuration: 1, animations: { [self] in
                self.customAlertView.viewAlert.shadowEffects(shadow: .WithBorder, getView: self.customAlertView.viewAlert)
                self.customAlertView.lblAlertMessage.text = "Invalid Email Address..."
                self.customAlertView.alpha = 1
            }, completion: nil)
        case .PasswordCreate:
            
            guard let getPassword = edtMailPassword.text else {
                return
            }
            
            btnShowPswd2.alpha = 1
            isValidPswd = self.validPassword(password: getPassword)
            isValidPswd!.1 ? completion() :  UIView.animate(withDuration: 1, animations: { [self] in
                self.customAlertView.viewAlert.shadowEffects(shadow: .WithBorder, getView: self.customAlertView.viewAlert)
                self.customAlertView.lblAlertMessage.text = "The password should atleast 8 characters long and must contain atleast one Capital letter,one small letter,one numerical and one special character."
                self.customAlertView.alpha = 1
            }, completion: nil)
        case .ExistingUser:
            print("")
        }
        
        
    }
    func changeTitle(lbl: (UILabel,String,UIColor,CGFloat,UIFont)){
        lbl.0.text = lbl.1
        lbl.0.textColor = lbl.2
        lbl.0.alpha = lbl.3
        lbl.0.font = lbl.4
    }
    
}


///mark: extension

extension LoginVC: alertButtonclickEvent{
    
    func alertButtonClickEvent(Btn: UIButton) {
        UIView.animate(withDuration: 1, animations: { [self] in
            self.customAlertView.alpha = 0
        }, completion: nil)
    }
    
}


extension LoginVC{
    func validateEmail(getEmail: String) -> (Bool,String) {
        if getEmail.isEmpty{
            return (false,"Email Field is Empty")
        }else{
            let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let checkEmail = NSPredicate(format:"SELF MATCHES %@", format)
            if checkEmail.evaluate(with: getEmail){
                return (checkEmail.evaluate(with: getEmail), "")
            }else{
                return (checkEmail.evaluate(with: getEmail), "Invalid Email")
            }
            
        }
    }
    func validPassword(password: String) -> (PasswordConditions,Bool,String){
        var isLowerCase = false
        var isUpperCase = false
        var isNumber = false
        
        for char in password{
            if char.isLowercase{
                isLowerCase = true
            }
            if char.isUppercase{
                isUpperCase = true
            }
            if char.isNumber{
                isNumber = true
            }
        }
        
        if password.count < 8{
            return (.missingLength,false,"atleast 8 character")
        }else if password.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil{
            return (.missingSpecialChar,false,"atleast 1 special character")
        }else if !isNumber{
            return (.missingNumber,false,"atleast 1 number")
        }else {
            if isLowerCase && isUpperCase{
                return (.success,true,"")
            }else if !isLowerCase && !isUpperCase{
                return (.missingChar,false,"atleast 1 character")
            }else if isLowerCase{
                return (.missingUpperCase,false,"atleast 1 UpperCase")
            }else if isUpperCase{
                return (.missingLowerCase,false,"atleast 1 LowerCase")
            }
        }
        return (.success,true,"")
    }
}

extension LoginVC: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        switch textField.tag {
        //        case 0:
        //            switch userStatus {
        //            case .NewUser:
        //                validateCredentials(){
        //                    print("validation success")
        //                }
        //            case .PasswordCreate:
        //                validateCredentials(){
        //                    finalPassword = edtMailPassword.text
        //                }
        //            case .ExistingUser:
        //                print("")
        //            }
        //
        //        case 1:
        //            switch userStatus {
        //            case .NewUser:
        //                print("")
        //            case .PasswordCreate:
        //
        //                textField.text == finalPassword ? userStatus = .ExistingUser : UIView.animate(withDuration: 1, animations: { [self] in
        //                    self.customAlertView.viewAlert.shadowEffects(shadow: .WithBorder, getView: self.customAlertView.viewAlert)
        //                    self.customAlertView.lblAlertMessage.text = "Password Mismatched..."
        //                    self.customAlertView.alpha = 1
        //
        //                }, completion: nil)
        //            case .ExistingUser:
        //                print("")
        //            }
        //        default:
        //            print("")
        //        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            switch userStatus {
            case .NewUser:
                validateCredentials(){
                    print("validation success")
                    UIView.animate(withDuration: 3, animations: {
                        self.userStatus = .PasswordCreate
                        self.edtMailPassword.text = ""
                        self.edtMailPassword.placeholder = "Enter Password"
                        self.btnShowPswd2.alpha = 1
                        //                        self.edtRepeatPswdPassword.placeholder = "Repeat Password"
                        //                        self.edtRepeatPswdPassword.alpha = 1
                        //                        self.btnShowPswd.alpha = 1
                        self.changeTitle(lbl: (self.lblWelcome,"Welcome To",UIColor.black,1,UIFont.boldSystemFont(ofSize: 20.0)))
                        self.changeTitle(lbl: (self.lblTitle,"Create a Password",UIColor.black,1,UIFont.boldSystemFont(ofSize: 20.0)))
                        self.changeTitle(lbl: (self.lblSubTitle,"Enter atleast 8 characters",UIColor.darkGray,1,UIFont.systemFont(ofSize: 14)))
                        
                        
                    }, completion: { (finished: Bool) in
                        
                        UIView.animate(withDuration: 1, animations: {
                            self.lblConfirmation.alpha = 0
                            self.btnLoginReset.alpha = 0
                        })
                        
                        
                    })
                }
            case .PasswordCreate:
                validateCredentials(){
                    finalPassword = edtMailPassword.text
                    UIView.animate(withDuration: 3, animations: {
                        self.edtRepeatPswdPassword.placeholder = "Repeat Password"
                        self.edtRepeatPswdPassword.alpha = 1
                        self.btnShowPswd.alpha = 1
                    }, completion: nil)
                }
            case .ExistingUser:
                print("")
            }
            
        case 1:
            switch userStatus {
            case .NewUser:
                print("")
            case .PasswordCreate:
                
                textField.text == finalPassword ? userStatus = .ExistingUser : UIView.animate(withDuration: 1, animations: { [self] in
                    self.customAlertView.viewAlert.shadowEffects(shadow: .WithBorder, getView: self.customAlertView.viewAlert)
                    self.customAlertView.lblAlertMessage.text = "Password Mismatched..."
                    self.customAlertView.alpha = 1
                    
                }, completion: nil)
            case .ExistingUser:
                print("aaaa")
            }
        default:
            print("")
        }
        self.view.endEditing(true)
        return false
    }
}


enum checkUserState {
    case NewUser
    case PasswordCreate
    case ExistingUser
}

enum PasswordConditions{
    case missingLength
    case missingUpperCase
    case missingLowerCase
    case missingChar
    case missingSpecialChar
    case missingNumber
    case success
}


