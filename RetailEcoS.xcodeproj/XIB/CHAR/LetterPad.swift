//
//  NumberPad.swift
//  SmartKiranaPOS
//
//  Created by suraj kumar on 23/10/1942 Saka.
//

import Foundation
import UIKit

protocol letterPadAction:class {
    func updateLetter(data:String,flag:String)
    func searchproduct()
}

class LetterPad: UIView {
    var isLoading = Bool()
    weak var delegateAction : letterPadAction?
    
    @IBAction func keyPressed(sender: AnyObject) {
        guard let button = sender as? UIButton else {
            return
        }
        guard let title = sender.titleLabel?.text else {
            switch button.tag {
            case 100:
                delegateAction?.updateLetter(data: "", flag: "SHIFT")
            case 101:
                delegateAction?.updateLetter(data: "", flag: "DEL")
            case 102:
                delegateAction?.updateLetter(data: "", flag: "NUMBER")
            case 103:
                delegateAction?.updateLetter(data: "", flag: "GLOBLE")
            default:
                delegateAction?.updateLetter(data: "", flag: "CANCEL")
                return
            }
           return
        }
        if (title == "SPACE"){
            delegateAction?.updateLetter(data: " ", flag: "SPACE")
            return
        }
        if (title == "NEXT"){
            return
        }
        if (title == "123"){
            delegateAction?.updateLetter(data: "", flag: "NUMBER")
            return
        }
        delegateAction?.updateLetter(data: title, flag: title)
    }
    
    @IBAction func CANCELACTION(_ sender: Any) {
        delegateAction?.updateLetter(data: "", flag: "CANCELUPDATE")
    }
    @IBAction func DONEACTION(_ sender: Any) {
        delegateAction?.updateLetter(data: "", flag: "CANCEL")
    }
    
}
