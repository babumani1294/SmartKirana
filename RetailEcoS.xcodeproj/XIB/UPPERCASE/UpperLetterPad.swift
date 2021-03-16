//
//  NumberPad.swift
//  SmartKiranaPOS
//
//  Created by suraj kumar on 23/10/1942 Saka.
//

import Foundation
import UIKit

protocol letterUpperCasePadAction:class {
    func updateUpperCaseLetter(data:String,flag:String)
}

class UpperLetterPad: UIView {
    var isLoading = Bool()
    weak var delegateAction : letterUpperCasePadAction?
    
    @IBAction func keyPressed(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        guard let title = sender.titleLabel?.text else {
            switch button.tag {
            case 100:
                delegateAction?.updateUpperCaseLetter(data: "", flag: "SHIFT")
            case 101:
                delegateAction?.updateUpperCaseLetter(data: "", flag: "DEL")
            case 102:
                delegateAction?.updateUpperCaseLetter(data: "", flag: "NUMBER")
            case 103:
                delegateAction?.updateUpperCaseLetter(data: "", flag: "GLOBLE")
            default:
                delegateAction?.updateUpperCaseLetter(data: "", flag: "CANCEL")
                return
            }
           return
        }
        if (title == "SPACE"){
            delegateAction?.updateUpperCaseLetter(data: " ", flag: "SPACE")
            return
        }
        if (title == "NEXT"){
            return
        }
        if (title == "123"){
            delegateAction?.updateUpperCaseLetter(data: "", flag: "NUMBER")
            return
        }
        delegateAction?.updateUpperCaseLetter(data: title, flag: title)
    }
    @IBAction func CANCELACTION(_ sender: Any) {
        delegateAction?.updateUpperCaseLetter(data: "", flag: "CANCELUPDATE")
    }
    @IBAction func DONEACTION(_ sender: Any) {
        delegateAction?.updateUpperCaseLetter(data: "", flag: "CANCEL")
    }
    
}
