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
var getCountry : String?
var getPostal: String?
var getDeliveryAddress : String?
var getCountryTimeZone: String?
var getDeviceId: String?
var userCountyFlag : UIImage?
var getCountryPostalCode: String?
var isFirstTimeUser : String?
var HeaderLogo: String?

//MARK: TO STORE COUNTRY IMAGE/POSTAL CODE ON APP CLOSED
let userDefaults = UserDefaults.standard
let defaultsToStoreDeviceId = UserDefaults.standard

class SplashController: UIViewController, CLLocationManagerDelegate {
    
    ///mark: property
    var getModelToGiveCountry: ModelToGiveCountry!
    var getModelToGiveCountryForPhoneCode : ModelToGiveCountryForPhoneCode!
    var getSplashViewModel : SplashViewModel!
    var getModelToGiveDeviceId: DeviceID!
    var getRetailViewModel : RetailSelectionViewModel!
    var getHomeControllerVM : HomeControllerViewModel!
    
    var timerTest : Timer?
    var timerCount = 2
    var count = 0
    
    var getLatitude: String?
    var getLongitude: String?
    var getTimeStamp: String?
    var getLocalityData = [String]()
    
    var new = [(String,String,String,Int)]()//title/logo/lapseTime/id
    //    var retailVerticalDetails  =  [(UIImage?,UIImage?,UIImage?, Bool,String)]()
    //    var retailVerticalDetails  = [(UIImage?,UIImage?,UIImage?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/ BOOL/ VALUE / STATUS
    var retailVerticalDetails  = [(String?,String?,String?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/ BOOL/ VALUE / STATUS
    
    var getCountryFlagData : Data?
    
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation!
    
    
    ///MARK: GET/POST REQUEST
    
    
    ///MARK: TO REGISTER UNIQUE DEVICE ID FOR DEVICE
    
    var mobRegisterRequest: MobileRegisterRequest = .get{
        
        didSet{
            
            switch mobRegisterRequest {
            case .get:
                
                guard let getLat = getLatitude, let getLong = getLongitude else {
                    showError(getError: "Problem in getting lat/long", getMessage: "")
                    return
                }
                
                ///MARK: USING LAT/LONG GET REQUEST TO GET COUNTRY NAME/COUNTRY POST CODE/COUNTRY ADDRESS---GOOGLE API
                
                self.getSplashViewModel.getCountryPostalCode(getLat: getLat, getLong: getLong, vc: self, completions: {
                    
                    guard let getCountryPostalCode = self.getSplashViewModel.getCountryPostalCode else{
                        return
                    }
                    
                    if let getResult = getCountryPostalCode.results[0]{
                        
                        var  getAddressComponent = getResult.address_components
                        
                        if getAddressComponent != nil{
                            
                            for j in getAddressComponent{
                                
                                //mark:for getting address number and first address
                                if let premise = j?.types{
                                    
                                    if premise.contains("political"){
                                        
                                        if premise.contains("country"){
                                            getCountry = j!.long_name ?? "not found"
                                        }
                                    }
                                }
                            }
                            
                            self.mobRegisterRequest = .post
                        }
                        
                    }else{
                        self.showError(getError: "Error!", getMessage: "problem in getting result in response")
                    }
                    
                })
                
                
                
            case .post:
                
                guard let getCountry = getCountry else {
                    showError(getError: "Error!", getMessage: "Problem in getting Country Code for getting phone code.")
                    return
                }
                
                getModelToGiveCountryForPhoneCode = ModelToGiveCountryForPhoneCode(getCountry: getCountry)
                
                ///MARK: PROCESS TO GET PHONE CODE BY GIVING COUNTRY NAME
                
                self.getSplashViewModel.getPhoneCodeDetails(postRequest: HelperClass.shared.urlFetchPhoneCode, sendDataModel: getModelToGiveCountryForPhoneCode, vc: self, completion: {_ in
                    
                    guard let getPhoneDetails = self.getSplashViewModel.getPhoneDetails else{
                        return
                    }
                    
                    print(getPhoneDetails.status.phone_code)
                    UIView.animate(withDuration: 1, animations: {
                        self.viewCustomMobRegister.alpha = 1
                        self.viewCustomMobRegister.donePressed = self
                        for i in self.viewCustomMobRegister.txtEdtGroup2{
                            i.delegate = self
                        }
                        
                        self.viewCustomMobRegister.txtEdtCountryCode.text = getPhoneDetails.status.phone_code
                    })
                })
                
                
            default:
                print("")
            }
        }
        
    }
    
    var splashChange: RequestType = .get{
        
        didSet{
            
            switch splashChange {
            case .get:
                ///MARK: PARALLE GET REQUEST TO GET COUNTRY TIME ZONE ID --- GOOGLE API
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
                ///MARK: PARALLEL POST REQUEST TO GET COUNTRY NAME/IMAGE AND POSTAL CODE- SAVED IN DB
                DispatchQueue.global(qos: .userInitiated).async() {
                    self.getHomeControllerVM.getCountryName(vc: self, completions: {
                        
                        guard let getCountryPickerDetails = self.getHomeControllerVM.getCountryPickerDetails else{
                            return
                        }
                        
                        
                        DispatchQueue.global(qos: .userInitiated).async() {
                            
                            HelperClass.shared.deleteRecord()
                            
                            for i in getCountryPickerDetails.status!.COUNTRY{
                                
                                let getCountryFlagUrl = URL(string: i?.Country_flag ?? "")!
                                
                                // Fetch Image Data
                                if let getCountryFlagData = try? Data(contentsOf: getCountryFlagUrl) {
                                    
                                    ///MARK: INSERTING TO LOCAL DB
                                    
                                    HelperClass.shared.insertDeviceDetails(countryImg: getCountryFlagData, countryName: i?.Country_Name ?? "not found", countryPostalFormat: i?.Postal_Code_Format ?? "")
                                    
                                }
                                
                            }
                            
                        }
                        
                    })
                }
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
                            
                            if isFirstTimeUser == "N"{
                                
                                self.performSegue(withIdentifier: "SecondTimeUser", sender: self)
                                
                            }else{
                                self.performSegue(withIdentifier: "showRetailVertical", sender: self)
                            }
                            
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
    
    ///MARK: GET/POST PROPERTY OBSERVER.
    var requestType : RequestType = .post{
        didSet{
            switch requestType{
            case .get:
                guard let getLat = getLatitude, let getLong = getLongitude else {
                    showError(getError: "Problem in getting lat/long", getMessage: "")
                    return
                }
                
                ///MARK: USING LAT/LONG GET REQUEST TO GET COUNTRY NAME/COUNTRY POST CODE/COUNTRY ADDRESS---GOOGLE API
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    self.getSplashViewModel.getCountryPostalCode(getLat: getLat, getLong: getLong, vc: self, completions: {
                        
                        guard let getCountryPostalCode = self.getSplashViewModel.getCountryPostalCode else{
                            return
                        }
                        
                        if let getResult = getCountryPostalCode.results[0]{
                            
                            var  getAddressComponent = getResult.address_components
                            
                            if getAddressComponent != nil{
                                
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
                            
                        }else{
                            self.showError(getError: "Error!", getMessage: "problem in getting result in response")
                        }
                        
                        DispatchQueue.global(qos: .userInitiated).async {
                            self.generateCurrentTimeStamp2()
                            self.requestType = .post //2
                        }
                    })
                }
                
                ///MARK: PARALLE GET REQUEST TO GET RETAIL DETAILS
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    //                    guard let getDeviceId = getDeviceId else {
                    //                        self.showError(getError: "Problem in getting Device Id", getMessage: "")
                    //                        return
                    //                    }
                    
                    self.getModelToGiveDeviceId = DeviceID(getDeviceId: "")
                    
                    self.getRetailViewModel.getRetailVerticalDetails(postRequest: HelperClass.shared.urlFetchVerticalDetails, sendDataModel: self.getModelToGiveDeviceId, vc: self, completion: {
                        
                        guard let getRetailDetails = self.getRetailViewModel.getRetailDetails.status.PERMISSION else{
                            return
                        }
                        self.retailVerticalDetails.removeAll()
                        
                        DispatchQueue.global(qos: .userInitiated).async() {
                            
                            for (index,element) in getRetailDetails.enumerated(){
                                
                                
                                if let getId = element.Id,let getStatus = element.status  {
                                    
                                    
                                    self.retailVerticalDetails.append((element.url_unselected,element.url_unselected, element.url_selected,false,element.val ?? "",getId,Int(getStatus)!)) //3
                                    
                                    
                                } else {
                                    self.showError(getError: "Error!", getMessage: "Problem in getting Retail Details from URL!")
                                }
                            }
                        }
                    })
                }
                
                
            case .post:
                
                guard  let getTimeStamp = getTimeStamp, let getCountry = getCountry else {
                    showError(getError: "Problem in getting Device Id/ Time Stamp", getMessage: "")
                    return
                }
                
                getModelToGiveCountry = ModelToGiveCountry(getCountry: getCountry, getTimeStamp: getTimeStamp, getDeviceId: "")
                DispatchQueue.main.async {
                    self.startTimer()
                }
                getSplashViewModel.getCompanyDetails(postRequest: HelperClass.shared.urlFetchCompanyDetails, sendDataModel: getModelToGiveCountry, vc: self, completion: { (message) -> Void in
                    
                    self.stopTimerTest()
                    getPostalCode = self.getSplashViewModel.getCompanyDetails
                    
                    ///MARK: GET COUNTRY FLAG
                    let userFlagUrl = URL(string: self.getSplashViewModel.getCompanyDetails.status.Country_flag ?? "https://www.smartkirana.ca/retailecos/assets/images/flag/flag-of-India.png")!
                    
                    // Fetch Image Data
                    if let data = try? Data(contentsOf: userFlagUrl) {
                        // Create Image and Update Image View
                        self.getCountryFlagData = data
                        userCountyFlag = UIImage(data: data)
                    }
                    
                    ///MARK: GET POSTAL FORMAT
                    if let getCountryPostal = self.getSplashViewModel.getCompanyDetails.status.Postal_Code_Format{
                        getCountryPostalCode = getCountryPostal
                    }
                    
                    
                    ///MARK: GET SPLASH DETAILS.
                    if let getSplashList = self.getSplashViewModel.getCompanyDetails.status.splash{
                        
                        for (index,element) in getSplashList.enumerated(){
                            if element.Id == 1{
                                HeaderLogo = element.Logo
                            }
                            self.new.append((element.Title ?? "", element.Logo ?? "", element.Lapse_Time ?? "3", element.Id ?? 0))
                        }
                        
                        isFirstTimeUser = self.getSplashViewModel.getCompanyDetails.status.First_Time_User
                        
                        self.splashChange = .post //4
                        self.splashChange = .get
                        
                    }else{
                        self.showError(getError: "Splash Details not found!", getMessage: "")
                    }
                    
                })
                
            }
        }
    }
    
    ///mark: outlet
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewCustomAlert: customAlerts!
    @IBOutlet weak var viewCustomMobRegister: CustomMobRegisterScreen!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialCofig()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //SecondTimeUser
        
        if isFirstTimeUser == "N"{
            
            
        }else{
            guard segue.identifier == "showRetailVertical" else{
                return
            }
            
            let getRetailController = segue.destination as! RetailSelectionController
            getRetailController.retailVerticalDetails = retailVerticalDetails
        }
        
        
    }
    
    
    ///mark: function
    func  initialCofig() {
        getHomeControllerVM = HomeControllerViewModel()
        getHomeControllerVM.showError = self
        
        
        getSplashViewModel = SplashViewModel()
        getSplashViewModel.showError = self
        
        getRetailViewModel = RetailSelectionViewModel()
        getRetailViewModel.showError = self
        
        viewCustomAlert.btnClick = self
        
        //        getDeviceId = UIDevice.current.identifierForVendor?.uuidString
        //        //        getDeviceId = UUID().uuidString
        //        print("DEVICE ID: \(getDeviceId)")
        getTimeStamp = generateCurrentTimeStamp()
        
        // Get Location Permission one time only
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Need to update location and get location data in locationManager object with delegate
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
        
        //        defaultsToStoreDeviceId.set("9941445471", forKey: "deviceId")
        getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
        print(getDeviceId)
        
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
    
    func startTimer () {
        guard timerTest == nil else { return }
        timerTest =  Timer.scheduledTimer(
            timeInterval: TimeInterval(1),
            target      : self,
            selector    : #selector(self.UpdateTimer),
            userInfo    : nil,
            repeats     : true)
    }
    func stopTimerTest() {
        timerTest?.invalidate()
        timerTest = nil
        timerCount = 2
    }
    @objc func UpdateTimer() {
        timerCount -= 1
        print(timerCount)
        if timerCount == -1{
            self.requestType = .post
        }
    }
    
    
    ///mark: get location information
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        currentLoc = locations.first
        
        if let getCurrentLoc = currentLoc{
            getLatitude = String(getCurrentLoc.coordinate.latitude)
            getLongitude = String(getCurrentLoc.coordinate.longitude)
            
            
            if let checkIsDevIdGenerated = getDeviceId{
                self.imgLogo.image = UIImage(named: "imgConfluence")
                self.lblTitle.text = "From"
                requestType = .get
            }else{
                mobRegisterRequest = .get
            }
            
            
            //            mobRegisterRequest = .get
            
            
            
            ///MARK: NEW MODIFICATION - 4-3-2021
            
            //            self.imgLogo.image = UIImage(named: "imgConfluence")
            //            self.lblTitle.text = "From"
            //            requestType = .get
            
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
        
        //       showDisconnectAlert(title: getError, message: getMessage)
        switch getError {
        case "Time Out":
            print("")
        default:
            showDisconnectAlert(title: getError, message: getMessage)
        }
        
    }
}

extension SplashController: retryRequest{
    func retryGet(url: String, vc: UIViewController) {
        print("retrying get request")
    }
    func retryPost(url: String, getModel: Data?, vc: UIViewController) {
        print("retrying post request")
    }
}

extension SplashController{
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

extension SplashController: UITextFieldDelegate,UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        selectedTxtField = textView.tag
        
        switch textView.tag {
        case 0:
            textView.resignFirstResponder()
            self.viewCustomMobRegister.viewCustomKeyboard.addSubview(self.viewCustomMobRegister.NUMBERPAD!)
        case 1:
            textView.resignFirstResponder()
            self.viewCustomMobRegister.viewCustomKeyboard.addSubview(self.viewCustomMobRegister.NUMBERPAD!)
        case 2:
            textView.resignFirstResponder()
            self.viewCustomMobRegister.viewCustomKeyboard.addSubview(self.viewCustomMobRegister.NUMBERPAD!)
            
        default :
            print("")
            
        }
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
}

extension SplashController: donePressed{
    func DonePressed() {
        
        var getFinalDeviceIdToSave : String?
        var isValidated = false
        
        switch selectedTxtField {
        case 0:
            var getPhoneId = self.viewCustomMobRegister.txtEdtCountryCode.text
        case 1:
            
            var getDeviceIdToSave = self.viewCustomMobRegister.lblMobileNumber.text
            var getPhoneId = self.viewCustomMobRegister.txtEdtCountryCode.text
            
            if let getFinalDeviceId = getDeviceIdToSave,let getFinalPhoneId = getPhoneId{
                if getFinalDeviceId.count < 10{
                    isValidated = false
                    showError(getError: "Error!", getMessage: "Please give valid mobile number")
                }else{
                    
                    isValidated = true
                    defaultsToStoreDeviceId.set(getFinalDeviceId,forKey: "phoneId")
                    defaultsToStoreDeviceId.set(getFinalPhoneId + getFinalDeviceId, forKey: "deviceId")
                    
                    ///MARK IF TRUE CHECK FOR PHONE COE
                    
                    var getPhoneId = self.viewCustomMobRegister.txtEdtCountryCode.text
                    
                    
                    if let getFinalPhoneId = getPhoneId{
                        if getFinalPhoneId.count < 1{
                            isValidated = false
                            showError(getError: "Error!", getMessage: "Please give valid mobile number")
                        }else{
                            isValidated = true
                        }
                    }
                    
                }
            }else{
                isValidated = false
                showError(getError: "Error!", getMessage: "problem in getting final Device dd or Phone Id")
            }
            
        default:
            print("")
        }
        
        if isValidated{
            UIView.animate(withDuration: 1, animations: {
                self.viewCustomMobRegister.alpha = 0
            })
            self.imgLogo.image = UIImage(named: "imgConfluence")
            self.lblTitle.text = "From"
            requestType = .get
        }else{
            showError(getError: "Error!", getMessage: "problem in starting splash screen")
        }
        
    }
}



