//
//  SplashController.swift
//  RetailEcoS
//
//  Created by GBC  on 16/01/21.
//

import UIKit
import CoreLocation
import AVFoundation
import Photos
import Contacts


var getPostalCode: ModelToFetchCompanyDetails!
var sec = 0
var getCountry : String?
var getPostal: String?
var getDeliveryAddress : String?
var getCountryTimeZone: String?
var userCountyFlag : UIImage?

var getCountryPostalCode: String?
var permissions  = (false,false,false,false,false)

class SplashController: UIViewController, CLLocationManagerDelegate {
    
    ///mark: property
    var getModelToGiveCountry: ModelToGiveCountry!
    var getSplashViewModel : SplashViewModel!
    
    var getModelToGiveDeviceId: DeviceID!
    var getRetailViewModel : RetailSelectionViewModel!
    
    var getCurrentTime = Timer()
    
    var isTimerOver: Bool!
    var getDeviceId: String?
    var getLatitude: String?
    var getLongitude: String?
    var getTimeStamp: String?
    var getLocalityData = [String]()
    var lblColor = (UIColor.gray,UIColor.systemBlue,UIColor.orange)
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation!
    var hasPermission = false
    var didFindLocation = false
    var new = [(String,String,String,Int)]()//title/logo/lapseTime/id
    var number = 0
    var count = 0
    var retailVerticalDetails : [(UIImage?,UIImage?,UIImage?, Bool,String)] = [(UIImage(named: "imgApparel")!,UIImage(named: "imgApparel")!,UIImage(named: "imgApparel-1")!, false,"Apparel"),(UIImage(named: "imgBeauty")!,UIImage(named: "imgBeauty")!,UIImage(named: "imgBeauty-1")!, false,"Beauty"),(UIImage(named: "imgElectrical")!,UIImage(named: "imgElectrical")!,UIImage(named: "imgElectrical-1")!, false,"Electrical"),(UIImage(named: "imgEyewear")!,UIImage(named: "imgEyewear")!,UIImage(named: "imgEyewear-1")!, false,"Eyewear"),(UIImage(named: "imgFashion")!,UIImage(named: "imgFashion")!,UIImage(named: "imgFashion-1")!, false,"Fashion"),(UIImage(named: "imgFootwear")!,UIImage(named: "imgFootwear")!,UIImage(named: "imgFootwear-1")!, false,"Footwear"),(UIImage(named: "imgFurniture")!,UIImage(named: "imgFurniture")!,UIImage(named: "imgFurniture-1")!, false,"Furniture"),(UIImage(named: "imgGrocery")!,UIImage(named: "imgGrocery")!,UIImage(named: "imgGrocery-1")!, false,"Grocery"),(UIImage(named: "imgAppliance")!,UIImage(named: "imgAppliance")!,UIImage(named: "imgAppliance-1")!, false,"Appliances"),(UIImage(named: "imgJewellery")!,UIImage(named: "imgJewellery")!,UIImage(named: "imgJewellery-1")!, false,"Jewellery"),(UIImage(named: "imgLuggage")!,UIImage(named: "imgLuggage")!,UIImage(named: "imgLuggage-1")!, false,"Luggage"),(UIImage(named: "imgStationary")!,UIImage(named: "imgStationary")!,UIImage(named: "imgStationary-1")!, false,"Stationary")]
    
    
    
    
    ///mark: get/post Request
    var splashChange: RequestType = .get{
        
        didSet{
            
            switch splashChange {
            case .get:
                
                print("")
                
            case .post:
                
                if self.new.count > 0 {
                    
                    
                    if self.count < self.new.count{
                        
                        generateCurrentTimeStamp2()
                        
                        // Create URL
                        let url = URL(string: self.new[self.count].1 ?? "https://www.smartkirana.ca/retailecos/Logo/ServiceLogoCanada.png")!
                        
                        // Fetch Image Data
                        if let data = try? Data(contentsOf: url) {
                            // Create Image and Update Image View
                            self.imgLogo.image = UIImage(data: data)
                        }
                        
                        self.lblTitle.text = self.new[self.count].0
                        //                        self.count += 1
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(new[self.count].2)!) {
                            self.count += 1
                            self.splashChange = .post
                        }
                    }else{
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.performSegue(withIdentifier: "showRetailVertical", sender: self)
                        }
                    }
                    
                    
                }else{
                    self.showError(getError: "problem in appending received data!", getMessage: "")
                }
                
                
                
            default:
                print("")
            }
        }
        
    }
    ///Mark: Get /Post Property observer.
    var requestType : RequestType = .post{
        didSet{
            switch requestType{
            case .get:
                guard let getLat = getLatitude, let getLong = getLongitude else {
                    showError(getError: "Problem in getting lat/long", getMessage: "")
                    return
                }
                
                ///Mark: Get request to get country name/country postal code/country address
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    self.getSplashViewModel.getCountryPostalCode(getLat: getLat, getLong: getLong, vc: self, completions: {
                        
                        guard let getCountryPostalCode = self.getSplashViewModel.getCountryPostalCode else{
                            return
                        }
                        
                        if let getResult = getCountryPostalCode.results[0]{
                            
                            var  getAddressComponent = getResult.address_components
                            
                            if getAddressComponent != nil{
                                
                                //                                for j in getAddressComponent{
                                //
                                //                                    //mark:for getting address number and first address
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "premise"{
                                //                                            getNo = j!.long_name ?? "not found"
                                //                                        }
                                //                                    }
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "route"{
                                //                                            getAddress1 = j!.long_name ?? "not found"
                                //
                                //                                            if let getFinalno = getNo, let getFinalAddress = getAddress1{
                                //                                                getFinalAddress1 = getFinalno + "," + getFinalAddress
                                //                                            }else{
                                //                                                getFinalAddress1 = getAddress1
                                //                                            }
                                //                                        }
                                //                                    }
                                //
                                //                                    //mark:for getting address 2
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "sublocality_level_3"{
                                //                                            getAddress2 = j!.long_name ?? "not found"
                                //                                        }
                                //                                    }
                                //
                                //                                    //mark:for getting locality
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "sublocality_level_1"{
                                //                                            getLocality = j!.long_name ?? "not found"
                                //
                                //                                        }
                                //                                    }
                                //
                                //                                    //mark:for getting city
                                //
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "locality"{
                                //                                            getCity = j!.long_name ?? "not found"
                                //                                        }
                                //                                    }
                                //
                                //                                    //mark:for getting state
                                //
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "administrative_area_level_1"{
                                //                                            getState = j!.long_name ?? "not found"
                                //                                        }
                                //                                    }
                                //
                                //                                    //mark:for getting postal code
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "postal_code"{
                                //                                            getPostal = j!.long_name ?? "not found"
                                //                                            getPostalCodee = j!.long_name ?? "not found"
                                //                                        }
                                //                                    }
                                //
                                //                                    //mark:for getting country
                                //
                                //
                                //                                    for i  in j!.types {
                                //                                        if i == "country"{
                                //                                            getCountry = j!.long_name ?? "not found"
                                //                                        }
                                //                                    }
                                //
                                //                                }
                                
                                
                                
                                for j in getAddressComponent{
                                    
                                    //mark:for getting address number and first address
                                    if let premise = j?.types{
                                        if premise.contains("premise"){
                                            getNo = j!.long_name ?? "not found"
                                        }else if premise.contains("route"){
                                           
                                            getAddress1 = j!.long_name ?? "not found"
                                            
                                            if let getFinalno = getNo, let getFinalAddress = getAddress1{
                                                getFinalAddress1 = getFinalno + "," + getFinalAddress
                                            }else{
                                                getFinalAddress1 = getAddress1
                                            }
                                            
                                            
                                        }else if premise.contains("postal_code"){
                                            getPostal = j!.long_name ?? "not found"
                                            getPostalCodee = j!.long_name ?? "not found"
                                        }else if premise.contains("political"){
                                            
                                            if premise.contains("locality"){
                                                getCity = j!.long_name ?? "not found"
                                            }else if premise.contains("sublocality"){
                                            
                                                if self.getLocalityData.contains(j!.long_name ?? "not found"){
                                                    
                                                }else{
                                                    self.getLocalityData.append(j!.long_name ?? "not found")
                                                    
                                                    if self.getLocalityData.count == 1{
                                                        getAddress2 = self.getLocalityData[0]
                                                        getLocality = "not found"
                                                    }else if self.getLocalityData.count > 1{
                                                        getAddress2 = self.getLocalityData[0]
                                                        getLocality = self.getLocalityData[1]
                                                    }
                                                 
                                                }
                                                
                                                
                                            }else  if premise.contains("country"){
                                                getCountry = j!.long_name ?? "not found"
                                            }else if premise.contains("administrative_area_level_1"){
                                                getState = j!.long_name ?? "not found"
                                            }else{
                                                print(j?.long_name)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            
                            getDeliveryAddress = getResult.formatted_address
                            //                                getAddress1 = getResult.formatted_address ?? "not found"
                            //                                getAddress2 = getResult.formatted_address ?? "not found"
                            
                            
                        }else{
                            self.showError(getError: "Error!", getMessage: "problem in getting result in response")
                        }
                        
                        //                        for i in getCountryPostalCode.results{
                        //
                        //                            if let geta = i?.address_components{
                        //                                for j in i!.address_components{
                        //
                        //
                        //
                        //                                    for i  in j!.types {
                        //                                        if i == "sublocality"{
                        //                                            getLocality = j!.long_name ?? "not found"
                        //                                        }
                        //                                    }
                        //
                        //                                    for i  in j!.types {
                        //                                        if i == "locality"{
                        //                                            getCity = j!.long_name ?? "not found"
                        //
                        //                                        }
                        //                                    }
                        //
                        //                                    for i  in j!.types {
                        //                                        if i == "administrative_area_level_1"{
                        //                                            getState = j!.long_name ?? "not found"
                        //                                        }
                        //                                    }
                        //
                        //                                    for i  in j!.types {
                        //                                        if i == "postal_code"{
                        //                                            getPostal = j!.long_name ?? "not found"
                        //                                            getPostalCodee = j!.long_name ?? "not found"
                        //                                        }
                        //                                    }
                        //
                        //                                    for i  in j!.types {
                        //                                        if i == "country"{
                        //                                            getCountry = j!.long_name ?? "not found"
                        //                                        }
                        //                                    }
                        //
                        //                                }
                        //                                getDeliveryAddress = i?.formatted_address
                        //                                getAddress1 = i?.formatted_address ?? "not found"
                        //                                getAddress2 = i?.formatted_address ?? "not found"
                        //
                        //                            }
                        //                        }
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.generateCurrentTimeStamp2()
                            self.requestType = .post //2
                        }
                        
                    })
                    
                }
                
                ///Mark: Paralel Get request to get country time zone id
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    guard let getLat = self.getLatitude, let getLong = self.getLongitude else {
                        self.showError(getError: "Problem in getting lat/long", getMessage: "")
                        return
                    }
                    
                    ///mark: getting time zone format, for current user location - to show current countries time in home controller.
                    self.getSplashViewModel.getCountryTimeZone(getLat: getLat, getLong: getLong, getTimeStamp: "00", vc: self, completions: {
                        
                        guard let getTimeZone = self.getSplashViewModel.getCountryTimeZone else{
                            return
                        }
                        
                        getCountryTimeZone = getTimeZone.timeZoneId// 1
                        
                    })
                    
                }
                
                ///Mark: Paralel Get request to get retail vertical details
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    guard let getDeviceId = self.getDeviceId else {
                        self.showError(getError: "Problem in getting Device Id", getMessage: "")
                        return
                    }
                    
                    self.getModelToGiveDeviceId = DeviceID(getDeviceId: getDeviceId)
                    
                    self.getRetailViewModel.getRetailVerticalDetails(postRequest: HelperClass.shared.urlFetchVerticalDetails, sendDataModel: self.getModelToGiveDeviceId, vc: self, completion: {
                        
                        guard let getRetailDetails = self.getRetailViewModel.getRetailDetails.status.PERMISSION else{
                            return
                        }
                        self.retailVerticalDetails.removeAll()
                        
                        DispatchQueue.global(qos: .userInitiated).async() {
                            
                            for (index,element) in getRetailDetails.enumerated(){
                                
                                
                                if let getUnselectedIcon = URL(string: element.url_unselected ?? "https://www.smartkirana.ca/retailecos/Logo/ServiceLogoCanada.png"), let getSelectedIcon =  URL(string: element.url_selected ?? "https://www.smartkirana.ca/retailecos/Logo/ServiceLogoCanada.png") {
                                    
                                    // Fetch Image Data
                                    if let unSelectedData = try? Data(contentsOf: getUnselectedIcon), let selectedData = try? Data(contentsOf: getSelectedIcon)  {
                                        
                                        self.retailVerticalDetails.append((UIImage(data: unSelectedData),UIImage(data: unSelectedData),  UIImage(data: selectedData),false,element.val ?? "")) //3
                                        
                                    }
                                    
                                } else {
                                    self.showError(getError: "Error!", getMessage: "Problem in getting image from URL!")
                                }
                            }
                        }
                    })
                }
                
                
            case .post:
                
                
                guard let getDeviceId = getDeviceId, let getTimeStamp = getTimeStamp, let getCountry = getCountry else {
                    showError(getError: "Problem in getting Device Id/ Time Stamp", getMessage: "")
                    return
                }
                
                getModelToGiveCountry = ModelToGiveCountry(getCountry: getCountry, getTimeStamp: getTimeStamp, getDeviceId: getDeviceId)
                
                getSplashViewModel.getCompanyDetails(postRequest: HelperClass.shared.urlFetchCompanyDetails, sendDataModel: getModelToGiveCountry, vc: self, completion: { [self] in
                    
                    
                    getPostalCode = getSplashViewModel.getCompanyDetails
                    
                    let userFlagUrl = URL(string: self.getSplashViewModel.getCompanyDetails.status.Country_flag ?? "https://www.smartkirana.ca/retailecos/assets/images/flag/flag-of-India.png")!
                    
                    // Fetch Image Data
                    if let data = try? Data(contentsOf: userFlagUrl) {
                        // Create Image and Update Image View
                        userCountyFlag = UIImage(data: data)
                    }
                    
                    if let getCountryPostal = self.getSplashViewModel.getCompanyDetails.status.Postal_Code_Format{
                        getCountryPostalCode = getCountryPostal
                    }
                    
                    if let getSplashList = getSplashViewModel.getCompanyDetails.status.splash{
                        
                        for (index,element) in getSplashList.enumerated(){
                            new.append((element.Title ?? "", element.Logo ?? "", element.Lapse_Time ?? "3", element.Id ?? 0))
                        }
                        
                        splashChange = .post //4
                        
                    }else{
                        showError(getError: "Splash Details not found!", getMessage: "")
                    }
                    
                })
                
            }
        }
    }
    
    //OpenSans
    //lbl.font = UIFont(name:"OpenSans",size:15)
    
    ///mark: outlet
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewCustomAlert: customAlerts!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialCofig()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showRetailVertical" else{
            return
        }
        
        let getRetailController = segue.destination as! RetailSelectionController
        getRetailController.retailVerticalDetails = retailVerticalDetails
    }
    
    ///mark: function
    func  initialCofig() {
        
        //to calculate time in milliseconds
        
        getSplashViewModel = SplashViewModel()
        getSplashViewModel.showError = self
        getRetailViewModel = RetailSelectionViewModel()
        getRetailViewModel.showError = self
        viewCustomAlert.btnClick = self
        getDeviceId = UIDevice.current.identifierForVendor?.uuidString
        getTimeStamp = generateCurrentTimeStamp()
        
        // Get Location Permission one time only
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Need to update location and get location data in locationManager object with delegate
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    func generateCurrentTimeStamp () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return (formatter.string(from: Date()) as NSString) as String
    }
    func generateCurrentTimeStamp2 () -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd H:m:ss.SSSS"
        return (formatter.string(from: Date()) as NSString) as String
    }
    
    
    @objc func fire()
    {
        isTimerOver = true
        print("FIRE!!!")
    }
    
    ///mark: get location information
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        currentLoc = locations.first
        
        if let getCurrentLoc = currentLoc{
            getLatitude = String(getCurrentLoc.coordinate.latitude)
            getLongitude = String(getCurrentLoc.coordinate.longitude)
            self.imgLogo.image = UIImage(named: "imgConfluence")
            self.lblTitle.text = "From"
            requestType = .get
        }else{
            showError(getError: "Something Went Wrong!", getMessage: "Unable to get Location!")
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways:
            print("")
        case .authorizedWhenInUse:
            print("")
        case .denied:
            showAlertToSettingPage(title: "Error!", message: "The application requires to use your current location to provide important Geo position information on the stores, provide delivery address etc., and without this permission the application cannot work")
        case .notDetermined:
            print("")
            
        default:
            print("")
        }
    }
}



///mark: extension
extension SplashController: alertButtonclickEvent{
    func alertButtonClickEvent(Btn: UIButton) {
        UIView.animate(withDuration: 1, animations: { [self] in
            self.viewCustomAlert.alpha = 0
            exit(0)
        }, completion: nil)
    }
}

extension SplashController: showError{
    func showError(getError: String, getMessage: String) {
        showDisconnectAlert(title: getError, message: getMessage)
    }
}

extension SplashController{
    //    func showActivity(title: String) {
    //
    //        DispatchQueue.main.async {
    //            self.strLabel.removeFromSuperview()
    //            self.activityIndicator.removeFromSuperview()
    //            self.effectView.removeFromSuperview()
    //
    //            self.strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
    //            self.strLabel.text = title
    //            self.strLabel.font = .systemFont(ofSize: 14, weight: .medium)
    //            self.strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
    //
    //            self.effectView.frame = CGRect(x: self.view.frame.midX - self.strLabel.frame.width/2, y: self.view.frame.midY - self.strLabel.frame.height/2 , width: 160, height: 46)
    //            self.effectView.layer.cornerRadius = 15
    //            self.effectView.layer.masksToBounds = true
    //
    //            self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    //            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
    //            self.activityIndicator.isUserInteractionEnabled = false
    //            self.view.isUserInteractionEnabled = false
    //            self.activityIndicator.startAnimating()
    //
    //
    //            self.effectView.contentView.addSubview(self.activityIndicator)
    //            self.effectView.contentView.addSubview(self.strLabel)
    //            self.view.addSubview(self.effectView)
    //
    //        }
    //
    //    }
    //    func removeActivity() {
    //
    //        DispatchQueue.main.async {
    //
    //            self.activityIndicator.stopAnimating()
    //            self.effectView.removeFromSuperview()
    //            self.activityIndicator.removeFromSuperview()
    //            self.view.isUserInteractionEnabled = true
    //
    //        }
    //
    //    }
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
    func showAlert(title : String, message: String,permissionTag: Int){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in
                
                if permissionTag == 0{
                    permissions.3 = true
                }else{
                    permissions.4 = true
                }
                
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                
            }
            alert.addAction(OkAction)
            alert.addAction(cancelAction)
            
            alert.addAction(OkAction)
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func showAlertToSettingPage(title : String, message: String){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in
                guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString  ) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                }
                
            }
            
            alert.addAction(OkAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func showDisconnectAlert(title : String, message: String){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in
                
                //                self.performSegue(withIdentifier: "showRetailVertical", sender: self)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                //                self.performSegue(withIdentifier: "showRetailVertical", sender: self)
            }
            alert.addAction(OkAction)
            alert.addAction(cancelAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}



