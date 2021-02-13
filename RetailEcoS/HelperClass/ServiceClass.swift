//
//  ServiceClass.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-01.
//

import Foundation
import UIKit


class Service{
    
    ///mark: property
    static var shared = Service()
    var showErrors : showError!
    
    typealias returnType = (Data?) -> Void
    
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    typealias JSONDictionary = [String: Any]
    
    var errorMessage = ""
    
    
    
    ///mark: function
    ///Get Request
    func getSearchResults(url: String,vc: UIViewController, completion: @escaping returnType) throws {
        
        showErrors = vc as! showError
        //        throw errors.networkFailure
        print(showErrors)
        print(url)
        
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        request.setValue("cce618086bfccd93b47dd9d4cf06f52778515b5d", forHTTPHeaderField: "TokenNo")
        
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            
            defer {
                self.dataTask = nil
            }
            
            //VALIDATING RESPONSE:
            
            if let error = error {
                self.errorMessage += "DataTask error: " +
                    error.localizedDescription + "\n"
                self.showErrors.showError(getError: "Failed To Connect!", getMessage: "check you Internet Connection!")
            } else if
                
                let response = response as? HTTPURLResponse,
                
                response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    completion(data!)
                }
                
                
            }else{
                self.showErrors.showError(getError: "Something Went Wrong", getMessage: "")
            }
            
        })
        
        
        //STARTS HTTP REQUEST
        
        dataTask?.resume()
        
        
    }
    
    
    
    
    ///Post Request
    func postRequest(urls: String,getModel: Data?,vc: UIViewController,completion: @escaping returnType) throws {
        
        showErrors = vc as! showError
        
        //create the url with NSURL
        
        let url = URL(string: urls)!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.setValue("cce618086bfccd93b47dd9d4cf06f52778515b5d", forHTTPHeaderField: "TokenNo")
        request.httpMethod = "POST" //set http method as POST
        
        if let getMethodBody = getModel{
            request.httpBody = getModel
        }else{
            
        }
        
        //create dataTask using the session object to send data to the server
        let dataTask = session.dataTask(with: request, completionHandler: { data, response, error in
            
            defer {
                self.dataTask = nil
            }
            
            //VALIDATING RESPONSE:
            
            if let error = error {
                self.errorMessage += "DataTask error: " +
                    error.localizedDescription + "\n"
                self.showErrors.showError(getError: "Failed To Connect", getMessage: "check you Internet Connection!")
                
            } else if
                
                let response = response as? HTTPURLResponse,
                
                response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    completion(data!)
                }
                
            }else{
                self.showErrors.showError(getError: "Wrong Status Code", getMessage: " ")
            }
            
        })
        
        dataTask.resume()
    }
}

