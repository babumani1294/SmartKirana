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
    var retryRequest: retryRequest!
    var getPost : Int?
    var getUrl : String?
    var getVc : UIViewController?
    
    var postUrl : String?
    var postModel : Data?
    var postVc : UIViewController?
    
    typealias returnType = (Data?) -> Void
    
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    typealias JSONDictionary = [String: Any]
    var errorMessage = ""
    
    
    
    ///mark: function
    ///MARK: GET REQUEST
    func getSearchResults(url: String,vc: UIViewController, completion: @escaping returnType) throws {

        showErrors = vc as! showError
        
        let url = URL(string: url)!
        print(url)
        var request = URLRequest(url: url)
        ///MARK: SETTING UP WITH HEADER
        request.setValue("cce618086bfccd93b47dd9d4cf06f52778515b5d", forHTTPHeaderField: "TokenNo")

        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in

            defer {
                self.dataTask = nil
            }

            //VALIDATING RESPONSE:

            if let error = error {
                self.errorMessage += "DataTask error: " +
                    error.localizedDescription + "\n"
                print(self.errorMessage)
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
    
    ///MARK: POST REQUEST
    func postRequest(urls: String,getModel: Data?,vc: UIViewController,completion: @escaping returnType) throws {

        showErrors = vc as! showError

        //create the url with NSURL

        let url = URL(string: urls)!
        print(url)
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
                print(self.errorMessage)
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
