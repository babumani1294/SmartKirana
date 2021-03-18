//
//  RetailSelectionViewModel.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-03.
//

import Foundation
import UIKit

class RetailSelectionViewModel {
    
    var getRetailDetails: ModelToGetRetailDetails!
    var showError : showError!
    
    
    func getRetailVerticalDetails(postRequest: String,sendDataModel: DeviceID,vc : UIViewController, completion: @escaping () -> ()) {
        
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
                        
                        let jsonData = removeSlash.data(using: .utf8)!
                        
                        do {
                            //DECODING JSON STRING OBJECT TO MODEL
                            let getRetailDetails = try JSONDecoder().decode(ModelToGetRetailDetails.self, from: jsonData)
                            
                            if getRetailDetails.status.Result == 1{
                                self.getRetailDetails = getRetailDetails
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
    
    ///MARK: POST REQUEST
    func updateSelectedRetailDetail(postRequest: String,sendDataModel: ModelUpdateRetailDetails,vc : UIViewController, completion: @escaping () -> ()) {
        
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
                            let getHomeDetails = try JSONDecoder().decode(ModelToGetUpdateRetailResponse.self, from: jsonData)
                            
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
