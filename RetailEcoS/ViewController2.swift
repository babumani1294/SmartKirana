//
//  ViewController2.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-25.
//

import UIKit
import Foundation

class ViewController2: UIViewController,letterPadAction,UIGestureRecognizerDelegate, letterUpperCasePadAction, NumberLetterPadProtocol {
    
    ///property:

    func NumberLetterPad(data: String, flag: String) {
//        if flag == "CLR"{
//            searchBar.text = ""
//        }
//        if flag == "DEL"{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = String(tempText.dropLast())
//        }
//        if flag == "CANCEL"{
//            NUMBERPAD?.removeFromSuperview()
//        }
//        if flag == "SPACE"{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = tempText + " "
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            NUMBERPAD?.removeFromSuperview()
//            customKeyBoardView?.addSubview(LETTERPAD!)
//        }
//        if flag == "123"{
//
//        }
//        if flag == "CANCELUPDATE"{
//            searchBar.text = ""
//        }
//        else{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = tempText + data
//        }
    }
    func updateUpperCaseLetter(data: String, flag: String) {
//        if flag == "CLR"{
//            searchBar.text = ""
//        }
//        if flag == "DEL"{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = String(tempText.dropLast())
//        }
//        if flag == "CANCEL"{
//            UPPERLETTERPAD?.removeFromSuperview()
//        }
//        if flag == "SPACE"{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = tempText + " "
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            UPPERLETTERPAD?.removeFromSuperview()
//            customKeyBoardView?.addSubview(LETTERPAD!)
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            customKeyBoardView?.addSubview(NUMBERPAD!)
//        }
//        if flag == "CANCELUPDATE"{
//            searchBar.text = ""
//        }
//        else{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = tempText + data
//        }
    }
    func updateLetter(data: String, flag: String) {
//        if flag == "CLR"{
//            searchBar.text = ""
//        }
//        if flag == "DEL"{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = String(tempText.dropLast())
//        }
//        if flag == "CANCEL"{
//            LETTERPAD?.removeFromSuperview()
//        }
//        if flag == "SPACE"{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = tempText + " "
//        }
//        if flag == "CASE"{
//
//        }
//        if flag == "SHIFT"{
//            LETTERPAD?.removeFromSuperview()
//            customKeyBoardView?.addSubview(UPPERLETTERPAD!)
//        }
//        if flag == "NUMBER"{
//            LETTERPAD?.removeFromSuperview()
//            customKeyBoardView?.addSubview(NUMBERPAD!)
//        }
//        if flag == "CANCELUPDATE"{
//            searchBar.text = ""
//        }
//        else{
//            let tempText = searchBar.text ?? ""
//            searchBar.text = tempText + data
//        }
    }
    func searchproduct() {
        return
    }
    
    @IBOutlet weak var customKeyBoardView: UIView!
    
    let LETTERPAD = Bundle.main.loadNibNamed("LetterPad", owner: nil, options: nil)?.first as? LetterPad
    let UPPERLETTERPAD = Bundle.main.loadNibNamed("UpperLetterPad", owner: nil, options: nil)?.first as? UpperLetterPad
    let NUMBERPAD = Bundle.main.loadNibNamed("NumberLetterPad", owner: nil, options: nil)?.first as? NumberLetterPad
    

    override func viewDidLoad() {
        super.viewDidLoad()
        LETTERPAD?.frame.size.width = (self.customKeyBoardView?.frame.width)!
        LETTERPAD?.frame.size.height = (self.customKeyBoardView?.frame.height)!
        LETTERPAD?.delegateAction = self
        UPPERLETTERPAD?.frame.size.width = (self.customKeyBoardView?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.customKeyBoardView?.frame.height)!
        UPPERLETTERPAD?.delegateAction = self
        NUMBERPAD?.frame.size.width = (self.customKeyBoardView?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.customKeyBoardView?.frame.height)!
        NUMBERPAD?.delegateAction = self
        
        customKeyBoardView?.addSubview(LETTERPAD!)
    }
    


}
