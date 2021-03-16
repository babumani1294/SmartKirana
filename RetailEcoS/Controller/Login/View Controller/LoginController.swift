//
//  LoginVC.swift
//  RetailEcoS
//  LoginVC
//  description - To validate the credentials of the user 
//  Developed By
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit

class LoginController: UIViewController {
    
    
    ///mark: property
    var isValidEmail : (Bool,String)?
    var isValidPswd: (PasswordConditions,Bool,String)?{
        didSet{
            switch isValidPswd!.0{
            case .missingLength :
                UIView.animate(withDuration: 1, animations: {
                    self.viewProgress.setProgress(0.2, animated: true)
                    self.viewProgress.progressTintColor = UIColor.red
                })
            case .missingUpperCase:
                
                UIView.animate(withDuration: 1, animations: {
                    self.viewProgress.setProgress(0.4, animated: true)
                    self.viewProgress.progressTintColor = UIColor.red
                })
            case .missingLowerCase:
                UIView.animate(withDuration: 1, animations: {
                    self.viewProgress.setProgress(0.6, animated: true)
                    self.viewProgress.progressTintColor = UIColor.red
                })
            case .missingChar:
                UIView.animate(withDuration: 1, animations: {
                    self.viewProgress.setProgress(0.8, animated: true)
                    self.viewProgress.progressTintColor = UIColor.red
                })
            case .missingSpecialChar:
                UIView.animate(withDuration: 1, animations: {
                    UIView.animate(withDuration: 1, animations: {
                        self.viewProgress.setProgress(0.8, animated: true)
                        self.viewProgress.progressTintColor = UIColor.green
                    })
                })
            case .missingNumber:
                UIView.animate(withDuration: 1, animations: {
                    self.viewProgress.setProgress(0.9, animated: true)
                    self.viewProgress.progressTintColor = UIColor.green
                })
            case .success:
                UIView.animate(withDuration: 1, animations: {
                    self.viewProgress.setProgress(1, animated: true)
                    self.viewProgress.progressTintColor = UIColor.green
                })
            }
        }
    }
    var textFieldTag = 0
    var isEdtPasswordCreate = false
    var isRepeatPswdVisible = false
    var userStatus : checkUserState = .NewUser{
        didSet{
            switch userStatus{
            case .NewUser:
                print("")
            case .ExistingUser:
                
                UIView.animate(withDuration: 1.5, animations: {
                    
                    self.lblConfirmation.alpha = 1
                    self.btnLoginReset.alpha = 1
                    self.btnShowPswd2.alpha = 0
                    self.edtMailPassword.text = ""
                    self.edtMailPassword.placeholder = "Enter Your Email Id"
                    self.isEdtPasswordCreate = false
                    self.edtRepeatPswdPassword.text = ""
                    self.edtRepeatPswdPassword.placeholder = "Enter your Password"
                    self.edtRepeatPswdPassword.alpha = 1
                    self.edtRepeatPswdUderline.alpha = 1
                    self.viewProgress.alpha = 0
                    self.btnInfo.alpha = 0
                    self.btnShowPswd.alpha = 1
                    self.changeTitle(lbl: (self.lblWelcome,"Welcome!",UIColor.darkGray,1,UIFont.boldSystemFont(ofSize: 20.0)))
                    self.changeTitle(lbl: (self.lblTitle,"LOG IN",UIColor.lightGray,1,UIFont.systemFont(ofSize: 14)))
                    self.changeTitle(lbl: (self.lblSubTitle,"Enter atleast 8 characters",UIColor.darkGray,0,UIFont.systemFont(ofSize: 14)))
                    self.changeTitle(lbl: (self.lblConfirmation,"Forget your Password",UIColor.darkGray,1,UIFont.systemFont(ofSize: 14)))
                    self.btnLoginReset.setTitle("Reset it", for: .normal)
                    
                    
                })
            case .PasswordCreate:
                print("")
            }
        }
    }
    var finalPassword : String?
    
    var getDeviceId : String?
    var getSelectedRetailId: Int?
    
    var getModelToRequestHomeDetails: ModelToRequestHomeDetails!
    var getHomeControllerVM : HomeControllerViewModel!
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    var subMenu = [(String?,Int,String,String,Int)] ()//IMAGE URL/INNER ID/VALUE/NAME/STATUS
    var homeSelectionDetails = [(Int,[(String?,Int,String,String,Int)],Int,String?,String)] () //MENU ID/SUB_MENU(IMAGE/INNER ID/VALUE/NAME/STATUS)/MENU ENABLE/ MENU ACTION IMAGE/IS ARROW
    
    
    //    var retailVerticalDetails  = [(UIImage?,UIImage?,UIImage?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/ BOOL/ VALUE / STATUS
    var retailVerticalDetails  = [(String?,String?,String?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/ BOOL/ VALUE / STATUS
    
    
    
    
    var requestType : RequestType = .post{
        didSet{
            switch requestType{
            case .get:
                
                ///MARK: GETTING HOME SELECTION MENU DETAILS FROM SERVER.
                self.showActivity(title: "Loading")
                getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                guard let getDeviceId = getDeviceId else {
                    
                    self.showDisconnectAlert(title: "Invalid Device Id", message: "Problem in getting device Id!")
                    return
                }
                getModelToRequestHomeDetails = ModelToRequestHomeDetails(getDeviceId: getDeviceId, getPostalCode: "")
                
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    self.getHomeControllerVM.getHomeControllerDetails(postRequest: HelperClass.shared.getHomeDetails, sendDataModel: self.getModelToRequestHomeDetails, vc: self, completion: { [self] in
                        //----------
                        //                        MARK: OLD IMPLEMENTATION 6-3-2021
                        
                        //                        getMenu = getHomeControllerVM.getHomeControllerDetails.status?.Menu
                        //
                        //                        for i in 0...6{
                        //                            homeSelectionDetails[i].1 = getMenu[i].val ?? "no value"
                        //                        }
                        //
                        //                        if let getPostal = getPostal{
                        //                            homeSelectionDetails[0].1 = getPostal
                        //                            toShowPostalOverSwitchng = getPostal
                        //                        }
                        //
                        //                        if let getDeliveryAddress = getDeliveryAddress{
                        //                            homeSelectionDetails[4].1 = getDeliveryAddress
                        //                            toShowDeliverAddrssOverSwitchng = getDeliveryAddress
                        //                        }
                        
                        
                        //---------------
                        
                        ///MARK: NEW IMPLEMENTATION 6-3-2021
                        
                        if let getStatus = getHomeControllerVM.getHomeControllerDetails.status{
                            if let getMenu = getStatus.Menu{
                                
                                for i in getMenu{
                                    
                                    if let getSubMenu = i.Sub_Menu{
                                        for j in getSubMenu{
                                            
                                            subMenu.append((j.Imagepath!, j.Innerid!, j.Value!, j.Name!, j.status!))
                                            
                                        }
                                        
                                    }else{
                                        showDisconnectAlert(title: "Error!", message: "Problem in getting Sub_Menu for Home Details")
                                    }
                                    
                                    
                                    ///MARK GETTING SWITCH ACTION ICON FOR CELL
                                    
                                    if let getMenuId  = i.Menu_Id,let getMenuEnabel = i.Menu_Enable, let getMenuAction = i.Menu_Action,let getArrow = i.Is_Arrow{
                                        
                                        
                                        homeSelectionDetails.append((getMenuId, subMenu,getMenuEnabel, getMenuAction,getArrow))
                                        print(i.Menu_Id,subMenu.count)
                                        subMenu.removeAll()
                                        
                                    }else{
                                        showDisconnectAlert(title: "Error!", message: "Problem in getting Menu Id,Menu Enable,Menu Action")
                                    }
                                    
                                }
                                
                                
                                
                                ///MARK ADDING DEFAULT VALUE TO UPDATE HOME SCREEN MODEL
                                
                                if let getPostal = getPostal{
                                    homeSelectionDetails[0].1[0].3 = getPostal
                                    toShowPostalOverSwitchng = getPostal
                                }
                                
                                
                                
                                
                                if let getDeliveryAddress = getDeliveryAddress{
                                    homeSelectionDetails[4].1[0].3 = getDeliveryAddress
                                    toShowDeliverAddrssOverSwitchng = getDeliveryAddress
                                }
                                
                                
                                removeActivity()
                                self.performSegue(withIdentifier: "ShowHomeScreen", sender: self)
                                
                            }else{
                                showDisconnectAlert(title: "Error!", message: "Problem in getting Menu for Home Details")
                            }
                        }else{
                            showDisconnectAlert(title: "Error!", message: "Problem in getting Status for Home Details")
                        }
                        
                    })
                }
                
            case .post:
                
                print("")
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
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
    
    @IBOutlet weak var edtRepeatPswdUderline: UIView!
    @IBOutlet weak var viewProgress: UIProgressView!
    @IBOutlet weak var btnInfo: UIButton!
    
    
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
        requestType = .get
    }
    @IBAction func btnInfo(_ sender: UIButton) {
        UIView.animate(withDuration: 1, animations: { [self] in
            self.customAlertView.viewAlert.shadowEffects(shadow: .Alert, getView: self.customAlertView.viewAlert, cornerRadius: 12)
            
            self.customAlertView.lblAlertMessage.text = "The Password must contain at least 8 characters which should include at least one capital letter, one small letter, one numeral and one special character such as !@#$%7()_+=-"
            self.customAlertView.lblAlertTitle.text = "INFO"
            self.customAlertView.btnErrorInfo.setImage(UIImage(named: "imgInfo"), for: .normal)
            self.customAlertView.alpha = 1
        }, completion: nil)
    }
    
    
    @IBAction func edtMailPassword(_ sender: UITextField) {
        if isEdtPasswordCreate{
            self.validPassword(password: sender.text!)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialConfig()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowHomeScreen" else{
            return
        }
     
        let getHomeController = segue.destination as! HomeScreenController
        getHomeController.homeSelectionDetails =  homeSelectionDetails

    }
    
    
    
    ///mark: functions
    func initialConfig() {
        getHomeControllerVM = HomeControllerViewModel()
        getDone = self
        self.edtMailPassword.addDoneButtonOnKeyboard()
        self.edtRepeatPswdPassword.addDoneButtonOnKeyboard()
        self.viewProgress.setProgress(0.0, animated: true)
        self.viewProgress.progressTintColor = UIColor.red
        customAlertView.btnClick = self
        edtMailPassword.delegate = self
        edtRepeatPswdPassword.delegate = self
        
        self.changeTitle(lbl: (self.lblWelcome,"Welcome!",UIColor.darkGray,1,UIFont.boldSystemFont(ofSize: 25.0)))
        self.changeTitle(lbl: (self.lblTitle,"Log in with just your ",UIColor.lightGray,1,UIFont.systemFont(ofSize: 17)))
        self.changeTitle(lbl: (self.lblSubTitle,"Email Address and a Password",UIColor.lightGray,1,UIFont.systemFont(ofSize: 17)))
        self.changeTitle(lbl: (self.lblConfirmation,"Already Registered ? ",UIColor.lightGray,1,UIFont.systemFont(ofSize: 17)))
        edtRepeatPswdPassword.alpha = 0
        edtRepeatPswdUderline.alpha = 0
        viewProgress.alpha = 0
        btnInfo.alpha = 0
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
                self.customAlertView.viewAlert.shadowEffects(shadow: .Alert, getView: self.customAlertView.viewAlert, cornerRadius: 12)
                self.customAlertView.lblAlertMessage.text = "Invalid Email Address..."
                self.customAlertView.lblAlertTitle.text = "ERROR"
                self.customAlertView.btnErrorInfo.setImage(UIImage(named: "imgError"), for: .normal)
                self.customAlertView.alpha = 1
            }, completion: nil)
        case .PasswordCreate:
            
            guard let getPassword = edtMailPassword.text else {
                return
            }
            
            btnShowPswd2.alpha = 1
            isValidPswd = self.validPassword(password: getPassword)
            isValidPswd!.1 ? completion() :  UIView.animate(withDuration: 1, animations: { [self] in
                self.customAlertView.viewAlert.shadowEffects(shadow: .Alert, getView: self.customAlertView.viewAlert, cornerRadius: 12)
                
                self.customAlertView.lblAlertMessage.text = "The Password must contain at least 8 characters which should include at least one capital letter, one small letter, one numeral and one special character such as !@#$%7()_+=-"
                self.customAlertView.lblAlertTitle.text = "INFO"
                self.customAlertView.btnErrorInfo.setImage(UIImage(named: "imgInfo"), for: .normal)
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


extension LoginController{
    func showActivity(title: String) {
        
        DispatchQueue.main.async {
            self.strLabel.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
            self.effectView.removeFromSuperview()
            
            self.strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
            self.strLabel.text = title
            self.strLabel.font = .systemFont(ofSize: 14, weight: .medium)
            self.strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
            
            self.effectView.frame = CGRect(x: self.view.frame.midX - self.strLabel.frame.width/2, y: self.view.frame.midY - self.strLabel.frame.height/2 , width: 160, height: 46)
            self.effectView.layer.cornerRadius = 15
            self.effectView.layer.masksToBounds = true
            
            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
            self.activityIndicator.isUserInteractionEnabled = false
            self.view.isUserInteractionEnabled = false
            self.activityIndicator.startAnimating()
            
            
            self.effectView.contentView.addSubview(self.activityIndicator)
            self.effectView.contentView.addSubview(self.strLabel)
            self.view.addSubview(self.effectView)
            
        }
        
    }
    func removeActivity() {
        
        DispatchQueue.main.async {
            
            self.activityIndicator.stopAnimating()
            self.effectView.removeFromSuperview()
            self.activityIndicator.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
            
        }
        
    }
    func showToas(message : String, seconds: Double){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.view.backgroundColor = .black
            alert.view.alpha = 0.5
            alert.view.layer.cornerRadius = 15
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
                alert.dismiss(animated: true)
            }
            
        }
        
    }
    func showDisconnectAlert(title : String, message: String){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
            }
            alert.addAction(OkAction)
            alert.addAction(cancelAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}




extension LoginController: alertButtonclickEvent{
    func alertButtonClickEvent(Btn: UIButton) {
        UIView.animate(withDuration: 1, animations: { [self] in
            self.customAlertView.alpha = 0
        }, completion: nil)
    }
}


extension LoginController{
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
            }else {
                isValidPswd  = (.missingLowerCase,false,"")
            }
            if char.isUppercase{
                isUpperCase = true
            }else {
                isValidPswd  = (.success,false,"")
            }
            if char.isNumber{
                isNumber = true
            }else {
                isValidPswd  = (.missingChar,false,"")
            }
        }
        
        if password.count < 8{
            isValidPswd  = (.missingLength,false,"")
            return (.missingLength,false,"atleast 8 character")
        }else if password.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil{
            isValidPswd  = (.missingSpecialChar,false,"")
            return (.missingSpecialChar,false,"atleast 1 special character")
        }else if !isNumber{
            isValidPswd  = (.missingNumber,false,"")
            return (.missingNumber,false,"atleast 1 number")
        }else {
            if isLowerCase && isUpperCase{
                return (.success,true,"")
            }else if !isLowerCase && !isUpperCase{
                isValidPswd  = (.missingChar,false,"")
                return (.missingChar,false,"atleast 1 character")
            }else if isLowerCase{
                isValidPswd  = (.missingUpperCase,false,"")
                return (.missingUpperCase,false,"atleast 1 UpperCase")
            }else if isUpperCase{
                isValidPswd  = (.missingLowerCase,false,"")
                return (.missingLowerCase,false,"atleast 1 LowerCase")
            }
        }
        isValidPswd  = (.success,true,"")
        return (.success,true,"")
    }
}

extension LoginController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldTag = textField.tag
    }
}

extension LoginController: showError{
    func showError(getError: String, getMessage: String) {
        showDisconnectAlert(title: getError, message: getMessage)
    }
}

extension LoginController: donePressed {
    func DonePressed() {
        switch textFieldTag {
        case 0:
            switch userStatus {
            case .NewUser:
                validateCredentials(){
                    print("validation success")
                    UIView.animate(withDuration: 3, animations: {
                        self.userStatus = .PasswordCreate
                        self.edtMailPassword.text = ""
                        self.edtMailPassword.placeholder = "Password"
                        self.edtMailPassword.isSecureTextEntry = true
                        self.isEdtPasswordCreate = true
                        self.viewProgress.alpha = 1
                        self.btnInfo.alpha = 1
                        self.btnShowPswd2.alpha = 1
                        self.edtRepeatPswdPassword.placeholder = "Repeat Password"
                        self.edtRepeatPswdPassword.alpha = 1
                        self.edtRepeatPswdUderline.alpha = 1
                        self.edtRepeatPswdPassword.isSecureTextEntry = true
                        self.btnShowPswd.alpha = 1
                        self.changeTitle(lbl: (self.lblWelcome,"Welcome!",UIColor.darkGray,1,UIFont.boldSystemFont(ofSize: 25.0)))
                        self.changeTitle(lbl: (self.lblTitle,"Create a Password",UIColor.lightGray,1,UIFont.systemFont(ofSize: 17.0)))
                        self.changeTitle(lbl: (self.lblSubTitle,"Enter atleast 8 characters",UIColor.darkGray,0,UIFont.systemFont(ofSize: 14)))
                        
                        
                    }, completion: { (finished: Bool) in
                        
                        UIView.animate(withDuration: 0.5, animations: {
                            self.lblConfirmation.alpha = 1
                            self.btnLoginReset.alpha = 1
                        })
                        
                        
                    })
                }
            case .PasswordCreate:
                validateCredentials(){
                    finalPassword = edtMailPassword.text
                    
                    if isRepeatPswdVisible{
                        edtRepeatPswdPassword.text == finalPassword ? userStatus = .ExistingUser : UIView.animate(withDuration: 1, animations: { [self] in
                            self.customAlertView.lblAlertMessage.text = "Both the Passwords do not match Please enter them again. If necessary tap on the Eye ICON to Keep therm open so that you can See the passwords in readable form."
                            self.customAlertView.lblAlertTitle.text = "ERROR"
                            self.customAlertView.btnErrorInfo.setImage(UIImage(named: "imgError"), for: .normal)
                            self.customAlertView.alpha = 1
                            
                        }, completion: nil)
                    }else{
                        UIView.animate(withDuration: 3, animations: {
                            self.edtRepeatPswdPassword.placeholder = "Repeat Password"
                            self.isRepeatPswdVisible = true
                            self.edtRepeatPswdPassword.alpha = 1
                            self.edtRepeatPswdUderline.alpha = 1
                            self.viewProgress.alpha = 1
                            self.btnInfo.alpha = 1
                            self.btnShowPswd.alpha = 1
                        }, completion: nil)
                    }
                    
                }
            case .ExistingUser:
                print("")
            }
            
        case 1:
            switch userStatus {
            case .NewUser:
                print("")
            case .PasswordCreate:
                print(finalPassword)
                edtRepeatPswdPassword.text == finalPassword ? userStatus = .ExistingUser : UIView.animate(withDuration: 1, animations: { [self] in
                    self.customAlertView.viewAlert.shadowEffects(shadow: .Alert, getView: self.customAlertView.viewAlert, cornerRadius: 12)
                    self.customAlertView.lblAlertMessage.text = "Both the Passwords do not match Please enter them again. If necessary tap on the Eye ICON to Keep therm open so that you can See the passwords in readable form."
                    self.customAlertView.lblAlertTitle.text = "ERROR"
                    self.customAlertView.btnErrorInfo.setImage(UIImage(named: "imgError"), for: .normal)
                    self.customAlertView.alpha = 1
                    
                }, completion: nil)
            case .ExistingUser:
                print("aaaa")
            }
        default:
            print("")
        }
        self.view.endEditing(true)
        
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


