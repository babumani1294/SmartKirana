//
//  SelectRetailVerticalVC.swift
//  RetailEcoS
//  SelectRetailVerticalVC
//  Description - This application handles all the retail verticals as listed.By selecting a retail vertical appropriate modules will be activated.
//  Developed By:
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit

var getNo: String?
var getAddress1: String?
var getFinalAddress1: String?
var getAddress2: String?
var getLocality: String?
var getCity: String?
var getState: String?
var getPostalCodee: String?

var toShowPostalOverSwitchng = String()
var toShowDeliverAddrssOverSwitchng = String()
var toShowLastlySelectedRetail = String()
var toShowLastlySelectedRetailImg : UIImage!

class HomeSelectionListController: UIViewController {
    
    ///mark: property
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    var getCurrentTime = Timer()
    
    var getCountryPickerRow: Int?
    
    var getInitialFlagDetails : Bool?
    var isRetailsChanged = false
    var isShowingPicker: Bool = false
    
    var getLatitude: Double?
    var getLongitude: Double?
    
    var getTimeZone : String?
    var getDateTime : String?
    var getLocalityData = [String]()
    var getPostalCodeFormats = [String]()
    
    
    var getPostalCodeFormat = [Character]()
    var getFinalPostalCode = [Character]()
    
    
    var retailVerticalDetails : [(UIImage?,UIImage?,UIImage?, Bool,String)]?
    var getRequestType = (false,false,false)//requestCountries/reqCountryAddress/reqCountryTime
    var getCountryFlagName = [(UIImage?,String,String)]()//countryImg/countryName/countryPostal
    var getTrackCountryChange : (Data?,String?)
    var homeSelectionDetails : [(UIImage,String,Bool)]!
    //    var homeSelectionDetails = [(Int,[(UIImage?,Int,String,String,Int)])] ()
    
    var getHomeListM: DeviceID!
    var getModelToGiveDevicePostal: ModelToGiveDevicePostal!
    var getModelToUpdateAddress : ModelToUpdateAddress!
    var getHomeControllerVM : HomeControllerViewModel!
    var getMenu : [Menu]!
    
    var countryNameModel = [CountryInfoModel]()
    
    var alphabeticList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var numericList = ["0","1","2","3","4","5","6","7","8","9"]
    
    
    //    var getPostalCode: String?
    let minRowHeight: CGFloat = 50.0
    var activityIndicator = UIActivityIndicatorView()
    var strLabel = UILabel()
    let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    
    var requestType : RequestType = .post{
        didSet{
            switch requestType{
            case .get:
                
                
                if getRequestType.0{
                    
                    // dispatch back to the main thread to update UI
                    DispatchQueue.main.async() {
                        
                        self.countryNameModel = HelperClass.shared.retrieveData(getCountryInfo: &self.countryNameModel)
                        
                        self.getPostalCodeFormats.removeAll()
                        for (index,element) in self.countryNameModel.enumerated(){
                            print(index, element.countryPostalCodeFormat)
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
                                print(getPostalCode)
                                self.getPostalCodeFormats.append(getPostalCode)
                            }else{
                                self.showError(getError: "Error!", getMessage: "Problem in getting Postal Formats")
                            }
                            
                        }
                        
                        self.pickerView.delegate = self
                        self.pickerView.dataSource = self
                        self.pickerView.reloadAllComponents()
                        
                        
                        
                        ///TO CHECK ADDRESS FROM OUR SERVER ON LOAD WITH INITIAL POSTAL CODE.
                        
                        
                        print(String(self.getFinalPostalCode))
                        self.getFinalPostalCode.removeAll()
                        self.getFinalPostalCode = Array(toShowPostalOverSwitchng)
                        print(String(self.getFinalPostalCode))
                        if self.getPostalCodeFormats.count != 0{
                            let contains = self.getPostalCodeFormats.contains(where: {$0 == String(self.getFinalPostalCode)})
                            
                            if contains {
                                self.showHideCustomAlert(isShowAlert: true, getTitle: "Information!", getMessage: "please give valid Postal code.", isError: false)
                            }else{
                                self.getRequestType.0 = false
                                self.getRequestType.1 = true
                                self.getRequestType.2 = false
                                self.requestType = .get
                            }
                            
                        }else{
                            self.showHideCustomAlert(isShowAlert: true, getTitle: "Error!", getMessage: "postal formats not found for match", isError: false)
                        }
                        
                    }
                    
                }else{
                    if getRequestType.1{
                        
                        
                        ///MARK: GETTING COUNTRY ADDRESS BY PROVIDING POSTAL CODE - (GOOGLE API)
                        
                        
                        //                        if let getCountry = getCountry{
                        //
                        //                        }else{
                        //                            showError(getError: "Error!", getMessage: "Failed to get initial Country")
                        //                        }
                        
                        getHomeControllerVM.getCountryAddress(getPostalCode: String(self.getFinalPostalCode), vc: self, completions:  {
                            
                            guard let getCountryPickerDetails = self.getHomeControllerVM.getCountryAddress else{
                                return
                            }
                            
                            if self.getHomeControllerVM.getCountryAddress.status == "OK"{
                                
                                for i in self.getHomeControllerVM.getCountryAddress.results{
                                    
                                    self.homeSelectionDetails[4].1 = i?.formatted_address ?? "not found"
                                    toShowDeliverAddrssOverSwitchng = i?.formatted_address ?? "not found"
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
                                                
                                                var getFinalPhoneCode =  defaultsToStoreDeviceId.string(forKey: "phoneId")
                                                var getFinalMobileNumber = defaultsToStoreDeviceId.string(forKey: "deviceId")
                                                getNo = ""
                                                self.customAddressEdit.txtFirstName.text = "NOT FOUND"
                                                self.customAddressEdit.txtLastName.text = "NOT FOUND"
                                                self.customAddressEdit.txtAddress1.text = "NOT FOUND"
                                                self.customAddressEdit.txtAddress2.text = "NOT FOUND"
                                                self.customAddressEdit.txtLocality.text = "NOT FOUND"
                                                self.customAddressEdit.txtCity.text = "NOT FOUND"
                                                self.customAddressEdit.txtState.text = "NOT FOUND"
                                                self.customAddressEdit.txtPostalCode.text = "NOT FOUND"
                                                self.customAddressEdit.txtCcode.text = "NOT FOUND"
                                                //                                                self.customAddressEdit.txtAcode.text = "NOT FOUND"
                                                self.customAddressEdit.txtMnumber.text = "NOT FOUND"
                                                
                                                
                                                for i in  self.customAddressEdit.btnGroup{
                                                    i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
                                                }
                                                self.getLocalityData.removeAll()
                                                
                                                for j in getAddressComponent{
                                                    
                                                    //mark:for getting address number and first address
                                                    if let premise = j?.types{
                                                        if premise.contains("premise"){
                                                            getNo = j!.long_name ?? "not found"
                                                        }else if premise.contains("route"){
                                                            
                                                            getAddress1 = j!.long_name ?? "not found"
                                                            
                                                            if let getFinalno = getNo, let getFinalAddress = getAddress1{
                                                                self.customAddressEdit.txtAddress1.text = getFinalno.uppercased()  + getFinalAddress.uppercased()
                                                            }else{
                                                                self.customAddressEdit.txtAddress1.text = getAddress1?.uppercased()
                                                            }
                                                            
                                                            
                                                        }else if premise.contains("postal_code"){
                                                            //                                                            getPostal = j!.long_name ?? "not found"
                                                            self.customAddressEdit.txtPostalCode.text = j!.long_name?.uppercased() ?? "not found"
                                                        }else if premise.contains("political"){
                                                            
                                                            if premise.contains("locality"){
                                                                self.customAddressEdit.txtCity.text = j!.long_name?.uppercased() ?? "not found"
                                                            }else if premise.contains("sublocality"){
                                                                
                                                                if self.getLocalityData.contains(j!.long_name ?? "not found"){
                                                                    
                                                                }else{
                                                                    self.getLocalityData.append(j!.long_name?.uppercased() ?? "not found")
                                                                    
                                                                    if self.getLocalityData.count == 1{
                                                                        self.customAddressEdit.txtAddress2.text = self.getLocalityData[0]
                                                                        self.customAddressEdit.txtLocality.text = "not found"
                                                                    }else if self.getLocalityData.count > 1{
                                                                        self.customAddressEdit.txtAddress2.text = self.getLocalityData[0]
                                                                        self.customAddressEdit.txtLocality.text = self.getLocalityData[1]
                                                                    }
                                                                    
                                                                }
                                                                
                                                            }else  if premise.contains("country"){
                                                                getCountry = j!.long_name ?? "not found"
                                                            }else if premise.contains("administrative_area_level_1"){
                                                                self.customAddressEdit.txtState.text = j!.long_name?.uppercased() ?? "not found"
                                                            }else{
                                                                print(j?.long_name)
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                            }
                                            
                                        }else{
                                            self.showError(getError: "Error!", getMessage: "problem in getting result in response")
                                        }
                                    })
                                }
                                self.homeSelectionDetails![0].1 =  String(self.getFinalPostalCode)
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
                            
                        }
                    }
                }
                
                
            case .post:
                
                
                DispatchQueue.global(qos: .userInitiated).async() {
                    
                    getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
                    
                    guard let getDeviceId = getDeviceId else {
                        self.showError(getError: "Problem in getting Device Id in HomeSelection", getMessage: "")
                        return
                    }
                    
                    if self.homeSelectionDetails[0].1 != ""{
                        
                        self.getModelToGiveDevicePostal = ModelToGiveDevicePostal(getDeviceId: getDeviceId, getPostalCode: self.homeSelectionDetails[0].1)
                        
                        DispatchQueue.global(qos: .userInitiated).async() {
                            
                            self.getHomeControllerVM.getAddressDetails(postRequest: HelperClass.shared.addressFetch, sendDataModel: self.getModelToGiveDevicePostal, vc: self, completion: { [self] (message) -> Void in
                                
                                if message == 1{
                                    if let getAddressDetails = getHomeControllerVM.getAddressDetails{
                                        
                                        if let getFetchedAddress = getAddressDetails.status.Deviceaddress{
                                            
                                            var getFinalPhoneCode =  defaultsToStoreDeviceId.string(forKey: "phoneId")
                                            var getFinalMobileNumber = defaultsToStoreDeviceId.string(forKey: "deviceId")
                                            self.customAddressEdit.txtFirstName.text = "NOT FOUND"
                                            self.customAddressEdit.txtLastName.text = "NOT FOUND"
                                            self.customAddressEdit.txtAddress1.text = "NOT FOUND"
                                            self.customAddressEdit.txtAddress2.text = "NOT FOUND"
                                            self.customAddressEdit.txtLocality.text = "NOT FOUND"
                                            self.customAddressEdit.txtCity.text = "NOT FOUND"
                                            self.customAddressEdit.txtState.text = "NOT FOUND"
                                            self.customAddressEdit.txtPostalCode.text = "NOT FOUND"
                                            self.customAddressEdit.txtCcode.text = "NOT FOUND"
                                            //                                            self.customAddressEdit.txtAcode.text = "NOT FOUND"
                                            self.customAddressEdit.txtMnumber.text =  "NOT FOUND"
                                            
                                            
                                            for i in  self.customAddressEdit.btnGroup{
                                                i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
                                            }
                                            
                                            
                                            self.customAddressEdit.txtFirstName.text = getFetchedAddress[0].FIRST_NAME
                                            self.customAddressEdit.txtLastName.text = getFetchedAddress[0].LAST_NAME
                                            self.customAddressEdit.txtAddress1.text = getFetchedAddress[0].ADDRESS_1
                                            self.customAddressEdit.txtAddress2.text = getFetchedAddress[0].ADDRESS_2
                                            self.customAddressEdit.txtLocality.text = getFetchedAddress[0].LOCALITY
                                            self.customAddressEdit.txtCity.text = getFetchedAddress[0].CITY
                                            self.customAddressEdit.txtState.text = getFetchedAddress[0].STATE
                                            self.customAddressEdit.txtPostalCode.text = getFetchedAddress[0].POSTAL_CODE
                                            self.customAddressEdit.txtCcode.text = getFetchedAddress[0].COUNTRY_CODE
                                            //                                            self.customAddressEdit.txtAcode.text = getFetchedAddress[0].AREA_CODE
                                            self.customAddressEdit.txtMnumber.text = getFetchedAddress[0].MOBILE_NUMBER
                                            
                                            
                                            ///MARK: CHANGE TICK MARK FOR SPECIFIED ADDRESS IN CUSTOM ADDRESS EDIT SCREEN
                                            
                                            for i in customAddressEdit.btnGroup{
                                                i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
                                            }
                                            
                                            getFetchedAddress[0].ADDRESS_TYPE == "1" ? customAddressEdit.btnHome.setImage(UIImage(named: "imgAddressSelect"), for: .normal) : getFetchedAddress[0].ADDRESS_TYPE == "2" ? customAddressEdit.btnOffice.setImage(UIImage(named: "imgAddressSelect"), for: .normal) : getFetchedAddress[0].ADDRESS_TYPE == "3" ? customAddressEdit.btnOther.setImage(UIImage(named: "imgAddressSelect"), for: .normal) : print("")
                                            
                                            switch getFetchedAddress[0].ADDRESS_TYPE{
                                            case "1":
                                                homeSelectionDetails[4].1 = "Home Address"
                                                selectedId = 1
                                                selectRetailTV.reloadData()
                                            case "2":
                                                homeSelectionDetails[4].1 = "Office Address"
                                                selectedId = 2
                                                selectRetailTV.reloadData()
                                            case "3":
                                                homeSelectionDetails[4].1 = "Other Address"
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
    var pickerViewType : PickerViewType = .CountryPicker{
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
    
    ///mark: action
    @IBAction func btnLogin(_ sender: UIButton) {
    }
    @IBAction func btnHome(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{
            imgHome.image = UIImage(named: "imgSave")
        }else{
            imgHome.image = UIImage(named: "imgHome")
        }
        
    }
    @IBAction func btnCountries(_ sender: UIButton) {
        if isShowingPicker{
            
        }else{
            pickerViewType = .CountryPicker
        }
        
    }
    //    getCountryPostalCode
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    override func viewDidAppear(_ animated: Bool) {
        
        if isRetailsChanged {
            getRequestType.0 = true
            getRequestType.1 = false
            getRequestType.2 = false
            requestType = .get
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showRetailVertical" else{
            return
        }
        
//        let getRetailController = segue.destination as! RetailSelectionController
//        getRetailController.retailVerticalDetails = retailVerticalDetails
//        getRetailController.isRetailTobeChanged = true
        
    }
    
    ///mark: function
    func initialConfig() {
       
        viewCustomAlert.btnClick = self
        getHomeControllerVM = HomeControllerViewModel()
        getHomeControllerVM.showError = self
        
        self.customAddressEdit.txtAddress1.text = getFinalAddress1?.uppercased()
        self.customAddressEdit.txtAddress2.text = getAddress2?.uppercased()
        self.customAddressEdit.txtLocality.text = getLocality?.uppercased()
        self.customAddressEdit.txtCity.text = getCity?.uppercased()
        self.customAddressEdit.txtState.text = getState?.uppercased()
        self.customAddressEdit.txtPostalCode.text = getPostalCodee?.uppercased()
        
        self.customAddressEdit.txtFirstName.delegate = self
        self.customAddressEdit.txtLastName.delegate = self
        self.customAddressEdit.txtAddress1.delegate = self
        self.customAddressEdit.txtAddress2.delegate = self
        self.customAddressEdit.txtLocality.delegate = self
        self.customAddressEdit.txtCity.delegate = self
        self.customAddressEdit.txtState.delegate = self
        self.customAddressEdit.txtPostalCode.delegate = self
        self.customAddressEdit.txtCcode.delegate = self
        //        self.customAddressEdit.txtAcode.delegate = self
        self.customAddressEdit.txtMnumber.delegate = self
        
        if let getIntTimeZone = getCountryTimeZone{
            getTimeZone = getIntTimeZone
        }
        
        getCurrentTime = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: #selector(generateCurrentTimeStamp), userInfo: nil, repeats: true)
        
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
        
        
        
        ///mark: initially hides pickerview
        showPicker(pickerAlpha: 0, toolbarAlpha: 0)
        
        if let getHomeSelectionDetails = homeSelectionDetails{
            
            if getHomeSelectionDetails[0].1 != ""{
                if let getIntialFlag = getInitialFlagDetails{
                    if getIntialFlag{
                        for i in 0..<12{
                            if let getRetailDetails = self.retailVerticalDetails{
                                if getRetailDetails[i].3 {
                                    self.lblTimeStamp.alpha = 0
                                    homeSelectionDetails![0].1 = ""
                                    toShowPostalOverSwitchng = ""
                                    homeSelectionDetails![4].1 = ""
                                    toShowDeliverAddrssOverSwitchng = ""
                                    homeSelectionDetails![2].0 = getRetailDetails[i].1 ?? UIImage(named: "imgError")!
                                    homeSelectionDetails![2].1 = getRetailDetails[i].4
                                    toShowLastlySelectedRetail = getRetailDetails[i].4
                                    toShowLastlySelectedRetailImg = getRetailDetails[i].1 ?? UIImage(named: "imgError")!
                                }
                            }else{
                                showError(getError: "Error!", getMessage: "Problem in getting Retails in Home Selection")
                                
                            }
                        }
                    }
                }else{
                    for i in 0..<12{
                        if let getRetailDetails = self.retailVerticalDetails{
                            if getRetailDetails[i].3 {
                                homeSelectionDetails![2].0 = getRetailDetails[i].1 ?? UIImage(named: "imgError")!
                                homeSelectionDetails![2].1 = getRetailDetails[i].4
                                toShowLastlySelectedRetail = getRetailDetails[i].4
                                toShowLastlySelectedRetailImg = getRetailDetails[i].1 ?? UIImage(named: "imgError")!
                            }
                        }else{
                            showError(getError: "Error!", getMessage: "Problem in getting Retails in Home Selection")
                        }
                    }
                }
                
                
                ///NEW IMPLEMENTATION 5-3-2021
                
                selectRetailTV.delegate = self
                selectRetailTV.dataSource = self
                selectRetailTV.reloadData()
                
            }else{
                showError(getError: "Error!", getMessage: "Problem in getting Home Selection Details")
            }
            
        }
        
        getRequestType.0 = true
        getRequestType.1 = false
        getRequestType.2 = false
        requestType = .get
        
        
        
        ///MARK: NEW IMPLEMENTATION TO CHECK ADDRESS FOR POSTAL FROM OUT SERVER ON LOAD 5-3-2021
        //------
        //        print(String(self.getFinalPostalCode))
        //
        //        if self.getPostalCodeFormats.count != 0{
        //            let contains = self.getPostalCodeFormats.contains(where: {$0 == String(self.getFinalPostalCode)})
        //
        //            if contains {
        //                self.showHideCustomAlert(isShowAlert: true, getTitle: "Information!", getMessage: "please give valid Postal code.", isError: false)
        //            }else{
        //                self.getRequestType.0 = false
        //                self.getRequestType.1 = true
        //                self.getRequestType.2 = false
        //                self.requestType = .get
        //            }
        //
        //        }else{
        //            self.showHideCustomAlert(isShowAlert: true, getTitle: "Error!", getMessage: "postal formats not found for match", isError: false)
        //        }
        //--------
        
        
        
        
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
    
    @objc func generateCurrentTimeStamp () {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM / HH:mm:ss"
        formatter.timeZone = TimeZone(identifier: getTimeZone ?? "IST")
        getDateTime = (formatter.string(from: Date()) as NSString) as String
        if let getTimeDate = getDateTime {
            //            lblTimeStamp.font = UIFont(name: "OpenSans", size: 20)
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
                self.homeSelectionDetails![0].1 = ""
                toShowPostalOverSwitchng = ""
                self.homeSelectionDetails![4].1 = ""
                toShowDeliverAddrssOverSwitchng = ""
                self.selectRetailTV.reloadData()
                self.pickerView.alpha = 0
                self.toolBar.alpha = 0
                self.isShowingPicker = false
                self.view.layoutIfNeeded()
                
            case .PostalCodePicker:
                
                //                self.homeSelectionDetails![0].1 =  String(self.getFinalPostalCode)
                //                self.selectRetailTV.reloadData()
                
                print(String(self.getFinalPostalCode))
                
                if self.getPostalCodeFormats.count != 0{
                    let contains = self.getPostalCodeFormats.contains(where: {$0 == String(self.getFinalPostalCode)})
                    
                    if contains {
                        self.showHideCustomAlert(isShowAlert: true, getTitle: "Information!", getMessage: "please give valid Postal code.", isError: false)
                    }else{
                        self.getRequestType.0 = false
                        self.getRequestType.1 = true
                        self.getRequestType.2 = false
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


///mark: extension

extension HomeSelectionListController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeSelectionDetails!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HomeSelectionCell.identifier, for: indexPath) as? HomeSelectionCell {
            
            cell.lblRetail.text = homeSelectionDetails![indexPath.row].1
            cell.imgCell.image = homeSelectionDetails![indexPath.row].0
            cell.cellBtnPressed = self
            cell.btnNxt.tag = indexPath.row
            
            switch indexPath.row {
            case 0:
                cell.cellImg.image = UIImage(named: "imgFrwrd")
                cell.imgWidthConstraint.constant = 23
            case 1:
                cell.cellImg.image = UIImage(named: "imgRefresh")
                cell.imgWidthConstraint.constant = 45
            case 2:
                cell.cellImg.image = UIImage(named: "imgFrwrd")
                cell.imgWidthConstraint.constant = 23
            case 3:
                cell.cellImg.image = UIImage(named: "imgRefresh")
                cell.imgWidthConstraint.constant = 45
            case 4:
                cell.cellImg.image = UIImage(named: "imgFrwrd")
                cell.imgWidthConstraint.constant = 23
            case 5:
                cell.cellImg.image = UIImage(named: "imgFrwrd")
                cell.imgWidthConstraint.constant = 23
            case 6:
                cell.cellImg.image = UIImage(named: "imgFrwrd")
                cell.imgWidthConstraint.constant = 23
                
            default:
                print("")
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
    }
}

extension HomeSelectionListController: UIPickerViewDataSource, UIPickerViewDelegate{
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

extension HomeSelectionListController: showError{
    func showError(getError: String, getMessage: String) {
        showDisconnectAlert(title: getError, message: getMessage)
    }
}

extension HomeSelectionListController: UITextFieldDelegate,UITextViewDelegate{
    ///mark: textview delegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        //        getDone = self
        selectedTxtView = textView.tag
        switch textView.tag {
        case 0:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 1:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 2:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 3:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 4:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 5:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 6:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 7:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 8:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 9:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        case 10:
            textView.resignFirstResponder()
            customAddressEdit.viewCustomKeyboard?.addSubview(customAddressEdit.UPPERLETTERPAD!)
        default:
            print("")
        }
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}

extension HomeSelectionListController: donePressed,cellButtonPress{
    func cellButtonPress(btn: UIButton, btnClickCount: Int) {
        
        
        switch btn.tag {
        
        case 0:
            
            if homeSelectionDetails![btn.tag].2{
                if isShowingPicker{
                }else{
                    pickerViewType = .PostalCodePicker
                }
            }
            
        case 1:
            switch btnClickCount {
            case 1:
                
                self.homeSelectionDetails![1].0 = UIImage(named: "imgShpFrmHome")!
                self.homeSelectionDetails![1].1 = "Shop From Home"
                self.homeSelectionDetails![2].0 = toShowLastlySelectedRetailImg
                self.homeSelectionDetails![2].1 = toShowLastlySelectedRetail
                self.homeSelectionDetails![2].2 = true
                self.selectRetailTV.reloadData()
                
                if homeSelectionDetails![1].1 == "Shop From Home" && homeSelectionDetails![3].1 == "Home Delivery"{
                    self.homeSelectionDetails[0].1 = toShowPostalOverSwitchng
                    self.homeSelectionDetails[4].1 = toShowDeliverAddrssOverSwitchng
                    self.homeSelectionDetails![0].2 = true
                    self.homeSelectionDetails![4].2 = true
                    self.selectRetailTV.reloadData()
                }
                
                
                
            case 2:
                
                self.homeSelectionDetails![1].0 = UIImage(named: "imgShopAtStore")!
                self.homeSelectionDetails![1].1 = "Shop @ Store"
                self.homeSelectionDetails![2].0 = UIImage(named: "imgGrocery")!
                self.homeSelectionDetails![2].1 = "Grocery"
                self.homeSelectionDetails![2].2 = false
                self.selectRetailTV.reloadData()
                
                
                if homeSelectionDetails![1].1 == "Shop @ Store" || homeSelectionDetails![3].1 == "Kerbside Pickup"{
                    
                    self.homeSelectionDetails[0].1 = ""
                    self.homeSelectionDetails![0].2 = false
                    self.homeSelectionDetails![4].2 = false
                    self.homeSelectionDetails[4].1 = ""
                    self.selectRetailTV.reloadData()
                    
                }
                
                
                
            default:
                print("")
            }
        case 2:
            
            if homeSelectionDetails![btn.tag].2{
                self.performSegue(withIdentifier: "showRetailVertical", sender: self)
            }
            
        case 3:
            switch btnClickCount {
            case 1:
                
                self.homeSelectionDetails![3].0 = UIImage(named: "imgHomeDelivery")!
                self.homeSelectionDetails![3].1 = "Home Delivery"
                self.selectRetailTV.reloadData()
                
                
                if homeSelectionDetails![1].1 == "Shop From Home" && homeSelectionDetails![3].1 == "Home Delivery"{
                    self.homeSelectionDetails[4].1 = toShowDeliverAddrssOverSwitchng
                    self.homeSelectionDetails![4].2 = true
                    self.homeSelectionDetails![0].2 = true
                    self.homeSelectionDetails[0].1 = toShowPostalOverSwitchng
                    self.selectRetailTV.reloadData()
                }
                
                
            case 2:
                
                self.homeSelectionDetails![3].0 = UIImage(named: "imgKerbSidePick")!
                self.homeSelectionDetails![3].1 = "Kerbside Pickup"
                self.selectRetailTV.reloadData()
                
                if homeSelectionDetails![1].1 == "Shop @ Store" || homeSelectionDetails![3].1 == "Kerbside Pickup"{
                    self.homeSelectionDetails[0].1 = ""
                    self.homeSelectionDetails![0].2 = false
                    self.homeSelectionDetails![4].2 = false
                    self.homeSelectionDetails[4].1 = ""
                    self.selectRetailTV.reloadData()
                }
                
                
            default:
                print("")
            }
        case 4:
            
            if homeSelectionDetails![btn.tag].2{
                if homeSelectionDetails![4].1 == ""{
                    showHideCustomAlert(isShowAlert: true, getTitle: "Error!", getMessage: "Please Select Postal Code", isError: false)
                }else{
                    //                    self.requestType = .post
                    UIView.animate(withDuration: 1, animations: {
                        getDone = self
                        self.customAddressEdit.donePressed = self
                        self.customAddressEdit.alpha = 1
                        self.btnLogin.isUserInteractionEnabled = false
                        self.btnHome.isUserInteractionEnabled = false
                        self.btnCountries.isUserInteractionEnabled = false
                    })
                }
            }
            
        case 5:
            print(btnClickCount)
        case 6:
            print(btnClickCount)
        default:
            print("")
        }
    }
    func DonePressed() {
        
        ///MARK: UPDATING DETAILS TO THE SERVER
        
        getDeviceId = defaultsToStoreDeviceId.string(forKey: "deviceId")
        
        
        guard let getDeviceId = getDeviceId else {
            self.showError(getError: "Problem in getting Device Id in HomeSelection", getMessage: "")
            return
        }
        
        if let getSelectedId = selectedId{
            
            getModelToUpdateAddress = ModelToUpdateAddress(getDeviceId: getDeviceId, getFirsName: self.customAddressEdit.txtFirstName.text, getLastName: self.customAddressEdit.txtLastName.text, getAddress1: self.customAddressEdit.txtAddress1.text, getAddress2: self.customAddressEdit.txtAddress2.text, getLocality: self.customAddressEdit.txtLocality.text, getCity: self.customAddressEdit.txtCity.text, getState: self.customAddressEdit.txtState.text, getPostalCode: self.customAddressEdit.txtPostalCode.text, getAddressType: String(getSelectedId), getAreaCode: "", getCountryCode: self.customAddressEdit.txtCcode.text, getMobileNumber: self.customAddressEdit.txtMnumber.text)
            
            
            print(self.customAddressEdit.txtFirstName.text)
            print(getModelToUpdateAddress.FIRST_NAME)
            print(self.customAddressEdit.txtLastName.text)
            print(self.customAddressEdit.txtAddress1.text)
            print(self.customAddressEdit.txtAddress2.text)
            print(self.customAddressEdit.txtLocality.text)
            print(self.customAddressEdit.txtCity.text)
            print(self.customAddressEdit.txtState.text)
            print(self.customAddressEdit.txtPostalCode.text)
            print(self.customAddressEdit.txtCcode.text)
            print(self.customAddressEdit.txtMnumber.text)
            
            DispatchQueue.global(qos: .userInitiated).async() {
                
                self.getHomeControllerVM.postAddressEditDetails(postRequest: HelperClass.shared.addressUpdate, sendDataModel: self.getModelToUpdateAddress, vc: self, completion: { (message) -> Void in
                    
                    
                    if message == 1{
                        UIView.animate(withDuration: 1.2, animations: {
                            
                            self.customAddressEdit.alpha = 0
                            //                            self.customAddressEdit.txtFirstName.text = ""
                            //                            self.customAddressEdit.txtLastName.text = ""
                            //                            self.customAddressEdit.txtCcode.text = ""
                            //                            self.customAddressEdit.txtAcode.text = ""
                            //                            self.customAddressEdit.txtMnumber.text = ""
                            //
                            //                            for i in  self.customAddressEdit.btnGroup{
                            //                                i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
                            //                            }
                            
                            self.btnLogin.isUserInteractionEnabled = true
                            self.btnHome.isUserInteractionEnabled = true
                            self.btnCountries.isUserInteractionEnabled = true
                            
                            if let getSelectedId = selectedId{
                                if getSelectedId == 1{
                                    self.homeSelectionDetails![4].1 = "Home Address"
                                    toShowDeliverAddrssOverSwitchng = "Home Address"
                                }else if getSelectedId == 2{
                                    self.homeSelectionDetails![4].1 = "Office Address"
                                    toShowDeliverAddrssOverSwitchng = "Office Address"
                                }else{
                                    self.homeSelectionDetails![4].1 = "Other Address"
                                    toShowDeliverAddrssOverSwitchng = "Other Address"
                                }
                            }
                            
                            self.selectRetailTV.reloadData()
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
}

extension HomeSelectionListController: alertButtonclickEvent{
    func alertButtonClickEvent(Btn: UIButton) {
        showHideCustomAlert(isShowAlert: false, getTitle: "", getMessage: "", isError: false)
    }
}

extension HomeSelectionListController{
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
    func showHideCustomAlert(isShowAlert: Bool,getTitle: String, getMessage: String,isError: Bool) {
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

enum PickerViewType {
    case CountryPicker
    case PostalCodePicker
}
