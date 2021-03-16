//
//  RegistrationController.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-03-04.
//

import UIKit
var selectedTxtField: Int?
class RegistrationController: UIViewController  {
    
    ///MARK: PROPERTY
    
    //    var donePressed : donePressed!
    
    let LETTERPAD = Bundle.main.loadNibNamed("LetterPad", owner: nil, options: nil)?.first as? LetterPad
    let UPPERLETTERPAD = Bundle.main.loadNibNamed("UpperLetterPad", owner: nil, options: nil)?.first as? UpperLetterPad
    let NUMBERPAD = Bundle.main.loadNibNamed("NumberLetterPad", owner: nil, options: nil)?.first as? NumberLetterPad
    
    
    
    ///MARK: OUTLET
    @IBOutlet weak var viewCustomKeyboard: UIView!
   
    @IBOutlet weak var imgHome: UIImageView!
    
    
    ///MARK: ACTION
    
    @IBAction func btnHome(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{
            imgHome.image = UIImage(named: "imgSave")
        }else{
            imgHome.image = UIImage(named: "imgHome")
        }
    }
    @IBOutlet weak var btnHome: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
    }
    
    ///MARK: FUNCTION
    
    func initialConfig() {
        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.delegateAction = self
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        UPPERLETTERPAD?.delegateAction = self
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        NUMBERPAD?.delegateAction = self
        
        
//        for i in txtEdtGroup2{
////            i.delegate = self
//            i.layer.borderWidth = 1
//            i.layer.borderColor = UIColor.lightGray.cgColor
//            i.tintColor = .black
//        }
        
        
    }
    
}


///MARK: EXTENSIONS

//extension RegistrationController: letterPadAction, letterUpperCasePadAction, NumberLetterPadProtocol{
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
//
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
//                        if i.text.count < 5{
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
//            UPPERLETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(LETTERPAD!)
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(NUMBERPAD!)
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
//            viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(NUMBERPAD!)
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
//
//}


//extension RegistrationController: UITextFieldDelegate,UITextViewDelegate{
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        selectedTxtField = textView.tag
//
//        switch textView.tag {
//        case 0:
//            textView.resignFirstResponder()
//            self.viewCustomKeyboard.addSubview(NUMBERPAD!)
//        case 1:
//            textView.resignFirstResponder()
//            self.viewCustomKeyboard.addSubview(NUMBERPAD!)
//        case 2:
//            textView.resignFirstResponder()
//            self.viewCustomKeyboard.addSubview(NUMBERPAD!)
//
//        default :
//            print("")
//
//        }
//    }
//    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
//        return true
//    }
//}
