//
//  HelperClass.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2020-12-25.
//

import Foundation
import UIKit

class HelperClass {
    static var shared  =  HelperClass()
}

///mark: extensions
extension UIView{
    func shadowEffects(shadow: Shadow,getView: UIView){
       
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
            
            getView.layer.cornerRadius = 5
            getView.layer.borderWidth = 1
            getView.layer.borderColor = UIColor.blue.cgColor
            getView.layer.masksToBounds = false
            getView.layer.shadowColor = UIColor.lightGray.cgColor
            getView.layer.shadowOffset = CGSize(width: 4, height: 4)
            getView.layer.shadowRadius = 4
            getView.layer.shadowOpacity = 10
        default:
            print("shadow")
        }
        
        
       

    }
}

enum Shadow {
    case DarkShadow
    case LightShadow
    case WithBorder
}
