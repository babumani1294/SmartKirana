//
//  CustomMobRegisterScreen.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-03-04.
//

import Foundation
import UIKit


@IBDesignable
class CustomMobRegisterScreen: UIView,letterPadAction,UIGestureRecognizerDelegate, letterUpperCasePadAction, NumberLetterPadProtocol {
    
    ///MARK: PROPERTY
    
    var donePressed : donePressed!
    var currentLable: UILabel?
    var nextArray: [UILabel] = []
    
    
    
    
    let LETTERPAD = Bundle.main.loadNibNamed("LetterPad", owner: nil, options: nil)?.first as? LetterPad
    let UPPERLETTERPAD = Bundle.main.loadNibNamed("UpperLetterPad", owner: nil, options: nil)?.first as? UpperLetterPad
    let NUMBERPAD = Bundle.main.loadNibNamed("NumberLetterPad", owner: nil, options: nil)?.first as? NumberLetterPad
    
    
    ///MARK: OUTLET
    
    @IBOutlet var txtEdtGroup2: [UITextView]!
    @IBOutlet weak var txtEdtCountryCode: UITextView!
    @IBOutlet weak var txtEdtMobNumber1: UITextView!
    @IBOutlet weak var viewCustomKeyboard: UIView!
    @IBOutlet weak var lblMobileNumber: UILabel!
    
    @IBOutlet var lblGroup: [UILabel]!
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initiateView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initiateView()
    }
    
    func initiateView() {
        
        var bundle = Bundle(for: type(of: self))
        var nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        var view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        
        
        for i in txtEdtGroup2{
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.tintColor = .black
        }
        for i in lblGroup{
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.tintColor = .black
        }
       
        
        
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.delegateAction = self
//        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        UPPERLETTERPAD?.delegateAction = self
//        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        NUMBERPAD?.delegateAction = self
        
        
        let tapMobileNumber = UITapGestureRecognizer(target: self, action: #selector(tapMobileNumber(sender:)))
        lblMobileNumber.addGestureRecognizer(tapMobileNumber)
        lblMobileNumber.isUserInteractionEnabled = true
        nextArray.append(lblMobileNumber)
        
        LETTERPAD?.delegateAction = self
        UPPERLETTERPAD?.delegateAction = self
        NUMBERPAD?.delegateAction = self
        
        addSubview(view)
        
    }
    
    
    @objc func tapMobileNumber(sender: UITapGestureRecognizer){
        selectedTxtField = lblMobileNumber.tag
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblMobileNumber
        //        new.backgroundColor = .clear
        for i in lblGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        
        viewCustomKeyboard?.addSubview(NUMBERPAD!)
        
    }
    
//    func searchproduct() {
//        return
//    }
//
//    func NumberLetterPad(data: String, flag: String) {
//        if flag == "CLR"{
//            //            txtAddress1.text = ""
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    i.text = ""
//                }
//            }
//        }
//        if flag == "DEL"{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = String(tempText.dropLast())
//                }
//            }
//        }
//        if flag == "CANCEL"{
//            NUMBERPAD?.removeFromSuperview()
//            donePressed.DonePressed()
//        }
//        if flag == "SPACE"{
//
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = tempText + " "
//                }
//            }
//
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            //            NUMBERPAD?.removeFromSuperview()
//            //            viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
//
//        }
//        if flag == "123"{
//
//        }
//        if flag == "CANCELUPDATE"{
//
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    i.text = ""
//                }
//            }
//        }
//        else{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//
//                    switch selectedTxtField {
//                    case 0:
//                        if i.text.count < 2{
//                            i.text = tempText + data
//                        }
//
//                    case 1:
//                        if i.text.count < 11{
//                            i.text = tempText + data
//                        }
//
//                    default:
//                        print("")
//                    }
//
//                }
//            }
//        }
//    }
//    func updateUpperCaseLetter(data: String, flag: String) {
//        if flag == "CLR"{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    i.text = ""
//                }
//            }
//        }
//        if flag == "DEL"{
//
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = String(tempText.dropLast())
//                }
//            }
//        }
//        if flag == "CANCEL"{
//            UPPERLETTERPAD?.removeFromSuperview()
//            donePressed.DonePressed()
//        }
//        if flag == "SPACE"{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = tempText + " "
//
//                }
//            }
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            UPPERLETTERPAD?.removeFromSuperview()
//            //            viewCustomKeyboard?.addSubview(LETTERPAD!)
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            //            viewCustomKeyboard?.addSubview(NUMBERPAD!)
//        }
//        if flag == "CANCELUPDATE"{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    i.text = ""
//
//                }
//            }
//        }
//        else{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = tempText + data
//
//                }
//            }
//        }
//    }
//    func updateLetter(data: String, flag: String) {
//        if flag == "CLR"{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    i.text = ""
//
//                }
//            }
//        }
//        if flag == "DEL"{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = String(tempText.dropLast())
//
//                }
//            }
//        }
//        if flag == "CANCEL"{
//            LETTERPAD?.removeFromSuperview()
//
//        }
//        if flag == "SPACE"{
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = tempText + " "
//
//                }
//            }
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            LETTERPAD?.removeFromSuperview()
//            //            viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            //            viewCustomKeyboard?.addSubview(NUMBERPAD!)
//        }
//        if flag == "CANCELUPDATE"{
//
//
//            for i in txtEdtGroup2{
//                if i.tag == selectedTxtField{
//                    i.text = ""
//
//                }
//            }
//        }
//        else{
//
//            for i in txtEdtGroup2{
//
//                if i.tag == selectedTxtField{
//                    let tempText = i.text ?? ""
//                    i.text = tempText + data
//
//                }
//            }
//        }
//    }
    
    
    
    func NumberLetterPad(data: String, flag: String) {
        if flag == "CLR"{
            currentLable?.text = ""
        }
        if flag == "DEL"{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = String(tempText.dropLast())
        }
        if flag == "CANCEL"{
            currentLable?.backgroundColor = .clear
            viewCustomKeyboard.isHidden = true
            NUMBERPAD?.removeFromSuperview()
            donePressed.DonePressed()
        }
        if flag == "SPACE"{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = tempText + " "
        }
        if flag == "CASE"{
            
        }
        if flag == "NEXT"{
            var currentNextIndex : Int?
            for (index,temp) in nextArray.enumerated(){
                if temp == currentLable{
                    currentNextIndex = index
                }
            }
            if currentNextIndex == (nextArray.count - 1){
                currentLable = nextArray[0]
            }
            else{
                currentLable = nextArray[currentNextIndex! + 1]
            }
        }
        if flag == "SHIFT"{
            NUMBERPAD?.removeFromSuperview()
            viewCustomKeyboard?.addSubview(LETTERPAD!)
        }
        if flag == "123"{
            
        }
        if flag == "CANCELUPDATE"{
            
            currentLable?.text = ""
        }
        else{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = tempText + data
        }
    }
    func updateUpperCaseLetter(data: String, flag: String) {
        if flag == "CLR"{
            //            searchBar.text = ""
        }
        if flag == "DEL"{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = String(tempText.dropLast())
        }
        if flag == "CANCEL"{
            currentLable?.backgroundColor = .clear
            viewCustomKeyboard.isHidden = true
            UPPERLETTERPAD?.removeFromSuperview()
            donePressed.DonePressed()
        }
        if flag == "SPACE"{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = tempText + " "
        }
        if flag == "CASE"{
            
        }
        if flag == "SHIFT"{
            UPPERLETTERPAD?.removeFromSuperview()
            viewCustomKeyboard?.addSubview(LETTERPAD!)
        }
        if flag == "NEXT"{
            var currentNextIndex : Int?
            for (index,temp) in nextArray.enumerated(){
                if temp == currentLable{
                    currentNextIndex = index
                }
                else{
                    temp.backgroundColor = .clear
                }
            }
            if currentNextIndex == (nextArray.count - 1){
                currentLable = nextArray[0]
            }
            else{
                currentLable = nextArray[currentNextIndex! + 1]
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }
        }
        if flag == "NUMBER"{
            LETTERPAD?.removeFromSuperview()
            viewCustomKeyboard?.addSubview(NUMBERPAD!)
        }
        if flag == "CANCELUPDATE"{
            currentLable?.text = ""
        }
        else{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = tempText + data
        }
    }
    
    func updateLetter(data: String, flag: String) {
        if flag == "CLR"{
            //            searchBar.text = ""
        }
        if flag == "DEL"{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = String(tempText.dropLast())
        }
        if flag == "CANCEL"{
            currentLable?.backgroundColor = .clear
            viewCustomKeyboard.isHidden = true
            LETTERPAD?.removeFromSuperview()
            donePressed.DonePressed()
        }
        if flag == "SPACE"{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = tempText + " "
        }
        if flag == "CASE"{
            
        }
        if flag == "SHIFT"{
            LETTERPAD?.removeFromSuperview()
            viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        }
        if flag == "NEXT"{
            var currentNextIndex : Int?
            for (index,temp) in nextArray.enumerated(){
                if temp == currentLable{
                    currentNextIndex = index
                    temp.backgroundColor = .clear
                }
            }
            if currentNextIndex == (nextArray.count - 1){
                currentLable = nextArray[0]
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }
            else{
                currentLable = nextArray[currentNextIndex! + 1]
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }
        }
        if flag == "NUMBER"{
            LETTERPAD?.removeFromSuperview()
            viewCustomKeyboard?.addSubview(NUMBERPAD!)
        }
        if flag == "CANCELUPDATE"{
            currentLable?.text = ""
        }
        else{
            let tempText = currentLable?.text ?? ""
            currentLable?.text = tempText + data
        }
    }
    func searchproduct() {
        return
    }
    
    
    
}
