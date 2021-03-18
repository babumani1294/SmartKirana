//
//  RetailSelectionController.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-03.
//

import UIKit

class RetailSelectionController: UIViewController {
    
    ///mark: property
    var updateRetailDetails: ModelUpdateRetailDetails!
    var getModelToRequestHomeDetails: ModelToRequestHomeDetails!
    var getRetailViewModel : RetailSelectionViewModel!
    var getHomeControllerVM : HomeControllerViewModel!
    //    var getUpdateHomeDetails = [getUpdateToHomeDetails]()
    var getMenu : [Menu]!
    
    
    let sectionInsets = UIEdgeInsets(top: 30.0,left: 0.0,bottom: 20.0,right: 0.0)
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    //    var getDeviceId: String?
    
    let minRowHeight: CGFloat = 50.0
    var isRetailTobeChanged = false
    
    
    var getDeviceId : String?
    var getSelectedRetailId: Int?
    
    
    var subMenu = [(String?,Int,String,String,Int)] ()//IMAGE URL/INNER ID/VALUE/NAME/STATUS
    var homeSelectionDetails = [(Int,[(String?,Int,String,String,Int)],Int,String?,String)] () //MENU ID/SUB_MENU(IMAGE/INNER ID/VALUE/NAME/STATUS)/MENU ENABLE/ MENU ACTION IMAGE/IS ARROW
    
    
    //    var retailVerticalDetails  = [(UIImage?,UIImage?,UIImage?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/ BOOL/ VALUE / STATUS
    var retailVerticalDetails  = [(String?,String?,String?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/ BOOL/ VALUE / STATUS
    
    
    
    var getCountryFlagName = [(UIImage?,String,String)]()
    
    var requestType : RequestType = .post{
        didSet{
            switch requestType{
            case .get:
                
                ///MARK: GETTING HOME SELECTION MENU DETAILS FROM SERVER.
                self.showActivity(title: "Loading")
                getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                guard let getDeviceId = getDeviceId else {
                    showError(getError: "Invalid Device Id",getMessage: "Problem in getting device Id!")
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
                                        showError(getError: "Error!", getMessage: "Problem in getting Sub_Menu for Home Details")
                                    }
                                    
                                    
                                    ///MARK GETTING SWITCH ACTION ICON FOR CELL
                                    
                                    if let getMenuId  = i.Menu_Id,let getMenuEnabel = i.Menu_Enable, let getMenuAction = i.Menu_Action,let getArrow = i.Is_Arrow{
                                        
                                        
                                        homeSelectionDetails.append((getMenuId, subMenu,getMenuEnabel, getMenuAction,getArrow))
                                        print(i.Menu_Id,subMenu.count)
                                        subMenu.removeAll()
                                        
                                    }else{
                                        showError(getError: "Error!", getMessage: "Problem in getting Menu Id,Menu Enable,Menu Action")
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
                                self.performSegue(withIdentifier: "showHomeScreen", sender: self)
                                
                            }else{
                                showError(getError: "Error!", getMessage: "Problem in getting Menu for Home Details")
                            }
                        }else{
                            showError(getError: "Error!", getMessage: "Problem in getting Status for Home Details")
                        }
                        
                    })
                }
                
            case .post:
                
                //                var getSelectedId = [Int]()
                getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                if let getFinalDeviceId = getDeviceId,let getFinalSelectedRetail = getSelectedRetailId{
                    
                    //                    getSelectedId.append(getFinalSelectedRetail)
                    
                    updateRetailDetails = ModelUpdateRetailDetails(getDevice: getFinalDeviceId,getVertical: getFinalSelectedRetail)
                    self.showActivity(title: "Loading...")
                    self.getRetailViewModel.updateSelectedRetailDetail(postRequest: HelperClass.shared.updateRetailVertical, sendDataModel: updateRetailDetails, vc: self, completion: {
                        self.requestType = .get
                    })
                    
                }
                
            }
        }
    }
    
    
    ///mark: outlet
    
    @IBOutlet weak var imgHeaderLogo: UIImageView!
    @IBOutlet weak var retailSelectionTV: UITableView!
    @IBOutlet weak var viewCustomAlert: customAlerts!
    @IBOutlet weak var imgBackward: UIImageView!
    
    @IBOutlet weak var imgFrwrd: UIImageView!
    @IBOutlet weak var btnGoNext: UIButton!
    @IBOutlet weak var btnGoBack: UIButton!
    
    ///mark: action
    @IBAction func btnGoNext(_ sender: Any) {
        
        var isRetailSelected = false
        
        for i in 0..<retailVerticalDetails.count{
            
            var getRetailDetails = self.retailVerticalDetails
            
            if  getRetailDetails != nil {
                if getRetailDetails[i].3 == true {
                    isRetailSelected = true
                    getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                    getSelectedRetailId = getRetailDetails[i].5
                    requestType = .post
                    
                    
                }else{
                    print("")
                }
            }else{
                showError(getError: "Error!", getMessage: "Problem in getting Retail Details on goNext.")
            }
            
        }
        
        if isRetailSelected{
            print("")
        }else{
            UIView.animate(withDuration: 0.5, animations: { [self] in
                
                self.viewCustomAlert.viewAlert.shadowEffects(shadow: .Alert, getView: self.viewCustomAlert.viewAlert, cornerRadius: 12)
                self.viewCustomAlert.lblAlertMessage.text = "Please select a Retail Vertical"
                self.viewCustomAlert.lblAlertTitle.text = "ERROR!"
                self.viewCustomAlert.alpha = 1
            }, completion: nil)
        }
        
        
        
    }
    @IBAction func btnGoBack(_ sender: UIButton) {
        
        for i in 0..<retailVerticalDetails.count{
            
            var getRetailDetails = self.retailVerticalDetails
            
            if  getRetailDetails  != nil {
                if getRetailDetails[i].3 == true {
                    self.performSegue(withIdentifier: "showHomeScreen", sender: self)
                }else{
                    UIView.animate(withDuration: 0.5, animations: { [self] in
                        
                        self.viewCustomAlert.viewAlert.shadowEffects(shadow: .Alert, getView: self.viewCustomAlert.viewAlert, cornerRadius: 12)
                        self.viewCustomAlert.lblAlertMessage.text = "Please select a Retail Vertical"
                        self.viewCustomAlert.lblAlertTitle.text = "ERROR!"
                        self.viewCustomAlert.alpha = 1
                    }, completion: nil)
                }
            }else{
                showError(getError: "Error!", getMessage: "Problem in getting Retail Details on goBack.")
            }
            
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            
            if self.isRetailTobeChanged{
                self.btnGoBack.isUserInteractionEnabled = true
                self.imgBackward.alpha = 1
                self.btnGoNext.isUserInteractionEnabled = false
                self.imgFrwrd.alpha = 0
            }
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showHomeScreen" else{
            return
        }
        
        //        let getHomeController = segue.destination as! HomeSelectionListController
        //        getHomeController.homeSelectionDetails =  homeSelectionDetails
        //        getHomeController.retailVerticalDetails = retailVerticalDetails
        //        if self.isRetailTobeChanged {
        //            getHomeController.isRetailsChanged = true
        //        }
        
        let getHomeController = segue.destination as! HomeScreenController
        getHomeController.homeSelectionDetails =  homeSelectionDetails
        getHomeController.retailVerticalDetails = retailVerticalDetails
        //        getHomeController.getUpdateHomeDetails = getUpdateHomeDetails
        if self.isRetailTobeChanged {
            getHomeController.isRetailsChanged = true
        }
    }
    
    
    
    ///mark : function
    func initialConfig() {
        imgHeaderLogo.sd_setImage(with: URL(string: HeaderLogo ?? ""))
        getHomeControllerVM = HomeControllerViewModel()
        
        getHomeControllerVM.showError = self
        viewCustomAlert.btnClick = self
        
        
        retailSelectionTV?.register(HomeSelectionCell.nib, forCellReuseIdentifier: HomeSelectionCell.identifier)
        getRetailViewModel = RetailSelectionViewModel()
        getRetailViewModel.showError = self
     
        if  retailVerticalDetails != nil {
            retailSelectionTV.delegate = self
            retailSelectionTV.dataSource = self
        }else{
            showError(getError: "Error!", getMessage: "Problem in getting Retail Details.")
        }
       
    }
    
}   


///mark: extension

extension RetailSelectionController: alertButtonclickEvent{
    func alertButtonClickEvent(Btn: UIButton) {
        UIView.animate(withDuration: 0.5, animations: { [self] in
            self.viewCustomAlert.alpha = 0
        }, completion: nil)
    }
}

extension RetailSelectionController: showError{
    func showError(getError: String, getMessage: String) {
        showDisconnectAlert(title: getError, message: getMessage)
    }
}


extension RetailSelectionController{
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


extension RetailSelectionController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retailVerticalDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeSelectionCell.identifier, for: indexPath) as? HomeSelectionCell {
            if retailVerticalDetails[indexPath.row].3{
                cell.lblRetail.text = retailVerticalDetails[indexPath.row].4
                //                cell.imgCell.image = retailVerticalDetails[indexPath.row].0
                cell.imgCell.sd_setImage(with: URL(string: retailVerticalDetails[indexPath.row].0!))
                cell.lblRetail.textColor = UIColor.black
            }else{
                cell.lblRetail.text = retailVerticalDetails[indexPath.row].4
                //                cell.imgCell.image = retailVerticalDetails[indexPath.row].0
                cell.imgCell.sd_setImage(with: URL(string: retailVerticalDetails[indexPath.row].0!))
                cell.lblRetail.textColor = UIColor.lightGray
                
            }
            
            
            return cell
        }
        
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let tHeight = tableView.frame.height
        let temp = tHeight / CGFloat(7)
        return temp > minRowHeight ? temp : minRowHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        retailVerticalDetails[indexPath.row].3 = !retailVerticalDetails[indexPath.row].3
        
        if retailVerticalDetails[indexPath.row].3 {
            retailVerticalDetails[indexPath.row].0 = retailVerticalDetails[indexPath.row].2
            
            for i in 0..<retailVerticalDetails.count{
                if i != indexPath.row{
                    retailVerticalDetails[i].0 = retailVerticalDetails[i].1
                    retailVerticalDetails[i].3 = false
                }
            }
            tableView.reloadData()
            
        }else{
            retailVerticalDetails[indexPath.row].0 = retailVerticalDetails[indexPath.row].1
            tableView.reloadData()
        }
        
    }
}



