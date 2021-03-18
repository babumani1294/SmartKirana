//
//  MobileRegisterViewModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-01.
//

import Foundation
import UIKit

class SplashViewModel {
    
    ///mark: property
    var getCompanyDetails: ModelToFetchCompanyDetails!
    var getCountryPostalCode: ModelToGetCountyPostalCode!
    var getCountryTimeZone: ModelToGetCountyTimeZone!
    var showError : showError!
    
    ///mark: function
    ///
    ///mark:  getrequest to get postal code, country name for current lat/long.
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
    
    ///mark: getrequest to get Timezone for present country
    func getCountryTimeZone(getLat: String,getLong: String,getTimeStamp: String,vc: UIViewController,completions: @escaping () -> ())  {
        
        do {
            
            try   Service.shared.getSearchResults(url: HelperClass.shared.getCountryTimeZone + getLat + "," + getLong +  HelperClass.shared.getCountryTimeZone2 + getTimeStamp + HelperClass.shared.getCountryTimeZone3  , vc: vc, completion: { result in
                
                
                //GETTING DATA FROM URL IN  RESULT:
                if let data = result {
                    
                    //CONVERTING DATA TO JSON STRING
                    if let jsonString = String(data: data, encoding: .utf8) {
                        
                        var new = jsonString
                        
                        var removeSlash = new.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range:nil)
                        
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
    
    
    
    ///mark: post request to get company details for current country
    func getCompanyDetails(postRequest: String,sendDataModel: ModelToGiveCountry,vc : UIViewController, completion: @escaping () -> ()) {
        
        
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
                            let getPostResponse = try JSONDecoder().decode(ModelToFetchCompanyDetails.self, from: jsonData)
                            
                            if getPostResponse.status.Result == 1{
                                self.getCompanyDetails = getPostResponse
                                completion()
                            }else{
                                self.showError.showError(getError: "Invalid Response!", getMessage: "Problem in getting Server Response!")
                            }
                            
                            
                        } catch let errors {
                            
                            print(errors)
                            
                        }
                        
                    }
                }
            })
        } catch let errors {
            print(errors)
        }
    }
    
}


