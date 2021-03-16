//
//  HomeControllerViewModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-10.
//

import Foundation
import UIKit

class HomeControllerViewModel {
    ///Mark: property
    var getHomeControllerDetails: ModelToGetHomeDetails!
    var getFetchRetailOfType: ModelToGetRetailForType!
    var getCountryPickerDetails: CountryNameModel!
    var getCountryAddress: ModelToGetCountyAddress!
    var getCountryTimeZone: ModelToGetCountyTimeZone!
    var getCountryPostalCode: ModelToGetCountyPostalCode!
    var getAddressDetails: ModelToFetchAddressDetails!
    var showError : showError!
    
    ///MARK: FUNCTION
    
    ///MARK: GET REQUEST
    func getCountryName(vc: UIViewController,completions: @escaping () -> ())  {
        
        do {
            
            try Service.shared.postRequest(urls: HelperClass.shared.getCountryName, getModel: nil, vc: vc, completion: { result in
                
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        //                        print(removeSlash)
                        //GETTING JSON STRING OBJECT
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            
                            let getCountryPickerDetails = try JSONDecoder().decode(CountryNameModel.self, from: jsonData)
                            self.getCountryPickerDetails = getCountryPickerDetails
                            completions()
                            
                        } catch let DecodingError.dataCorrupted(context) {
                            print(context)
                        } catch let DecodingError.keyNotFound(key, context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.valueNotFound(value, context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.typeMismatch(type, context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch {
                            print("error: ", error)
                        }
                    }
                }
                
                
            })
            
        } catch let error {
            print(error)
        }
    }
    func getCountryAddress(getPostalCode: String,vc: UIViewController,completions: @escaping () -> ())  {
        
        do {
            
            let removeSpaceChar = getPostalCode.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range:nil)
            
            try Service.shared.postRequest(urls: HelperClass.shared.getCountryAddress + removeSpaceChar + HelperClass.shared.getCountryAddress2, getModel: nil, vc: vc, completion: { result in
                
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        print(removeSlash)
                        //GETTING JSON STRING OBJECT
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            
                            let getCountryAddress = try JSONDecoder().decode(ModelToGetCountyAddress.self, from: jsonData)
                            self.getCountryAddress = getCountryAddress
                            completions()
                            
                        } catch let DecodingError.dataCorrupted(context) {
                            print(context)
                        } catch let DecodingError.keyNotFound(key, context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.valueNotFound(value, context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.typeMismatch(type, context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch {
                            print("error: ", error)
                        }
                    }
                }
                
                
            })
            
        } catch let error {
            print(error)
        }
    }
    func getCountryTimeZone(getLat: String,getLong: String,getTimeStamp: String,vc: UIViewController,completions: @escaping () -> ())  {
        
        do {
            
            try   Service.shared.getSearchResults(url: HelperClass.shared.getCountryTimeZone + getLat + "," + getLong +  HelperClass.shared.getCountryTimeZone2 + getTimeStamp + HelperClass.shared.getCountryTimeZone3  , vc: vc, completion: { result in
                
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        print(removeSlash)
                        //GETTING JSON STRING OBJECT
                        
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            
                            let getCountryTimeZone = try JSONDecoder().decode(ModelToGetCountyTimeZone.self, from: jsonData)
                            self.getCountryTimeZone = getCountryTimeZone
                            completions()
                            
                        } catch let DecodingError.dataCorrupted(context) {
                            print(context)
                        } catch let DecodingError.keyNotFound(key, context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.valueNotFound(value, context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.typeMismatch(type, context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch {
                            print("error: ", error)
                        }
                    }
                }
                
                
            })
            
        } catch let error {
            print(error)
        }
    }
    
    ///MARK: GET REQUEST TO GET POSTAL CODE / COUNTRY NAME / FOR CURRENT LAT/ LANG
    func getCountryPostalCode(getLat: String,getLong: String,vc: UIViewController,completions: @escaping () -> ())  {
        
        do {
            
            try   Service.shared.getSearchResults(url: HelperClass.shared.getCountryPostalCode + getLat + "," + getLong +  HelperClass.shared.getCountryPostalCode2, vc: vc, completion: { result in
                
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        
                        
                        print(removeSlash)
                        
                        
                        //GETTING JSON STRING OBJECT
                        
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            
                            let getCountryPostalCode = try JSONDecoder().decode(ModelToGetCountyPostalCode.self, from: jsonData)
                            self.getCountryPostalCode = getCountryPostalCode
                            completions()
                            
                        } catch let DecodingError.dataCorrupted(context) {
                            print(context)
                        } catch let DecodingError.keyNotFound(key, context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.valueNotFound(value, context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch let DecodingError.typeMismatch(type, context)  {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                        } catch {
                            print("error: ", error)
                        }
                    }
                }
                
                
            })
            
        } catch let error {
            print(error)
        }
    }
    
    
    
    
    
    ///MARK: POST REQUEST
    func getHomeControllerDetails(postRequest: String,sendDataModel: ModelToRequestHomeDetails,vc : UIViewController, completion: @escaping () -> ()) {
        
        let jsonData = try! JSONEncoder().encode(sendDataModel)
        do {
            try Service.shared.postRequest(urls: postRequest, getModel: jsonData, vc: vc, completion: { result in
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        //GETTING JSON STRING OBJECT
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        print(removeSlash)
                        
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            let getHomeDetails = try JSONDecoder().decode(ModelToGetHomeDetails.self, from: jsonData)
                            
                            if getHomeDetails.status?.Result == 1{
                                self.getHomeControllerDetails = getHomeDetails
                                completion()
                            }else{
                                self.showError.showError(getError: "Invalid Response...", getMessage: "")
                            }
                            
                            
                        } catch let errors {
                            
                            self.showError.showError(getError: errors.localizedDescription, getMessage: "")
                            
                        }
                        
                    }
                }
            })
        } catch let errors {
            print(errors)
        }
    }
    
    
    ///MARK: TO GET RETAIL VERTICAL BASED ON SHOPPING TYPE
    
    func getFetchVerticalDetails(postRequest: String,sendDataModel: ModelToRequestRetailDetailsOfType,vc : UIViewController, completion: @escaping () -> ()) {
        
        let jsonData = try! JSONEncoder().encode(sendDataModel)
        do {
            try Service.shared.postRequest(urls: postRequest, getModel: jsonData, vc: vc, completion: { result in
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        //GETTING JSON STRING OBJECT
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        print(removeSlash)
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            let getRetailDetails = try JSONDecoder().decode(ModelToGetRetailForType.self, from: jsonData)
                            
                            if getRetailDetails.status?.Result == 1{
                                self.getFetchRetailOfType = getRetailDetails
                                completion()
                            }else{
                                self.showError.showError(getError: "Invalid Response...", getMessage: "")
                            }
                            
                            
                        } catch let errors {
                            
                            self.showError.showError(getError: errors.localizedDescription, getMessage: "")
                            
                        }
                        
                    }
                }
            })
        } catch let errors {
            print(errors)
        }
    }
    
    
    ///MARK: POST REQUEST FOR GETTING AND UPDATING ADDRESS FIELDS
    
    func getAddressDetails(postRequest: String,sendDataModel: ModelToGiveDevicePostal,vc : UIViewController, completion: @escaping (Int) -> ()) {
        
        
        let jsonData = try! JSONEncoder().encode(sendDataModel)
        do {
            
            try Service.shared.postRequest(urls: postRequest, getModel: jsonData, vc: vc, completion: { result in
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        //GETTING JSON STRING OBJECT
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        print(removeSlash)
                        
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            let getPostResponse = try JSONDecoder().decode(ModelToFetchAddressDetails.self, from: jsonData)
                            
                            if getPostResponse.status.Result == 1{
                                self.getAddressDetails = getPostResponse
                                completion(1)
                            }else{
                                //                                self.showError.showError(getError: "Invalid Response!", getMessage: "Problem in getting Server Response!")
                                completion(0)
                            }
                            
                        } catch let errors {
                            print(errors)
                            completion(0)
                        }
                        
                    }
                }
            })
        } catch let errors {
            print(errors)
        }
    }
    func postAddressEditDetails(postRequest: String,sendDataModel: ModelToUpdateAddress,vc : UIViewController, completion: @escaping (Int) -> ()) {
        
        let jsonData = try! JSONEncoder().encode(sendDataModel)
        do {
            try Service.shared.postRequest(urls: postRequest, getModel: jsonData, vc: vc, completion: { result in
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        //GETTING JSON STRING OBJECT
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        print(removeSlash)
                        
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            let getHomeDetails = try JSONDecoder().decode(ModelToGetUpdateResponse.self, from: jsonData)
                            
                            if getHomeDetails.status.Result == 1{
                                completion(1)
                            }else{
                                self.showError.showError(getError: "Invalid Response...", getMessage: "")
                                completion(0)
                            }
                            
                            
                        } catch let errors {
                            
                            self.showError.showError(getError: errors.localizedDescription, getMessage: "")
                            completion(0)
                        }
                        
                    }
                }
            })
        } catch let errors {
            print(errors)
        }
    }
    
    
    
    func postHomeControllerDetails(postRequest: String,sendDataModel: ModelToUpdateHomeDetails,vc : UIViewController, completion: @escaping () -> ()) {
        
        let jsonData = try! JSONEncoder().encode(sendDataModel)
        do {
            try Service.shared.postRequest(urls: postRequest, getModel: jsonData, vc: vc, completion: { result in
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        //GETTING JSON STRING OBJECT
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        print(removeSlash)
                        
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            let getHomeDetails = try JSONDecoder().decode(ModelToGetHomeDetailUpdateResponse.self, from: jsonData)
                            
                            if getHomeDetails.status.Result == 1{
                                completion()
                            }else{
                                self.showError.showError(getError: "Invalid Response...", getMessage: "")
                            }
                            
                            
                        } catch let errors {
                            
                            self.showError.showError(getError: errors.localizedDescription, getMessage: "")
                            
                        }
                        
                    }
                }
            })
        } catch let errors {
            print(errors)
        }
    }
    
    
    
}
