//
//  HomeScreenController.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-03-10.
//

import UIKit
import SDWebImage


var isAddressEditDetailChanged = true
var getUpdateHomeDetails = [getUpdateToHomeDetails]()
class HomeScreenController: UIViewController {
    ///MARK: OUTLET
    
    ///mark: outlet
    @IBOutlet weak var selectRetailTV: UITableView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnCountries: UIButton!
    @IBOutlet weak var lblTimeStamp: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewTimeStamp: UIView!
    @IBOutlet weak var imgCountry: UIImageView!
    @IBOutlet weak var imgHome: UIImageView!
    @IBOutlet weak var customAddressEdit: CustomAddressEdit!
    @IBOutlet weak var viewCustomAlert: customAlerts!
    @IBOutlet weak var imgHeaderLogo: UIImageView!
    
    @IBOutlet weak var imgTimer: UIImageView!
    @IBOutlet weak var btnTimer: UIButton!
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var btnCart: UIButton!
    
    
    
    
    
    ///mark: property
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    var getCurrentTime = Timer()
    
    var getCountryPickerRow: Int?
    var getFinalShoppingTypeId: Int?
    var startIndex = 0
    
    var getInitialFlagDetails : Bool?
    var isRetailsChanged = false
    var isShowingPicker: Bool = false
    var isHomeScreenDetailChanged = false
    var isShowingAddressEdit = false
    
    
    
    
    var getLatitude: Double?
    var getLongitude: Double?
    
    var getTimeZone : String?
    var getDateTime : String?
    var getLocalityData = [String]()
    var getPostalCodeFormats = [String]()
    
    
    var getPostalCodeFormat = [Character]()
    var getFinalPostalCode = [Character]()
    
    //    var retailVerticalDetails : [(UIImage?,UIImage?,UIImage?, Bool,String)]?
    //    var retailVerticalDetails  : [(UIImage?,UIImage?,UIImage?, Bool,String,Int,Int)]?
    var retailVerticalDetails  : [(String?,String?,String?, Bool,String,Int,Int)]?
    
    
    var getRequestType = (false,false,false,false)//requestCountries/reqCountryAddress/reqCountryTime/requestCountryPhoneCode
    var getCountryFlagName = [(UIImage?,String,String)]()//countryImg/countryName/countryPostal
    var getTrackCountryChange : (Data?,String?)
    var homeSelectionDetails = [(Int,[(String?,Int,String,String,Int)],Int,String?,String)] () {
        didSet{
            isHomeScreenDetailChanged = true
            
            DispatchQueue.main.async {
                self.imgHome.image = UIImage(named: "imgSave")
            }
            
        }
    }//MENU ID/SUB_MENU(IMAGE/INNER ID/VALUE/NAME/STATUS)/MENU ENABLE/ MENU ACTION/IS ARROW
    var fetchVerticalDetails  =  [(String?,String?,String?, Bool,String,Int,Int)]()//UNSELECTED IMAGE/UNSELECTED IMAGE/SELECTED IMAGE/FALSE/RETAIL NAME/ID/STATUS
    
    var getHomeListM: DeviceID!
    var getModelToUpdateHomeDetails: ModelToUpdateHomeDetails!
    var getModelToGiveDevicePostal: ModelToGiveDevicePostal!
    var getModelToUpdateAddress : ModelToUpdateAddress!
    var getHomeControllerVM : HomeControllerViewModel!
    //    var getUpdateHomeDetails = [getUpdateToHomeDetails]()
    var getRequestFetchVerticalOfType: ModelToRequestRetailDetailsOfType!
    var getModelToGiveCountryForPhoneCode : ModelToGiveCountryForPhoneCode!
    var getSplashViewModel : SplashViewModel!
    var countryNameModel = [CountryInfoModel]()
    
    var alphabeticList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var numericList = ["0","1","2","3","4","5","6","7","8","9"]
    
    
    //    var getPostalCode: String?
    let minRowHeight: CGFloat = 50.0
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    ///MARK: REQUEST TYPE FOR GET REQUEST / POST REQUEST
    
    var requestType : RequestType = .post{
        didSet{
            switch requestType{
            case .get:
                
                self.showActivity(title: "Loading...")
                
                if getRequestType.0{
                    
                    // dispatch back to the main thread to update UI
                    DispatchQueue.main.async() {
                        
                        self.countryNameModel = HelperClass.shared.retrieveData(getCountryInfo: &self.countryNameModel)
                        
                        self.getPostalCodeFormats.removeAll()
                        for (index,element) in self.countryNameModel.enumerated(){
                            var getPostalCode : String = ""
                            if let getPostalFormat = element.countryPostalCodeFormat{
                                for (index,elemen) in getPostalFormat.enumerated(){
                                    if elemen == "N"{
                                        getPostalCode += "0"
                                    }else if elemen == "S"{
                                        getPostalCode += " "
                                    }else if elemen == "A"{
                                        getPostalCode += "A"
                                    }
                                }
                                self.getPostalCodeFormats.append(getPostalCode)
                            }else{
                                self.showError(getError: "Error!", getMessage: "Problem in getting Postal Formats")
                            }
                            
                        }
                        
                        self.pickerView.delegate = self
                        self.pickerView.dataSource = self
                        self.pickerView.reloadAllComponents()
                        
                        
                        
                        ///TO CHECK ADDRESS FROM OUR SERVER ON LOAD WITH INITIAL POSTAL CODE.
                        
                        
                        
                        self.getFinalPostalCode.removeAll()
                        self.getFinalPostalCode = Array(toShowPostalOverSwitchng)
                        
                        if self.getPostalCodeFormats.count != 0{
                            let contains = self.getPostalCodeFormats.contains(where: {$0 == String(self.getFinalPostalCode)})
                            
                            if contains {
                                self.showHideCustomAlert(isShowAlert: true, getTitle: "Information!", getMessage: "please give valid Postal code.", isError: false)
                            }else{
                                self.getRequestType.0 = false
                                self.getRequestType.1 = true
                                self.getRequestType.2 = false
                                self.getRequestType.3 = false
                                self.removeActivity()
                                self.requestType = .get
                            }
                            
                        }else{
                            self.showHideCustomAlert(isShowAlert: true, getTitle: "Error!", getMessage: "postal formats not found for match", isError: false)
                        }
                        
                    }
                    
                }else{
                    if getRequestType.1{
                        
                        
                        ///MARK: GETTING COUNTRY ADDRESS BY PROVIDING POSTAL CODE - (GOOGLE API)
                        
                        getHomeControllerVM.getCountryAddress(getPostalCode: String(self.getFinalPostalCode), vc: self, completions:  {
                            
                            guard let getCountryPickerDetails = self.getHomeControllerVM.getCountryAddress else{
                                return
                            }
                            
                            if self.getHomeControllerVM.getCountryAddress.status == "OK"{
                                
                                for i in self.getHomeControllerVM.getCountryAddress.results{
                                    
                                    self.homeSelectionDetails[4].1[0].3 = i?.formatted_address ?? "NOT FOUND"
                                    self.homeSelectionDetails[4].1[0].2 = i?.formatted_address ?? "NOT FOUND"
                                    toShowDeliverAddrssOverSwitchng = i?.formatted_address ?? "NOT FOUND"
                                    
                                    self.getLongitude = i?.geometry?.location?.lng
                                    self.getLatitude = i?.geometry?.location?.lat
                                    
                                }
                                
                                ///MARK: TO GET DETAILED ADDRESS USING FIRST API CALL POVIDING LAT/LONG
                                
                                if let getFinalLat = self.getLatitude ,let getFinalLong = self.getLongitude {
                                    
                                    self.getHomeControllerVM.getCountryPostalCode(getLat: String(getFinalLat), getLong: String(getFinalLong), vc: self, completions: {
                                        
                                        guard let getCountryPostalCode = self.getHomeControllerVM.getCountryPostalCode else{
                                            return
                                        }
                                        
                                        if let getResult = getCountryPostalCode.results[0]{
                                            
                                            var  getAddressComponent = getResult.address_components
                                            
                                            if getAddressComponent != nil{
                                                
                                                
                                                getNo = ""
                                                self.customAddressEdit.lblFirstName.text = ""
                                                self.customAddressEdit.lblLastName.text = ""
                                                self.customAddressEdit.lblAddress1.text = ""
                                                self.customAddressEdit.lblAddress2.text = ""
                                                self.customAddressEdit.lblLocality.text = ""
                                                self.customAddressEdit.lblCity.text = ""
                                                self.customAddressEdit.lblState.text = ""
                                                self.customAddressEdit.lblPostalCode.text = ""
                                                self.customAddressEdit.receivedDeviceId = ""
                                                self.customAddressEdit.lblMnumber.text = ""
                                                
                                                
                                                for i in  self.customAddressEdit.btnGroup{
                                                    i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
                                                }
                                                self.getLocalityData.removeAll()
                                                
                                                for j in getAddressComponent{
                                                    
                                                    //mark:for getting address number and first address
                                                    if let premise = j?.types{
                                                        if premise.contains("premise"){
                                                            getNo = j!.long_name ?? "NOT FOUND"
                                                        }else if premise.contains("route"){
                                                            
                                                            getAddress1 = j!.long_name ?? "NOT FOUND"
                                                            
                                                            if let getFinalno = getNo, let getFinalAddress = getAddress1{
                                                                self.customAddressEdit.lblAddress1.text = getFinalno.uppercased()  + getFinalAddress.uppercased()
                                                            }else{
                                                                self.customAddressEdit.lblAddress1.text = getAddress1?.uppercased()
                                                            }
                                                            
                                                            
                                                        }else if premise.contains("postal_code"){
                                                            //                                                            getPostal = j!.long_name ?? "not found"
                                                            self.customAddressEdit.lblPostalCode.text = j!.long_name?.uppercased() ?? "NOT FOUND"
                                                        }else if premise.contains("political"){
                                                            
                                                            if premise.contains("locality"){
                                                                self.customAddressEdit.lblCity.text = j!.long_name?.uppercased() ?? "NOT FOUND"
                                                            }else if premise.contains("sublocality"){
                                                                
                                                                if self.getLocalityData.contains(j!.long_name ?? "NOT FOUND"){
                                                                    
                                                                }else{
                                                                    self.getLocalityData.append(j!.long_name?.uppercased() ?? "NOT FOUND")
                                                                    
                                                                    if self.getLocalityData.count == 1{
                                                                        self.customAddressEdit.lblAddress2.text = self.getLocalityData[0]
                                                                        self.customAddressEdit.lblLocality.text = "NOT FOUND"
                                                                    }else if self.getLocalityData.count > 1{
                                                                        self.customAddressEdit.lblAddress2.text = self.getLocalityData[0]
                                                                        self.customAddressEdit.lblLocality.text = self.getLocalityData[1]
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }else  if premise.contains("country"){
                                                                getCountry = j!.long_name ?? "NOT FOUND"
                                                                print("country name from server: \(j?.long_name)")
                                                            }else if premise.contains("administrative_area_level_1"){
                                                                self.customAddressEdit.lblState.text = j!.long_name?.uppercased() ?? "NOT FOUND"
                                                            }else{
                                                                print(j?.long_name)
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                                self.customAddressEdit.storedDeviceId = defaultsToStoreDeviceId.string(forKey: "phoneId")
                                            }
                                            
                                        }else{
                                            self.showError(getError: "Error!", getMessage: "problem in getting result in response")
                                        }
                                        
                                        
                                        ///MARK: GETTING COUNTRY PHONE CODE FOR CORRESPONDING CHOOSEN COUNTRY
                                        
                                        self.getRequestType.0 = false
                                        self.getRequestType.1 = false
                                        self.getRequestType.2 = false
                                        self.getRequestType.3 = true
                                        
                                        self.requestType = .get
                                        
                                    })
                                    
                                }
                                self.homeSelectionDetails[0].1[0].3 = String(self.getFinalPostalCode)
                                self.homeSelectionDetails[0].1[0].2 = String(self.getFinalPostalCode)
                                toShowPostalOverSwitchng = String(self.getFinalPostalCode)
                                self.getFinalPostalCode = Array(String(self.getFinalPostalCode)) ///MARK: NEW CHANGES -3-3-2021
                                
                                self.selectRetailTV.reloadData()
                                
                                self.pickerView.alpha = 0
                                self.toolBar.alpha = 0
                                self.isShowingPicker = false
                                self.showHideCustomAlert(isShowAlert: false, getTitle: "", getMessage: "", isError: false)
                                self.view.layoutIfNeeded()
                                
                                
                                self.getRequestType.0 = false
                                self.getRequestType.1 = false
                                self.getRequestType.2 = true
                                self.getRequestType.3 = false
                                self.removeActivity()
                                self.requestType = .get
                                
                                
                                self.requestType = .post
                                
                            }else{
                                //                                self.showError(getError: "Error!", getMessage: "please give valid Postal code.")
                                self.showHideCustomAlert(isShowAlert: true, getTitle: "Information!", getMessage: "please give valid Postal code.", isError: false)
                            }
                            
                        })
                        
                    }else{
                        if getRequestType.2{
                            
                            if let getLongitude = self.getLongitude, let getLatitude = self.getLatitude{
                                
                                DispatchQueue.global(qos: .userInitiated).async() {
                                    
                                    
                                    self.getHomeControllerVM.getCountryTimeZone(getLat: String(getLatitude), getLong: String(getLongitude), getTimeStamp: "00", vc: self, completions:  {
                                        
                                        guard let getCountryTimeZone = self.getHomeControllerVM.getCountryTimeZone else{
                                            return
                                        }
                                        
                                        if self.getHomeControllerVM.getCountryTimeZone.status == "OK"{
                                            self.removeActivity()
                                            if let getTimeZone = self.getHomeControllerVM.getCountryTimeZone.timeZoneId{
                                                self.getTimeZone = getTimeZone
                                                self.lblTimeStamp.alpha = 1
                                            }
                                            
                                        }else{
                                            self.showError(getError: "Error!", getMessage: "problem in getting time zone for country.")
                                        }
                                        
                                        
                                    })
                                    
                                }
                                
                                
                            }else{
                                self.showError(getError: "Error!", getMessage: "Problem in getting lat/long from server!")
                            }
                            
                        }else{
                            if getRequestType.3{
                                
                                
                                guard let getCountry = getCountry else {
                                    showError(getError: "Error!", getMessage: "Problem in getting Country Code for getting phone code.")
                                    return
                                }
                                
                                print("country name send to server: \(getCountry)")
                                
                                getModelToGiveCountryForPhoneCode = ModelToGiveCountryForPhoneCode(getCountry: getCountry)
                                
                                ///MARK: PROCESS TO GET PHONE CODE BY GIVING COUNTRY NAME
                                
                                DispatchQueue.global(qos: .userInitiated).async() {
                                    
                                    self.getSplashViewModel.getPhoneCodeDetails(postRequest: HelperClass.shared.urlFetchPhoneCode, sendDataModel: self.getModelToGiveCountryForPhoneCode, vc: self, completion: {_ in
                                        self.removeActivity()
                                        guard let getPhoneDetails = self.getSplashViewModel.getPhoneDetails else{
                                            return
                                        }
                                        
                                        print("phone code got from server: \(getPhoneDetails.status.phone_code)")
                                        self.customAddressEdit.lblCcode.text = getPhoneDetails.status.phone_code
                                        
                                    })
                                    
                                }
                            }
                        }
                    }
                }
                
            case .post:
                self.showActivity(title: "Loading..")
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                    
                    guard let getDeviceId = getDeviceId else {
                        self.showError(getError: "Problem in getting Device Id in HomeSelection", getMessage: "")
                        return
                    }
                    
                    if self.homeSelectionDetails[0].1[0].3 != ""{
                        
                        self.getModelToGiveDevicePostal = ModelToGiveDevicePostal(getDeviceId: getDeviceId, getPostalCode: self.homeSelectionDetails[0].1[0].3)
                        
                        DispatchQueue.global(qos: .userInitiated).async() {
                            
                            self.getHomeControllerVM.getAddressDetails(postRequest: HelperClass.shared.addressFetch, sendDataModel: self.getModelToGiveDevicePostal, vc: self, completion: { [self] (message) -> Void in
                                
                                self.removeActivity()
                                
                                if message == 1{
                                    
                                    
                                    if let getAddressDetails = getHomeControllerVM.getAddressDetails{
                                        
                                        if let getFetchedAddress = getAddressDetails.status.Deviceaddress{
                                            
                                            
                                            self.customAddressEdit.lblFirstName.text = ""
                                            self.customAddressEdit.lblLastName.text = ""
                                            self.customAddressEdit.lblAddress1.text = ""
                                            self.customAddressEdit.lblAddress2.text = ""
                                            self.customAddressEdit.lblLocality.text = ""
                                            self.customAddressEdit.lblCity.text = ""
                                            self.customAddressEdit.lblState.text = ""
                                            self.customAddressEdit.lblPostalCode.text = ""
                                            
                                            self.customAddressEdit.lblMnumber.text =  ""
                                            self.customAddressEdit.receivedDeviceId = ""
                                            
                                            for i in  self.customAddressEdit.btnGroup{
                                                i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
                                            }
                                            
                                            
                                            self.customAddressEdit.lblFirstName.text = getFetchedAddress[0].FIRST_NAME
                                            self.customAddressEdit.lblLastName.text = getFetchedAddress[0].LAST_NAME
                                            self.customAddressEdit.lblAddress1.text = getFetchedAddress[0].ADDRESS_1
                                            self.customAddressEdit.lblAddress2.text = getFetchedAddress[0].ADDRESS_2
                                            self.customAddressEdit.lblLocality.text = getFetchedAddress[0].LOCALITY
                                            self.customAddressEdit.lblCity.text = getFetchedAddress[0].CITY
                                            self.customAddressEdit.lblState.text = getFetchedAddress[0].STATE
                                            self.customAddressEdit.lblPostalCode.text = getFetchedAddress[0].POSTAL_CODE
                                            
                                            self.customAddressEdit.lblMnumber.text = getFetchedAddress[0].MOBILE_NUMBER
                                            self.customAddressEdit.receivedDeviceId = getFetchedAddress[0].MOBILE_NUMBER
                                            //
                                            
                                            self.customAddressEdit.storedDeviceId = defaultsToStoreDeviceId.string(forKey: "phoneId")
                                            
                                            
                                            ///MARK: CHANGE TICK MARK FOR SPECIFIED ADDRESS IN CUSTOM ADDRESS EDIT SCREEN
                                            
                                            for i in customAddressEdit.btnGroup{
                                                i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
                                            }
                                            
                                            getFetchedAddress[0].ADDRESS_TYPE == "1" ? customAddressEdit.btnHome.setImage(UIImage(named: "imgAddressSelect"), for: .normal) : getFetchedAddress[0].ADDRESS_TYPE == "2" ? customAddressEdit.btnOffice.setImage(UIImage(named: "imgAddressSelect"), for: .normal) : getFetchedAddress[0].ADDRESS_TYPE == "3" ? customAddressEdit.btnOther.setImage(UIImage(named: "imgAddressSelect"), for: .normal) : print("")
                                            
                                            switch getFetchedAddress[0].ADDRESS_TYPE{
                                            case "1":
                                                homeSelectionDetails[4].1[0].3 = "Home Address"
                                                homeSelectionDetails[4].1[0].2 = "Home Address"
                                                homeSelectionDetails[4].1[0].1 = 1
                                                selectedId = 1
                                                selectRetailTV.reloadData()
                                            case "2":
                                                homeSelectionDetails[4].1[0].3 = "Office Address"
                                                homeSelectionDetails[4].1[0].2 = "Office Address"
                                                homeSelectionDetails[4].1[0].1 = 2
                                                selectedId = 2
                                                selectRetailTV.reloadData()
                                            case "3":
                                                homeSelectionDetails[4].1[0].3 = "Other Address"
                                                homeSelectionDetails[4].1[0].2 = "Other Address"
                                                homeSelectionDetails[4].1[0].1 = 3  
                                                selectedId = 3
                                                selectRetailTV.reloadData()
                                            default:
                                                print("")
                                            }
                                            
                                            //                                        })
                                        }else{
                                            showError(getError: "Error!", getMessage: "No value for Address found.")
                                        }
                                        
                                        
                                    }
                                }else{
                                    print("no address found")
                                    
                                }
                                
                            })
                        }
                    }else{
                        self.showError(getError: "Error!", getMessage: "problem in getting postal code to fetch address")
                    }
                    
                }
            }
        }
    }
    var screenType: ScreenType = .HomeScreen{
        didSet {
            switch screenType {
            case .HomeScreen:
                print("")
            case .AddressEdit:
                print("")
            }
        }
    }
    
    
    ///MARK: PICKER VIEW TYPE COUNTRY PICKER / POSTAL PICKER
    
    var pickerViewType : PickerViewTypee = .CountryPicker{
        didSet{
            switch pickerViewType{
            case .CountryPicker:
                isShowingPicker = true
                self.showPicker(pickerAlpha: 1, toolbarAlpha: 1)
                
            case .PostalCodePicker:
                isShowingPicker = true
                self.showPicker(pickerAlpha: 1, toolbarAlpha: 1)
                
            }
            
        }
    }
    
    
    
    
    ///MARK: ACTION
    
    @IBAction func btnLogin(_ sender: UIButton) {
    }
    @IBAction func btnHome(_ sender: UIButton) {
        
        
        if isShowingAddressEdit{
            print("it is address edit screen")
            
            if isAddressEditDetailChanged{
                
                ///MARK: UPDATING DETAILS TO THE SERVER
                
                getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                
                
                guard let getDeviceId = getDeviceId else {
                    self.showError(getError: "Problem in getting Device Id in HomeSelection", getMessage: "")
                    return
                }
                
                if let getSelectedId = selectedId{
                    
                    getModelToUpdateAddress = ModelToUpdateAddress(getDeviceId: getDeviceId, getFirsName: self.customAddressEdit.lblFirstName.text!, getLastName: self.customAddressEdit.lblLastName.text!, getAddress1: self.customAddressEdit.lblAddress1.text!, getAddress2: self.customAddressEdit.lblAddress2.text!, getLocality: self.customAddressEdit.lblLocality.text!, getCity: self.customAddressEdit.lblCity.text!, getState: self.customAddressEdit.lblState.text!, getPostalCode: self.customAddressEdit.lblPostalCode.text!, getAddressType: String(getSelectedId), getAreaCode: "", getCountryCode: self.customAddressEdit.lblCcode.text!, getMobileNumber: self.customAddressEdit.lblMnumber.text!)
                    
                    
                    DispatchQueue.global(qos: .userInitiated).async() {
                        
                        self.getHomeControllerVM.postAddressEditDetails(postRequest: HelperClass.shared.addressUpdate, sendDataModel: self.getModelToUpdateAddress, vc: self, completion: { (message) -> Void in
                            
                            
                            if message == 1{
                                
                                self.showToas(message: "Address Updated Successfully..", seconds: 1.5)
                                
                                
                                UIView.animate(withDuration: 1, animations: { [self] in
                                    
                                    self.customAddressEdit.alpha = 0
                                    self.isShowingAddressEdit = false
                                    isAddressEditDetailChanged = true
                                    
                                    self.btnLogin.isUserInteractionEnabled = true
                                    self.btnHome.isUserInteractionEnabled = true
                                    self.btnCountries.isUserInteractionEnabled = true
                                    
                                    if let getSelectedId = selectedId{
                                        if getSelectedId == 1{
                                            self.homeSelectionDetails[4].1[0].3 = "Home Address"
                                            homeSelectionDetails[4].1[0].2 = self.homeSelectionDetails[4].1[0].3
                                            homeSelectionDetails[4].1[0].1 = 1
                                            toShowDeliverAddrssOverSwitchng = "Home Address"
                                            self.selectRetailTV.reloadData()
                                        }else if getSelectedId == 2{
                                            self.homeSelectionDetails[4].1[0].3 = "Office Address"
                                            homeSelectionDetails[4].1[0].2 = self.homeSelectionDetails[4].1[0].3
                                            homeSelectionDetails[4].1[0].1 = 2
                                            toShowDeliverAddrssOverSwitchng = "Office Address"
                                            self.selectRetailTV.reloadData()
                                        }else{
                                            self.homeSelectionDetails[4].1[0].3 = "Other Address"
                                            homeSelectionDetails[4].1[0].2 = self.homeSelectionDetails[4].1[0].3
                                            homeSelectionDetails[4].1[0].1 = 3
                                            toShowDeliverAddrssOverSwitchng = "Other Address"
                                            self.selectRetailTV.reloadData()
                                        }
                                    }
                                    
                                })
                            }else{
                                self.showError(getError: "Error!", getMessage: "Failed To Update.")
                            }
                            
                            
                        })
                    }
                }else{
                    showHideCustomAlert(isShowAlert: true, getTitle: "Error!", getMessage: "Please Select Address Type.", isError: false)
                }
            }
        }else{
            
            print("it is home screen")
            if isHomeScreenDetailChanged{
                
                getUpdateHomeDetails.removeAll()
                
                for i in homeSelectionDetails{
                    
                    for (index,element) in i.1.enumerated(){
                        if element.4 == 1{
                            getUpdateHomeDetails.append(getUpdateToHomeDetails(getMenuId: i.0, getMenuEnable: i.2, getValue: element.2, getInnerId: element.1))
                        }
                    }
                }
                
                updateHomeControllerDetails()
                
            }else{
                
            }
        }
        
    }
    @IBAction func btnCountries(_ sender: UIButton) {
        if isShowingPicker{
            
        }else{
            pickerViewType = .CountryPicker
        }
    }
    
    
    ///MARK: VIEWS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    override func viewDidAppear(_ animated: Bool) {
        //IMPLEMENT CODE
        //        initialConfig()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "showFetchRetail" else{
            return
        }
        
        let getFetchRetailDetail = segue.destination as! FetchRetailController
        getFetchRetailDetail.fetchVerticalDetails = fetchVerticalDetails
        
    }
    
    
    ///MARK: FUNCTIONS
    func initialConfig() {
        imgHeaderLogo.sd_setImage(with: URL(string: HeaderLogo ?? ""))
        viewCustomAlert.btnClick = self
        getHomeControllerVM = HomeControllerViewModel()
        getHomeControllerVM.showError = self
        getSplashViewModel = SplashViewModel()
        getSplashViewModel.showError = self
        
        
        ///MARK: SETTING UP CUSTOM ADDRESS EDIT VIEW LABEL WITH INITIAL ADDRESS.
        
        self.customAddressEdit.lblAddress1.text = getFinalAddress1?.uppercased()
        self.customAddressEdit.lblAddress2.text = getAddress2?.uppercased()
        self.customAddressEdit.lblLocality.text = getLocality?.uppercased()
        self.customAddressEdit.lblCity.text = getCity?.uppercased()
        self.customAddressEdit.lblState.text = getState?.uppercased()
        self.customAddressEdit.lblPostalCode.text = getPostalCodee?.uppercased()
        
        
        ///MARK: GET TIME ZONE.
        if let getIntTimeZone = getCountryTimeZone{
            getTimeZone = getIntTimeZone
        }
        
        getCurrentTime = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(generateCurrentTimeStamp), userInfo: nil, repeats: true)
        
        
        ///MARK: REGISTERING TABLE VIEW
        
        selectRetailTV?.register(HomeSelectionCell.nib, forCellReuseIdentifier: HomeSelectionCell.identifier)
        
        
        ///MARK: SETTING UP INITIAL COUNTRY FLAG
        
        if let getCountryFlag = userCountyFlag, let postalCodeFormat = getCountryPostalCode{
            
            self.getInitialFlagDetails = userDefaults.object(forKey: "isCountryChanged") as? Bool
            
            if let getIntialFlag = getInitialFlagDetails{
                if getIntialFlag{
                    if let getInitialFlagImage = userDefaults.data(forKey: "userCountryFlag"),let getInitialFlagPostalFormat = userDefaults.string(forKey: "userCountryPostalFormat"){
                        imgCountry.image = UIImage(data: getInitialFlagImage)
                        self.getPostalCodeFormat = Array(getInitialFlagPostalFormat)
                    }
                    
                }else{
                    imgCountry.image = getCountryFlag
                    self.getPostalCodeFormat = Array(postalCodeFormat)
                }
            }else{
                imgCountry.image = getCountryFlag
                self.getPostalCodeFormat = Array(postalCodeFormat)
            }
            
            // imgCountry.image = getCountryFlag
            // self.getPostalCodeFormat = Array(postalCodeFormat)
            self.getFinalPostalCode.removeAll()
            for (index,element) in self.getPostalCodeFormat.enumerated(){
                
                if element == "N"{
                    self.getFinalPostalCode.append("0")
                }else if element == "S"{
                    self.getFinalPostalCode.append(" ")
                }else if element == "A"{
                    self.getFinalPostalCode.append("A")
                }
            }
        }else{
            self.showError(getError: "Error!", getMessage: "Problem in getting Country Flag or Postal Code Format!")
        }
        
        ///MARK: INITIALLY HIDES PICKER
        showPicker(pickerAlpha: 0, toolbarAlpha: 0)
        
        
        if homeSelectionDetails[0].1[0].3 != ""{
            
            if let getIntialFlag = getInitialFlagDetails{
                if getIntialFlag{
                    for i in 0..<self.retailVerticalDetails!.count{
                        if let getRetailDetails = self.retailVerticalDetails{
                            if getRetailDetails[i].3 {
                                self.lblTimeStamp.alpha = 0
                                homeSelectionDetails[0].1[0].3 = ""
                                homeSelectionDetails[0].1[0].2 = ""
                                //                                toShowPostalOverSwitchng = ""
                                homeSelectionDetails[4].1[0].3 = ""
                                homeSelectionDetails[4].1[0].2 = ""
                                toShowDeliverAddrssOverSwitchng = ""
                                homeSelectionDetails[2].1[0].0 = getRetailDetails[i].1
                                homeSelectionDetails[2].1[0].3 = getRetailDetails[i].4
                                homeSelectionDetails[2].1[0].2 = getRetailDetails[i].4
                                toShowLastlySelectedRetail = getRetailDetails[i].4
                                //                              toShowLastlySelectedRetailImg = getRetailDetails[i].1 ?? UIImage(named: "imgError")!
                                //sd_setImage(with: URL(string: filterData[indexPath.row].IMAGE_URL ?? ""))
                                
                                
                            }
                        }else{
                            showError(getError: "Error!", getMessage: "Problem in getting Retails in Home Selection")
                        }
                    }
                }
            }else{
                //                for i in 0..<12{
                if let getRetailDetails = self.retailVerticalDetails{
                    
                    for i in 0..<getRetailDetails.count{
                        if getRetailDetails[i].3 {
                            homeSelectionDetails[2].1[0].0 = getRetailDetails[i].1
                            homeSelectionDetails[2].1[0].3 = getRetailDetails[i].4
                            homeSelectionDetails[2].1[0].2 = getRetailDetails[i].4
                            toShowLastlySelectedRetail = getRetailDetails[i].4
                            //                            toShowLastlySelectedRetailImg = getRetailDetails[i].1
                        }
                    }
                    
                }else{
                    showError(getError: "Error!", getMessage: "Problem in getting Retails in Home Selection")
                }
                //                }
            }
            
            
            
            selectRetailTV.delegate = self
            selectRetailTV.dataSource = self
            selectRetailTV.reloadData()
            
            
            
        }else{
            showError(getError: "Error!", getMessage: "Problem in getting Home Selection Details")
        }
        
        getRequestType.0 = true
        getRequestType.1 = false
        getRequestType.2 = false
        getRequestType.3 = false
        requestType = .get
        
    }
    func showPicker(pickerAlpha: CGFloat,toolbarAlpha: CGFloat) {
        pickerView.alpha = pickerAlpha
        pickerView.contentMode = .center
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barTintColor = UIColor.darkGray
        toolBar.alpha = toolbarAlpha
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonTapped))
        let attributes: [NSAttributedStringKey : Any] = [ .font: UIFont.boldSystemFont(ofSize: 16) ]
        doneButton.setTitleTextAttributes(attributes, for: .normal)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(self.onCancelButtonTapped))
        doneButton.tintColor = UIColor.white
        cancelButton.tintColor = UIColor.white
        toolBar.setItems([cancelButton,flexSpace,doneButton], animated: false)
        self.view.addSubview(toolBar)
        toolBar.bottomAnchor.constraint(equalTo: pickerView.topAnchor, constant: 0).isActive = true
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.reloadAllComponents()
        
        
        switch self.pickerViewType{
        
        case .CountryPicker:
            print("")
        case .PostalCodePicker:
            
            self.getFinalPostalCode.removeAll()
            for (index,element) in self.getPostalCodeFormat.enumerated(){
                
                if element == "N"{
                    self.getFinalPostalCode.append("0")
                }else if element == "S"{
                    self.getFinalPostalCode.append(" ")
                }else if element == "A"{
                    self.getFinalPostalCode.append("A")
                }
            }
            
            for (index,element) in getPostalCodeFormat.enumerated(){
                pickerView.selectRow(0, inComponent: index, animated: true)
            }
        }
    }
    func switchHomeDetails(getIndex: Int){
        if startIndex == homeSelectionDetails[getIndex].1.count{
            
            startIndex = 0
            
        }else{
            
            startIndex += 1
        }
    }
    func getRetailVerticalsOfType() {
        
        DispatchQueue.global(qos: .userInitiated).async() {
            self.showActivity(title: "Loading...")
            getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
            
            guard let getDeviceId = getDeviceId else {
                self.showError(getError: "Error!", getMessage: "Problem in getting Device Id in HomeSelection")
                return
            }
            
            
            self.getRequestFetchVerticalOfType = ModelToRequestRetailDetailsOfType(getDeviceId: "",getType: self.getFinalShoppingTypeId ?? 1)
            
            
            self.getHomeControllerVM.getFetchVerticalDetails(postRequest: HelperClass.shared.urlFetchRetailVerticalOfType, sendDataModel: self.getRequestFetchVerticalOfType, vc: self, completion: {
                
                guard let getRetailDetails = self.getHomeControllerVM.getFetchRetailOfType.status?.Vertical else{
                    return
                }
                
                self.fetchVerticalDetails.removeAll()
                
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    for (index,element) in getRetailDetails.enumerated(){
                        
                        
                        if let getId = element.Id, let getValue = element.val, let getStatus = element.status {
                            
                            self.fetchVerticalDetails.append((element.url_unselected,element.url_unselected,element.url_selected,false,getValue,getId,getStatus)) //3
                            print(self.fetchVerticalDetails[0].5)
                            
                        } else {
                            self.showError(getError: "Error!", getMessage: "Problem in getting Retail Details from URL!")
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.removeActivity()
                        self.performSegue(withIdentifier: "showFetchRetail", sender: self)
                        
                    }
                    
                }
            })
            
        }
    }
    
    func updateHomeControllerDetails() {
        
        DispatchQueue.global(qos: .userInitiated).async() {
            self.showActivity(title: "Updating...")
            getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
            
            guard let getDeviceId = getDeviceId else {
                self.showError(getError: "Error!", getMessage: "Problem in getting Device Id in HomeSelection")
                return
            }
            
            self.getModelToUpdateHomeDetails = ModelToUpdateHomeDetails(getDevice: getDeviceId, getMenu: getUpdateHomeDetails)
            
            
            self.getHomeControllerVM.postHomeControllerDetails(postRequest: HelperClass.shared.updateHomeDetails, sendDataModel: self.getModelToUpdateHomeDetails, vc: self, completion: {
                self.removeActivity()
                self.isHomeScreenDetailChanged = false
                self.imgHome.image = UIImage(named: "imgHome")
                self.showToas(message: "Updated Successfully..", seconds: 1.5)
                
            })
            
        }
    }
    
    
    
    @objc func generateCurrentTimeStamp () {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM / HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: getTimeZone ?? "IST")
        getDateTime = (formatter.string(from: Date()) as NSString) as String
        if let getTimeDate = getDateTime {
            //lblTimeStamp.font = UIFont(name: "OpenSans", size: 20)
            lblTimeStamp.text = getTimeDate
        }else{
            showToas(message: "No Date & Time", seconds: 2)
        }
    }
    
    ///MARK: CANCEL /DONE BUTTON ACTION FOR PICKER
    @objc func onDoneButtonTapped() {
        
        DispatchQueue.main.async {
            
            switch self.pickerViewType{
            
            case .CountryPicker:
                
                if let getFinalModelImage = self.countryNameModel[self.getCountryPickerRow ?? 0].countryImage, let getfinalPostalFormat = self.countryNameModel[self.getCountryPickerRow ?? 0].countryPostalCodeFormat{
                    
                    userDefaults.set(getFinalModelImage, forKey: "userCountryFlag")
                    userDefaults.set(getfinalPostalFormat, forKey: "userCountryPostalFormat")
                    userDefaults.set(true,  forKey: "isCountryChanged")
                    self.getPostalCodeFormat = Array(getfinalPostalFormat)
                    let getCountryImage = UIImage(data: getFinalModelImage as Data)
                    self.imgCountry.image = getCountryImage
                }
                
                self.getFinalPostalCode.removeAll()
                for (index,element) in self.getPostalCodeFormat.enumerated(){
                    if element == "N"{
                        self.getFinalPostalCode.append("0")
                    }else if element == "S"{
                        self.getFinalPostalCode.append(" ")
                    }else if element == "A"{
                        self.getFinalPostalCode.append("A")
                    }
                    
                }
                self.lblTimeStamp.alpha = 0
                self.homeSelectionDetails[0].1[0].3 = ""
                self.homeSelectionDetails[0].1[0].2 = ""
                toShowPostalOverSwitchng = ""
                self.homeSelectionDetails[4].1[0].3 = ""
                self.homeSelectionDetails[4].1[0].2 = ""
                toShowDeliverAddrssOverSwitchng = ""
                self.selectRetailTV.reloadData()
                self.pickerView.alpha = 0
                self.toolBar.alpha = 0
                self.isShowingPicker = false
                self.view.layoutIfNeeded()
                
            case .PostalCodePicker:
                
                //                self.homeSelectionDetails![0].1 =  String(self.getFinalPostalCode)
                //                self.selectRetailTV.reloadData()
                
                
                if self.getPostalCodeFormats.count != 0{
                    let contains = self.getPostalCodeFormats.contains(where: {$0 == String(self.getFinalPostalCode)})
                    
                    if contains {
                        self.showHideCustomAlert(isShowAlert: true, getTitle: "Information!", getMessage: "please give valid Postal code.", isError: false)
                    }else{
                        self.getRequestType.0 = false
                        self.getRequestType.1 = true
                        self.getRequestType.2 = false
                        self.getRequestType.3 = false
                        self.requestType = .get
                    }
                    
                }else{
                    self.showHideCustomAlert(isShowAlert: true, getTitle: "Error!", getMessage: "postal formats not found for match", isError: false)
                }
                
            }
        }
    }
    @objc func onCancelButtonTapped() {
        DispatchQueue.main.async {
            self.pickerView.alpha = 0
            self.toolBar.alpha = 0
            self.isShowingPicker = false
            self.view.layoutIfNeeded()
        }
    }
    
}


///MARK: EXTENSION

extension HomeScreenController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  homeSelectionDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeSelectionCell.identifier, for: indexPath) as? HomeSelectionCell {
            
            
            for (index,element) in homeSelectionDetails[indexPath.row].1.enumerated(){
                
                if element.4 == 1{
                    cell.lblRetail.text = homeSelectionDetails[indexPath.row].1[index].3
                    self.homeSelectionDetails[indexPath.row].1[index].2 = homeSelectionDetails[indexPath.row].1[index].3
                    cell.imgCell.sd_setImage(with: URL(string: homeSelectionDetails[indexPath.row].1[index].0 ?? ""))
                }
            }
            
            
            cell.celSwtchPressed = self
            cell.btnNxt.tag = indexPath.row
            //cell.cellImg.image = homeSelectionDetails[indexPath.row].3
            cell.cellImg.sd_setImage(with: URL(string: homeSelectionDetails[indexPath.row].3 ?? ""))
            
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
    }
}

extension HomeScreenController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerViewType {
        case .CountryPicker:
            return 1
        case .PostalCodePicker:
            return getPostalCodeFormat.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerViewType {
        case .CountryPicker:
            //            return getCountryFlagName.count
            return countryNameModel.count
        case .PostalCodePicker:
            if getPostalCodeFormat[component] == "N"{
                return numericList.count
            }else if getPostalCodeFormat[component] == "S" {
                return 0
            }else{
                return alphabeticList.count
            }
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerViewType {
        case .CountryPicker:
            //            return getCountryFlagName[row].1
            return countryNameModel[row].countryName
        case .PostalCodePicker:
            if getPostalCodeFormat[component] == "N"{
                return numericList[row]
            }else if getPostalCodeFormat[component] == "S" {
                return ""
            }else {
                return alphabeticList[row]
            }
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerViewType {
        case .CountryPicker:
            getCountryPickerRow = row
        case .PostalCodePicker:
            if getPostalCodeFormat[component] == "N"{
                let numericSelected = numericList[pickerView.selectedRow(inComponent: component)]
                getFinalPostalCode[component] = Character(numericSelected)
            }else if getPostalCodeFormat[component] == "S"{
                
            }else{
                let alphabetSelected = alphabeticList[pickerView.selectedRow(inComponent: component)]
                getFinalPostalCode[component] = Character(alphabetSelected)
            }
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        switch pickerViewType {
        case .CountryPicker:
            let parentView = UIView()
            
            let imageView = UIImageView(frame: CGRect(x: -38, y: 7.5, width: 77, height:45))
            let label = UILabel(frame: CGRect(x: 45, y: 5, width: 80, height: 50))
            
            
            //            imageView.image = getCountryFlagName[row].0
            //            label.text = getCountryFlagName[row].1
            
            if let getImgModel = countryNameModel[row].countryImage, let getCountryName = countryNameModel[row].countryName{
                let getCountryImage = UIImage(data: getImgModel as Data)
                imageView.image = getCountryImage
                label.text = getCountryName
            }
            
            
            
            
            if #available(iOS 13.0, *) {
                picker.backgroundColor = UIColor.systemGray4
            } else {
                picker.backgroundColor = UIColor.systemGray
                
            }
            parentView.addSubview(label)
            parentView.addSubview(imageView)
            
            
            return parentView
        case .PostalCodePicker:
            
            let parentView = UIView()
            let label = UILabel(frame: CGRect(x: 10, y: 5, width: 80, height: 50))
            
            if getPostalCodeFormat[component] == "N"{
                label.text =  numericList[row]
            }else if getPostalCodeFormat[component] == "S" {
                label.text = ""
            }else{
                label.text =  alphabeticList[row]
            }
            
            if #available(iOS 13.0, *) {
                picker.backgroundColor = UIColor.systemGray4
            } else {
                picker.backgroundColor = UIColor.systemGray
                
            }
            parentView.addSubview(label)
            
            return parentView
        }
        return UIView()
    }
}


extension HomeScreenController: showError{
    func showError(getError: String, getMessage: String) {
        showDisconnectAlert(title: getError, message: getMessage)
    }
}

extension HomeScreenController: UITextFieldDelegate,UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        //IMPLEMENT CODE
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}


extension HomeScreenController: donePressed,cellButtonPress{
    
    
    ///MARK: BUTTON CLICK IN TABLE CELL
    func cellButtonPress(btn: UIButton, btnClickCount: Int) {
        
        //IMPLEMENT CODE
        
    }
    
    ///MARK: DONE PRESS IN CUSTOM ADDRESS EDIT VIEW'S KEYBOARD
    func DonePressed() {
        
        isAddressEditDetailChanged = true
       
    }
}

extension HomeScreenController: homeCellSwitchAction{
    func homeCellSwitchAction(cell: UITableViewCell, cellImage: UIImage, cellTitle: String, cellEnableDisable: Bool) {
        
        if let indexPath = self.selectRetailTV.indexPath(for: cell) {
            var cell =  self.selectRetailTV.cellForRow(at: indexPath)  as? HomeSelectionCell
            
            switch indexPath.row{
            case 0:
                
                if homeSelectionDetails[indexPath.row].2 == 1{
                    if isShowingPicker{
                    }else{
                        pickerViewType = .PostalCodePicker
                    }
                }
                
                
            case 1:
                
                if homeSelectionDetails[indexPath.row].2 == 1{
                    if homeSelectionDetails[indexPath.row].4 == "Y"{
                        if startIndex == homeSelectionDetails[indexPath.row].1.count{
                            startIndex = 0
                            //                            cell?.imgCell.image = homeSelectionDetails[indexPath.row].1[startIndex].0
                            cell?.imgCell.sd_setImage(with: URL(string: homeSelectionDetails[indexPath.row].1[startIndex].0 ?? ""))
                            cell?.lblRetail.text = homeSelectionDetails[indexPath.row].1[startIndex].3
                            homeSelectionDetails[indexPath.row].1[startIndex].2 = homeSelectionDetails[indexPath.row].1[startIndex].3
                            for (index,element) in homeSelectionDetails[indexPath.row].1.enumerated(){
                                if index == startIndex{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 1
                                    getFinalShoppingTypeId = homeSelectionDetails[indexPath.row].1[index].1
                                }else{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 0
                                }
                            }
                            startIndex += 1
                        }else if startIndex < homeSelectionDetails[indexPath.row].1.count {
                            
                            //                            cell?.imgCell.image = homeSelectionDetails[indexPath.row].1[startIndex].0
                            cell?.imgCell.sd_setImage(with: URL(string: homeSelectionDetails[indexPath.row].1[startIndex].0 ?? ""))
                            cell?.lblRetail.text = homeSelectionDetails[indexPath.row].1[startIndex].3
                            homeSelectionDetails[indexPath.row].1[startIndex].2 = homeSelectionDetails[indexPath.row].1[startIndex].3
                            for (index,element) in homeSelectionDetails[indexPath.row].1.enumerated(){
                                if index == startIndex{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 1
                                    getFinalShoppingTypeId = homeSelectionDetails[indexPath.row].1[index].1
                                }else{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 0
                                }
                            }
                            startIndex += 1
                        }
                    }else {
                        
                    }
                }
            case 2:
                getRetailVerticalsOfType()
            //                if homeSelectionDetails[indexPath.row].2 == 1{
            //                    self.performSegue(withIdentifier: "showFetchRetail", sender: self)
            //                }
            case 3:
                if homeSelectionDetails[indexPath.row].2 == 1{
                    if homeSelectionDetails[indexPath.row].4 == "Y"{
                        if startIndex == homeSelectionDetails[indexPath.row].1.count{
                            startIndex = 0
                            //                            cell?.imgCell.image = homeSelectionDetails[indexPath.row].1[startIndex].0
                            cell?.imgCell.sd_setImage(with: URL(string: homeSelectionDetails[indexPath.row].1[startIndex].0 ?? ""))
                            cell?.lblRetail.text = homeSelectionDetails[indexPath.row].1[startIndex].3
                            homeSelectionDetails[indexPath.row].1[startIndex].2 = homeSelectionDetails[indexPath.row].1[startIndex].3
                            for (index,element) in homeSelectionDetails[indexPath.row].1.enumerated(){
                                if index == startIndex{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 1
                                }else{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 0
                                }
                            }
                            startIndex += 1
                        }else if startIndex < homeSelectionDetails[indexPath.row].1.count {
                            
                            //                            cell?.imgCell.image = homeSelectionDetails[indexPath.row].1[startIndex].0
                            cell?.imgCell.sd_setImage(with: URL(string: homeSelectionDetails[indexPath.row].1[startIndex].0 ?? ""))
                            cell?.lblRetail.text = homeSelectionDetails[indexPath.row].1[startIndex].3
                            homeSelectionDetails[indexPath.row].1[startIndex].2 = homeSelectionDetails[indexPath.row].1[startIndex].3
                            for (index,element) in homeSelectionDetails[indexPath.row].1.enumerated(){
                                if index == startIndex{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 1
                                }else{
                                    homeSelectionDetails[indexPath.row].1[index].4 = 0
                                }
                            }
                            startIndex += 1
                        }
                    }else {
                        
                    }
                }
            case 4:
                if homeSelectionDetails[indexPath.row].2 == 1{
                    if homeSelectionDetails[4].1[0].3 == ""{
                        showHideCustomAlert(isShowAlert: true, getTitle: "Error!", getMessage: "Please Select Postal Code", isError: false)
                    }else{
                        //                    self.requestType = .post
                        UIView.animate(withDuration: 1, animations: {
                            getDone = self
                            self.customAddressEdit.donePressed = self
                            self.customAddressEdit.alpha = 1
                            self.imgHome.image = UIImage(named: "imgSave")
                            self.isShowingAddressEdit = true
                            self.btnLogin.isUserInteractionEnabled = false
                            
                            
                            
                            self.btnCountries.isUserInteractionEnabled = false
                        })
                    }
                }
            case 5:
                if homeSelectionDetails[indexPath.row].2 == 1{
                    
                }
            case 6:
                if homeSelectionDetails[indexPath.row].2 == 1{
                    
                }
                
            default:
                print("")
                
            }
        }
    }
}


extension HomeScreenController: alertButtonclickEvent{
    func alertButtonClickEvent(Btn: UIButton) {
        showHideCustomAlert(isShowAlert: false, getTitle: "", getMessage: "", isError: false)
    }
}


extension HomeScreenController{
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
        removeActivity()
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            let OkAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
                UIAlertAction in
                self.removeActivity()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                self.removeActivity()
            }
            alert.addAction(OkAction)
            alert.addAction(cancelAction)
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func showHideCustomAlert(isShowAlert: Bool,getTitle: String, getMessage: String,isError: Bool) {
        removeActivity()
        if isShowAlert{
            
            if isError{
                UIView.animate(withDuration: 0.5, animations: { [self] in
                    
                    self.viewCustomAlert.viewAlert.shadowEffects(shadow: .Alert, getView: self.viewCustomAlert.viewAlert, cornerRadius: 12)
                    self.viewCustomAlert.btnErrorInfo.setImage(UIImage(named: "imgError"), for: .normal)
                    self.viewCustomAlert.lblAlertMessage.text = getMessage
                    self.viewCustomAlert.lblAlertTitle.text = getTitle
                    self.viewCustomAlert.alpha = 1
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.5, animations: { [self] in
                    
                    self.viewCustomAlert.viewAlert.shadowEffects(shadow: .Alert, getView: self.viewCustomAlert.viewAlert, cornerRadius: 12)
                    self.viewCustomAlert.btnErrorInfo.setImage(UIImage(named: "imgInfo"), for: .normal)
                    self.viewCustomAlert.lblAlertMessage.text = getMessage
                    self.viewCustomAlert.lblAlertTitle.text = getTitle
                    self.viewCustomAlert.alpha = 1
                }, completion: nil)
            }
            
        }else{
            UIView.animate(withDuration: 0.5, animations: { [self] in
                self.viewCustomAlert.alpha = 0
            }, completion: nil)
        }
    }
}

enum PickerViewTypee {
    case CountryPicker
    case PostalCodePicker
}
