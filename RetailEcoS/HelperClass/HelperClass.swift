//
//  HelperClass.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2020-12-25.
//

import Foundation
import UIKit
import CoreData
var getDone: donePressed!
class HelperClass {
    ///mark: property
    static var shared  =  HelperClass()
    
    
    ///Post Request
    var urlFetchCompanyDetails = "https://www.smartkirana.ca/retailecos/api/fetchSplash"
    var urlFetchVerticalDetails = "https://www.smartkirana.ca/retailecos/api/fetchVertical"
    var permissionFetch = "https://www.smartkirana.ca/retailecos/api/fetchPermission"
    var permissionUpdate = "https://www.smartkirana.ca/retailecos/api/updatePermission"
    var getHomeDetails = "https://www.smartkirana.ca/retailecos/api/fetchMenuNew"
    
    var addressFetch = "https://www.smartkirana.ca/retailecos/api/FetchDeviceAddress"
    var addressUpdate = "https://www.smartkirana.ca/retailecos/api/UpdateDeviceAddress"
    
    var urlFetchPhoneCode = "https://www.smartkirana.ca/retailecos/api/fetchPhoneCode"
    
    var updateRetailVertical = "https://www.smartkirana.ca/retailecos/api/UpdateVertical"
    
    var urlFetchRetailVerticalOfType = "https://www.smartkirana.ca/retailecos/api/FetchVerticalByType"
    
    var updateHomeDetails = "https://www.smartkirana.ca/retailecos/api/UpdateMenu"
    
    ///Get Request
    var getCountryPostalCode = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
    //    var getCountryPostalCode2 = "&key=AIzaSyDho6YqRH605Poc-S0AcShQu4hLYDUMGpk"
    var getCountryPostalCode2 = "&key=AIzaSyB4OSNg380U2jVQTCpJRQA-YEHwmXXPKsM"
    
    
    
    
    
    ///MARK: OLD API
    
    var getCountryAddress = "https://maps.googleapis.com/maps/api/geocode/json?address="
    var getCountryAddress2 = "&key=AIzaSyB4OSNg380U2jVQTCpJRQA-YEHwmXXPKsM"
    
    
    ///MARK: NEW API MODIFIED:
    
    //    https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:l4e%200a8|country:canada&key=AIzaSyB4OSNg380U2jVQTCpJRQA-YEHwmXXPKsM
    
    //    var getCountryAddress = "https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:"
    //    var getCountryAddress1 = "|country:"
    //    var getCountryAddress2 = "&key=AIzaSyB4OSNg380U2jVQTCpJRQA-YEHwmXXPKsM"
    
    
    
    var getCountryTimeZone = "https://maps.googleapis.com/maps/api/timezone/json?location="
    var getCountryTimeZone2 = "&timestamp="
    var getCountryTimeZone3 = "&key=AIzaSyB4OSNg380U2jVQTCpJRQA-YEHwmXXPKsM"
    
    
    
    var getCountryName = "https://www.smartkirana.ca/retailecos/api/MasterSelectionApi"
    
}

///mark: extensions
extension UIView{
    func shadowEffects(shadow: Shadow,getView: UIView,cornerRadius: CGFloat){
        
        switch shadow  {
        case .LightShadow:
            
            getView.layer.cornerRadius = 15
            getView.layer.masksToBounds = false
            getView.layer.shadowColor = UIColor.lightGray.cgColor
            getView.layer.shadowOffset = CGSize(width: 5, height: 5)
            getView.layer.shadowRadius = 4
            getView.layer.shadowOpacity = 0.8
            
        case .DarkShadow:
            
            getView.layer.masksToBounds = false
            getView.layer.shadowColor = UIColor.lightGray.cgColor
            getView.layer.shadowOffset = CGSize(width: 4, height: 4)
            getView.layer.shadowRadius = 4
            getView.layer.shadowOpacity = 10
            
        case .WithBorder:
            
            getView.layer.cornerRadius = cornerRadius
            getView.layer.borderWidth = 1
            getView.layer.borderColor = UIColor.darkGray.cgColor
            getView.layer.masksToBounds = false
            getView.layer.shadowColor = UIColor.lightGray.cgColor
            getView.layer.shadowOffset = CGSize(width: 4, height: 4)
            getView.layer.shadowRadius = 4
            getView.layer.shadowOpacity = 0
            
        case .Alert:
            
            getView.layer.cornerRadius = 0
            getView.layer.borderWidth = 1
            getView.layer.borderColor = UIColor.darkGray.cgColor
            getView.layer.masksToBounds = false
            
        default:
            print("")
        }
        
    }
    func setImageColor(image: UIImageView,color: UIColor){
        let templateImage =  image.image?.withRenderingMode(.alwaysTemplate)
        image.image = templateImage
        image.contentMode = .scaleAspectFit
        image.tintColor = color
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

extension UITextField{
    func setUnderLine() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.barTintColor = UIColor.darkGray
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelButtonAction))
        
        let items = [cancelButton,flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        done.tintColor = UIColor.white
        cancelButton.tintColor = UIColor.white
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        getDone.DonePressed()
        self.resignFirstResponder()
    }
    @objc func cancelButtonAction()
    {
        self.resignFirstResponder()
    }
}


extension UITextView{
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        doneToolbar.barTintColor = UIColor.darkGray
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelButtonAction))
        
        let items = [cancelButton,flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        done.tintColor = UIColor.white
        cancelButton.tintColor = UIColor.white
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        getDone.DonePressed()
        self.resignFirstResponder()
    }
    @objc func cancelButtonAction()
    {
        self.resignFirstResponder()
    }
}


///MARK: ENUM

enum ScreenType {
    case HomeScreen
    case AddressEdit
}


enum Shadow {
    case DarkShadow
    case LightShadow
    case WithBorder
    case Alert
}

enum RequestType {
    case post
    case get
}

enum MobileRegisterRequest {
    case post
    case get
}


enum GetRequestType {
    case getCountry
    case getCountryAddress
    case getCountryTime
}




///MARK: PROTOCOL
protocol donePressed{
    func DonePressed()
}
protocol showError {
    func showError(getError: String,getMessage: String)
}

protocol cellButtonPress {
    func cellButtonPress(btn: UIButton,btnClickCount: Int)
}

///MARK HOME SCREEN PROTOCOL

protocol homeCellSwitchAction {
    func homeCellSwitchAction(cell: UITableViewCell,cellImage: UIImage, cellTitle: String, cellEnableDisable: Bool)
}

protocol homeCellDetails {
    func homeCellDetails(cellImage: UIImage, cellTitle: String, cellEnableDisable: Bool)
}


protocol cellSwitch {
    func cellSwitch(cellIndex: UITableViewCell,cellSwitch: UISwitch)
}

protocol retryRequest {
    func retryGet(url:String,vc:UIViewController)
    func retryPost(url:String,getModel: Data?,vc:UIViewController)
}

extension HelperClass{
    
    
    func insertDeviceDetails(countryImg: Data,countryName: String,countryPostalFormat: String) {
        
        DispatchQueue.main.async {
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Now let’s create an entity and new user records.
            let userEntity = NSEntityDescription.entity(forEntityName: "Country", in: managedContext)!
            
            //final, we need to add some data to our newly created record for each keys using
            //here adding 5 data with loop
            
            
            
            let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
            user.setValue(countryImg, forKeyPath: "countryImg")
            user.setValue(countryName, forKey: "countryName")
            user.setValue(countryPostalFormat, forKey: "countryPostal")
            //Now we have set all the values. The next step is to save them inside the Core Data
            
            do {
                try managedContext.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        
    }
    func retrieveData(getCountryInfo: inout [CountryInfoModel]) -> [CountryInfoModel]{
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [CountryInfoModel(countryImage: nil, countryName:  nil, countryPostalCodeFormat:  nil)] }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //Prepare the request of type NSFetchRequest  for the entity
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
            
            do {
                let result = try managedContext.fetch(fetchRequest)
                
                
                for data in result as! [NSManagedObject] {
                    
                    //                getDeviceInfo.append(CountryInfoModel(getDeviceSerialNo: data.value(forKey: "serialNo") as! String, getDeviceModel: data.value(forKey: "model") as! String, getDeviceImage: data.value(forKey: "deviceImage") as! NSData, getDeviceMacAddress: data.value(forKey: "macAddress") as! String))
                    
                    getCountryInfo.append(CountryInfoModel(countryImage: data.value(forKey: "countryImg") as! NSData, countryName: data.value(forKey: "countryName") as! String, countryPostalCodeFormat: data.value(forKey: "countryPostal") as! String))
                    
                    
                }
                
                
                
            } catch {
                
                print("Failed")
            }
            
            
            return getCountryInfo
        
        
    }
    
    //    func deleteAllData(entity: String) {
    //
    //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //        let managedContext = appDelegate.persistentContainer.viewContext
    //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
    //        fetchRequest.returnsObjectsAsFaults = false
    //
    //        do
    //        {
    //            let results = try managedContext.fetch(fetchRequest)
    //            for managedObject in results
    //            {
    //                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
    //                managedContext.delete(managedObjectData)
    //            }
    //
    //        } catch let error as NSError {
    //            print(error)
    //        }
    //    }
    
    
    func deleteRecord() {
        
        DispatchQueue.main.async {
            
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            // Initialize Fetch Request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
            
            // Configure Fetch Request
            fetchRequest.includesPropertyValues = false
            
            do {
                let items = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
                
                for item in items {
                    managedContext.delete(item)
                }
                
                // Save Changes
                try managedContext.save()
                
            } catch {
                // Error Handling
                // ...
                print("problem in deleting records")
            }
        }
        
    }
    
    
    func someEntityExists() -> Bool {
        
        
            //As we know that container is set up in the AppDelegates so we need to refer that container.
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false}
            
            //We need to create a context from this container
            let managedContext = appDelegate.persistentContainer.viewContext
            
            var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Country")
            
            var results: [NSManagedObject] = []
            
            
            do {
                results = try managedContext.fetch(fetchRequest)
            }
            catch {
                print("error executing fetch request: \(error)")
            }
            
            return results.count > 0
        
    }
    
}



class CountryInfoModel{
    
    var countryImage: NSData?
    var countryName: String?
    var countryPostalCodeFormat: String?
    
    init(countryImage: NSData?,countryName: String?,countryPostalCodeFormat: String?) {
        self.countryImage = countryImage
        self.countryName = countryName
        self.countryPostalCodeFormat = countryPostalCodeFormat
        
    }
}
