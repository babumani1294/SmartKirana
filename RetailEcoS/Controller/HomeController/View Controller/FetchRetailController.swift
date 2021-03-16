//
//  FetchRetailController.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-03-11.
//

import UIKit

class FetchRetailController: UIViewController {
    
    ///MARK: PROPERTY
    let minRowHeight: CGFloat = 50.0
//    var fetchVerticalDetails  =  [(UIImage?,UIImage?,UIImage?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/FALSE/RETAIL NAME/ID/STATUS

    var fetchVerticalDetails  =  [(String?,String?,String?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/FALSE/RETAIL NAME/ID/STATUS
    var getSelectedRetailId: Int?
    var updateRetailDetails: ModelUpdateRetailDetails!
    var getRetailViewModel : RetailSelectionViewModel!
    
    var getModelToRequestHomeDetails: ModelToRequestHomeDetails!
    var getHomeControllerVM : HomeControllerViewModel!
    
    var subMenu = [(String?,Int,String,String,Int)] ()//IMAGE URL/INNER ID/VALUE/NAME/STATUS
    var homeSelectionDetails = [(Int,[(String?,Int,String,String,Int)],Int,String?,String)] () //MENU ID/SUB_MENU(IMAGE/INNER ID/VALUE/NAME/STATUS)/MENU ENABLE/ MENU ACTION/IS ARROW
    
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    var requestType : RequestType = .post{
        didSet{
            switch requestType{
            case .get:
                
                self.showActivity(title: "Loading...")
                ///MARK: GETTING HOME SELECTION MENU DETAILS FROM SERVER.
                getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                guard let getDeviceId = getDeviceId else {
                    showError(getError: "Invalid Device Id",getMessage: "Problem in getting device Id!")
                    return
                }
                getModelToRequestHomeDetails = ModelToRequestHomeDetails(getDeviceId: getDeviceId, getPostalCode: "")
                
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    self.getHomeControllerVM.getHomeControllerDetails(postRequest: HelperClass.shared.getHomeDetails, sendDataModel: self.getModelToRequestHomeDetails, vc: self, completion: { [self] in
                        
                        ///MARK: NEW IMPLEMENTATION 6-3-2021
                        
                        if let getStatus = getHomeControllerVM.getHomeControllerDetails.status{
                            if let getMenu = getStatus.Menu{
                                for i in getMenu{
                                    
                                    if let getSubMenu = i.Sub_Menu{
                                        for j in getSubMenu{
                                            
                                         
                                                    subMenu.append(( j.Imagepath!, j.Innerid!, j.Value!, j.Name!, j.status!))
                                       
                                            
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
                                
                                
                                if let getPostal = getPostal{
                                    homeSelectionDetails[0].1[0].3 = getPostal
                                    toShowPostalOverSwitchng = getPostal
                                }
                                
                                if let getDeliveryAddress = getDeliveryAddress{
                                    homeSelectionDetails[4].1[0].3 = getDeliveryAddress
                                    toShowDeliverAddrssOverSwitchng = getDeliveryAddress
                                }
                                
                                
                                self.removeActivity()
                                self.performSegue(withIdentifier: "showBackHomeScreen", sender: self)
                                
                            }else{
                                showError(getError: "Error!", getMessage: "Problem in getting Menu for Home Details")
                            }
                        }else{
                            showError(getError: "Error!", getMessage: "Problem in getting Status for Home Details")
                        }
                        
                    })
                }
                
            case .post:
                self.showActivity(title: "Loading...")
                //                var getSelectedId = [Int]()
                getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                if let getFinalDeviceId = getDeviceId,let getFinalSelectedRetail = getSelectedRetailId{
                    
                    //                    getSelectedId.append(getFinalSelectedRetail)
                    
                    updateRetailDetails = ModelUpdateRetailDetails(getDevice: getFinalDeviceId,getVertical: getFinalSelectedRetail)
                    
                    self.getRetailViewModel.updateSelectedRetailDetail(postRequest: HelperClass.shared.updateRetailVertical, sendDataModel: updateRetailDetails, vc: self, completion: {
                        self.removeActivity()
                        self.requestType = .get
                    })
                    
                }
                
            }
        }
    }
    
    
    ///MARK: OUTLET
    @IBOutlet weak var retailSelectionTV: UITableView!
    @IBOutlet weak var btnGoBack: UIButton!
    
    
    ///MARK: ACTION
    @IBAction func btnGoBack(_ sender: UIButton) {
        //        dismiss(animated: true, completion: nil)
        
        
        for i in 0..<fetchVerticalDetails.count{
            
            var getRetailDetails = self.fetchVerticalDetails
            
            if  getRetailDetails != nil {
                
                if getRetailDetails[i].3 == true {
                    
                    getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                    getSelectedRetailId = getRetailDetails[i].5
                    requestType = .post
                    
                    
                }else{
                    //                    UIView.animate(withDuration: 0.5, animations: { [self] in
                    //
                    //                        self.viewCustomAlert.viewAlert.shadowEffects(shadow: .Alert, getView: self.viewCustomAlert.viewAlert, cornerRadius: 12)
                    //                        self.viewCustomAlert.lblAlertMessage.text = "Please select a Retail Vertical"
                    //                        self.viewCustomAlert.lblAlertTitle.text = "ERROR!"
                    //                        self.viewCustomAlert.alpha = 1
                    //                    }, completion: nil)
                    
                    
                    
                    print("please select any of vertical")
                    
                }
            }else{
                showError(getError: "Error!", getMessage: "Problem in getting Retail Details on goNext.")
            }
            
        }
        
        
    }
    
    
    ///MARK: VIEWS
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showBackHomeScreen" else{
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
        getHomeController.retailVerticalDetails = fetchVerticalDetails
        
    }
    
    func intialConfig() {
        getHomeControllerVM = HomeControllerViewModel()
        getRetailViewModel = RetailSelectionViewModel()
        retailSelectionTV?.register(HomeSelectionCell.nib, forCellReuseIdentifier: HomeSelectionCell.identifier)
        
        if fetchVerticalDetails != nil{
            retailSelectionTV.delegate = self
            retailSelectionTV.dataSource = self
        }else{
            showError(getError: "Error!", getMessage: "problem in getting fetching retail based on type")
        }
        
    }
}

extension FetchRetailController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchVerticalDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeSelectionCell.identifier, for: indexPath) as? HomeSelectionCell {
            if fetchVerticalDetails[indexPath.row].3{
                cell.lblRetail.text = fetchVerticalDetails[indexPath.row].4
//                cell.imgCell.image = fetchVerticalDetails[indexPath.row].0
                cell.imgCell.sd_setImage(with: URL(string: fetchVerticalDetails[indexPath.row].0 ?? ""))
                cell.lblRetail.textColor = UIColor.black
            }else{
                cell.lblRetail.text = fetchVerticalDetails[indexPath.row].4
//                cell.imgCell.image = fetchVerticalDetails[indexPath.row].0
                cell.imgCell.sd_setImage(with: URL(string: fetchVerticalDetails[indexPath.row].0 ?? ""))
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
        fetchVerticalDetails[indexPath.row].3 = !fetchVerticalDetails[indexPath.row].3
        
        if fetchVerticalDetails[indexPath.row].3 {
            fetchVerticalDetails[indexPath.row].0 = fetchVerticalDetails[indexPath.row].2
            
            for i in 0..<fetchVerticalDetails.count{
                if i != indexPath.row{
                    fetchVerticalDetails[i].0 = fetchVerticalDetails[i].1
                    fetchVerticalDetails[i].3 = false
                }
            }
            tableView.reloadData()
            
        }else{
            fetchVerticalDetails[indexPath.row].0 = fetchVerticalDetails[indexPath.row].1
            tableView.reloadData()
        }
    }
}


extension FetchRetailController: showError{
    func showError(getError: String, getMessage: String) {
        showDisconnectAlert(title: getError, message: getMessage)
    }
}

extension FetchRetailController{
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
