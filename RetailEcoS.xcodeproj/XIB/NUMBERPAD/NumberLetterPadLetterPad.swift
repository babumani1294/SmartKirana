//
//  NumberPad.swift
//  SmartKiranaPOS
//
//  Created by suraj kumar on 23/10/1942 Saka.
//

import Foundation
import UIKit

protocol NumberLetterPadProtocol:class {
    func NumberLetterPad(data:String,flag:String)
}

class NumberLetterPad: UIView {
    var isLoading = Bool()
    weak var delegateAction : NumberLetterPadProtocol?
    
    @IBAction func keyPressed(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        guard let title = sender.titleLabel?.text else {
            switch button.tag {
            case 100:
                delegateAction?.NumberLetterPad(data: "", flag: "SHIFT")
            case 101:
                delegateAction?.NumberLetterPad(data: "", flag: "DEL")
            case 102:
                delegateAction?.NumberLetterPad(data: "", flag: "NUMBER")
            case 103:
                delegateAction?.NumberLetterPad(data: "", flag: "GLOBLE")
            default:
                delegateAction?.NumberLetterPad(data: "", flag: "CANCEL")
                return
            }
           return
        }
        if (title == "SPACE"){
            delegateAction?.NumberLetterPad(data: " ", flag: "SPACE")
            return
        }
        if (title == "NEXT"){
            return
        }
        if (title == "123"){
            delegateAction?.NumberLetterPad(data: "", flag: "NUMBER")
            return
        }
        if (title == "ABC"){
            delegateAction?.NumberLetterPad(data: "", flag: "SHIFT")
            return
        }
        delegateAction?.NumberLetterPad(data: title, flag: title)
    }
    
    @IBAction func CANCELACTION(_ sender: Any) {
        delegateAction?.NumberLetterPad(data: "", flag: "CANCELUPDATE")
    }
    @IBAction func DONEACTION(_ sender: Any) {
        delegateAction?.NumberLetterPad(data: "", flag: "CANCEL")
    }
    
}
