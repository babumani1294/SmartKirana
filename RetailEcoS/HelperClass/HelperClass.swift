//
//  HelperClass.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2020-12-25.
//

import Foundation
import UIKit
var getDone: donePressed!
class HelperClass {
    ///mark: property
    static var shared  =  HelperClass()
    
    
    ///Post Request
   
    var urlFetchCompanyDetails = "https://www.smartkirana.ca/retailecos/api/fetchSplash"
    var permissionFetch = "https://www.smartkirana.ca/retailecos/api/fetchPermission"
    var permissionUpdate = "https://www.smartkirana.ca/retailecos/api/updatePermission"
    var getHomeDetails = "https://www.smartkirana.ca/retailecos/api/fetchMenu"
    
    ///Get Request
    var getCountryPostalCode = "https://maps.googleapis.com/maps/api/geocode/json?latlng="
    var getCountryPostalCode2 = "&key=AIzaSyDho6YqRH605Poc-S0AcShQu4hLYDUMGpk"
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
            print("shadow")
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
        //        self.resignFirstResponder()
    }
    @objc func cancelButtonAction()
    {
        self.resignFirstResponder()
    }
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



protocol donePressed{
    func DonePressed()
}
protocol showError {
    func showError(getError: String,getMessage: String)
}

protocol cellSwitch {
    func cellSwitch(cellIndex: UITableViewCell,cellSwitch: UISwitch)
}
