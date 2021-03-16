//
//  AddressEditController.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-03-08.
//

import UIKit

class AddressEditController: UIViewController {

    
///MARK: PROPERTY
    @IBOutlet weak var viewCustomKeyboard: UIView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}


///MARK: EXTENSION

//extension AddressEditController:letterPadAction,UIGestureRecognizerDelegate, letterUpperCasePadAction, NumberLetterPadProtocol{
//    func NumberLetterPad(data: String, flag: String) {
//        if flag == "CLR"{
//            currentLable?.text = ""
//        }
//        if flag == "DEL"{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = String(tempText.dropLast())
//        }
//        if flag == "CANCEL"{
//            currentLable?.backgroundColor = .clear
//            viewCustomKeyboard.isHidden = true
//            NUMBERPAD?.removeFromSuperview()
//        }
//        if flag == "SPACE"{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = tempText + " "
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "NEXT"{
//            var currentNextIndex : Int?
//            for (index,temp) in nextArray.enumerated(){
//                if temp == currentLable{
//                    currentNextIndex = index
//                }
//            }
//            if currentNextIndex == (nextArray.count - 1){
//                currentLable = nextArray[0]
//            }
//            else{
//                currentLable = nextArray[currentNextIndex! + 1]
//            }
//        }
//        if flag == "SHIFT"{
//            NUMBERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(LETTERPAD!)
//        }
//        if flag == "123"{
//
//        }
//        if flag == "CANCELUPDATE"{
//
//            currentLable?.text = ""
//        }
//        else{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = tempText + data
//        }
//    }
//    func updateUpperCaseLetter(data: String, flag: String) {
//        if flag == "CLR"{
////            searchBar.text = ""
//        }
//        if flag == "DEL"{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = String(tempText.dropLast())
//        }
//        if flag == "CANCEL"{
//            currentLable?.backgroundColor = .clear
//            viewCustomKeyboard.isHidden = true
//            UPPERLETTERPAD?.removeFromSuperview()
//        }
//        if flag == "SPACE"{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = tempText + " "
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            UPPERLETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(LETTERPAD!)
//        }
//        if flag == "NEXT"{
//            var currentNextIndex : Int?
//            for (index,temp) in nextArray.enumerated(){
//                if temp == currentLable{
//                    currentNextIndex = index
//                }
//                else{
//                    temp.backgroundColor = .clear
//                }
//            }
//            if currentNextIndex == (nextArray.count - 1){
//                currentLable = nextArray[0]
//            }
//            else{
//                currentLable = nextArray[currentNextIndex! + 1]
//                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
//            }
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(NUMBERPAD!)
//        }
//        if flag == "CANCELUPDATE"{
//            currentLable?.text = ""
//        }
//        else{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = tempText + data
//        }
//    }
//    func updateLetter(data: String, flag: String) {
//        if flag == "CLR"{
////            searchBar.text = ""
//        }
//        if flag == "DEL"{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = String(tempText.dropLast())
//        }
//        if flag == "CANCEL"{
//            currentLable?.backgroundColor = .clear
//            viewCustomKeyboard.isHidden = true
//            LETTERPAD?.removeFromSuperview()
//        }
//        if flag == "SPACE"{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = tempText + " "
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            LETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
//        }
//        if flag == "NEXT"{
//            var currentNextIndex : Int?
//            for (index,temp) in nextArray.enumerated(){
//                if temp == currentLable{
//                    currentNextIndex = index
//                    temp.backgroundColor = .clear
//                }
//            }
//            if currentNextIndex == (nextArray.count - 1){
//                currentLable = nextArray[0]
//                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
//            }
//            else{
//                currentLable = nextArray[currentNextIndex! + 1]
//                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
//            }
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(NUMBERPAD!)
//        }
//        if flag == "CANCELUPDATE"{
//            currentLable?.text = ""
//        }
//        else{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = tempText + data
//        }
//    }
//    func searchproduct() {
//        return
//    }
//}
