//
//  HomeControllerViewModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-10.
//

import Foundation
import UIKit

class HomeControllerViewModel {
    ///mark: property
    var getHomeControllerDetails: HomeControllerModel!
    var getCountryPickerDetails: CountryNameModel!
    var showError : showError!
    
    ///mark: function
    
    func getCountryName(vc: UIViewController,completions: @escaping () -> ())  {
        
        do {
            
            try Service.shared.postRequest(urls: HelperClass.shared.getCountryName, getModel: nil, vc: vc, completion: { result in
                
                
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
    
    func getHomeControllerDetails(postRequest: String,sendDataModel: DeviceID,vc : UIViewController, completion: @escaping () -> ()) {
        
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
                            let getHomeDetails = try JSONDecoder().decode(HomeControllerModel.self, from: jsonData)
                            
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
    
    
}
