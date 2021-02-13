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
    var showError : showError!
    
    ///mark: function
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




//
//\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n \r\n {\"session\":{\"SessionMessage\":\"Login Valid\",\"SessionResult\":1},\"status\":{\"Message\":\"Success\",\"Service_Name\":\"Your Retail Business Partner\",\"cur_symbol\":\"$\",\"Technology_Name\":\"This solution is from\",\"Result\":1,\"Technology_Logo\":\"https://www.smartkirana.ca/retailecos/Logo/TechnologyLogoCanada.png\",\"Header_Logo\":\"https://www.smartkirana.ca/retailecos/Logo/HeaderLogoCanada.png\",\"cur_code\":\"CAD\",\"name\":\"Canada\",\"Company_Name\":\"RetailEcoS\",\"Service_Logo\":\"https://www.smartkirana.ca/retailecos/Logo/ServiceLogoCanada.png\",\"Company_Logo\":\"https://www.smartkirana.ca/retailecos/Logo/CompanyLogoCanada.png\",\"First_Time_User\":\"N\"}}\n


//{"session":{"SessionMessage":"Login Valid","SessionResult":1},"status":{"Service_Lapse_Time":3,"Company_Lapse_Time":2,"Message":"Success","Service_Name":"Your Retail Business Partner","Technology_Lapse_Time":3,"Technology_Name":"This solution is from","Result":1,"Technology_Logo":"https://www.smartkirana.ca/retailecos/Logo/https://www.smartkirana.ca/customer/Logo/TechnologyLogo.png","Header_Logo":"https://www.smartkirana.ca/retailecos/Logo/","Company_Name":"RetailEcoS","Service_Logo":"https://www.smartkirana.ca/retailecos/Logo/https://www.smartkirana.ca/customer/Logo/ServiceLogo.png","Company_Logo":"https://www.smartkirana.ca/retailecos/Logo/https://www.smartkirana.ca/customer/Logo/CompanyLogo.png","Country_Name":"United States","First_Time_User":"Y","Currency_Code":"USD","Currency_Symbol":"$"}}



