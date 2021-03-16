//
//  CustomAddressEdit.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-22.
//

import Foundation
import UIKit

var selectedId  : Int?
var selectedTxtView: Int?
@IBDesignable
class CustomAddressEdit: UIView,letterPadAction,UIGestureRecognizerDelegate, letterUpperCasePadAction, NumberLetterPadProtocol {
    ///mark: property
    var btnClick: alertButtonclickEvent!
    var donePressed : donePressed!
    var view: UIView!
    
    var storedDeviceId: String?
    var storedCountryId : String?
    var receivedDeviceId: String?
    var receivedCountryId: String?
    
    var currentLable: UILabel?
    var nextArray: [UILabel] = []
    
//    let LETTERPAD = Bundle.main.loadNibNamed("LetterPad", owner: nil, options: nil)?.first as? LetterPad
    let UPPERLETTERPAD = Bundle.main.loadNibNamed("UpperLetterPad", owner: nil, options: nil)?.first as? UpperLetterPad
    let NUMBERPAD = Bundle.main.loadNibNamed("NumberLetterPad", owner: nil, options: nil)?.first as? NumberLetterPad
    
    
    ///mark: outlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var btnGroup: [UIButton]!
    @IBOutlet var txtViewGroup: [UITextView]!
    @IBOutlet var txtViewGroup2: [UITextView]!
    @IBOutlet weak var txtFirstName: UITextView!
    @IBOutlet weak var txtLastName: UITextView!
    @IBOutlet weak var txtAddress1: UITextView!
    @IBOutlet weak var txtAddress2: UITextView!
    @IBOutlet weak var txtLocality: UITextView!
    @IBOutlet weak var txtCity: UITextView!
    @IBOutlet weak var txtState: UITextView!
    @IBOutlet weak var txtPostalCode: UITextView!
    @IBOutlet weak var viewCustomKeyboard: UIView!
    @IBOutlet weak var txtCcode: UITextView!
    @IBOutlet weak var txtAcode: UITextView!
    @IBOutlet weak var txtMnumber: UITextView!
    
    
    
    ///MARK: OUTLET FOR NEWLY ADDED LABEL
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblAddress1: UILabel!
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var lblLocality: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblPostalCode: UILabel!
    @IBOutlet weak var lblCcode: UILabel!
    @IBOutlet weak var lblMnumber: UILabel!
    
    @IBOutlet var lblViewGroup: [UILabel]!
    @IBOutlet var lblViewGroup2: [UILabel]!
    
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var btnOffice: UIButton!
    @IBOutlet weak var btnSelf: UIButton!
    
    ///mark: action
    @IBAction func btnHomeOffice(_ sender: UIButton) {
        
        for i in btnGroup{
            guard let button = sender as? UIButton else {
                return
            }
            
            if i == button{
                i.setImage(UIImage(named: "imgAddressSelect"), for: .normal)
                switch i.tag {
                case 0:
                    selectedId = 1
                    donePressed.DonePressed()
                case 1:
                    selectedId = 2
                    donePressed.DonePressed()
                case 2:
                    selectedId = 3
                    donePressed.DonePressed()
                default:
                    print("Unknown language")
                    return
                }
                
            }else{
                i.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
            }
        }
        
    }
    
    @IBAction func btnSelf(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected{
            sender.setImage(UIImage(named: "imgAddressSelect"), for: .normal)
            if let getFinalDeviceId = storedDeviceId,let getFinalCountryId = storedCountryId{
                lblCcode.text = getFinalCountryId
                lblMnumber.text = getFinalDeviceId
            }else{
                lblCcode.text = ""
                lblMnumber.text = ""
            }
            donePressed.DonePressed()
        }else{
            sender.setImage(UIImage(named: "imgAddressUnselect"), for: .normal)
            if let getFinalDeviceId = receivedDeviceId,let getFinalCountryId = receivedCountryId{
                lblCcode.text = getFinalCountryId
                lblMnumber.text = getFinalDeviceId
            }else{
                lblCcode.text = ""
                lblMnumber.text = ""
            }
            donePressed.DonePressed()
        }
    }
    
    //mark: functions
    
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
        view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        
      
        
        for i in lblViewGroup2{
            i.layer.borderWidth = 1
            i.layer.borderColor = UIColor.lightGray.cgColor
            i.tintColor = .black
        }
        
        
        let tapFirstName = UITapGestureRecognizer(target: self, action: #selector(tapFirstName(sender:)))
        lblFirstName.addGestureRecognizer(tapFirstName)
        lblFirstName.isUserInteractionEnabled = true
        nextArray.append(lblFirstName)
        
        let tabLastName = UITapGestureRecognizer(target: self, action: #selector(tabLastName(sender:)))
        lblLastName.addGestureRecognizer(tabLastName)
        lblLastName.isUserInteractionEnabled = true
        nextArray.append(lblLastName)
        
        let tapAddress1 = UITapGestureRecognizer(target: self, action: #selector(tapAddress1(sender:)))
        lblAddress1.addGestureRecognizer(tapAddress1)
        lblAddress1.isUserInteractionEnabled = true
        nextArray.append(lblAddress1)
        
        let tapAddress2 = UITapGestureRecognizer(target: self, action: #selector(tapAddress2(sender:)))
        lblAddress2.addGestureRecognizer(tapAddress2)
        lblAddress2.isUserInteractionEnabled = true
        nextArray.append(lblAddress2)
        
        let tapLocality = UITapGestureRecognizer(target: self, action: #selector(tapLocality(sender:)))
        lblLocality.addGestureRecognizer(tapLocality)
        lblLocality.isUserInteractionEnabled = true
        nextArray.append(lblLocality)
        
        let tapCity = UITapGestureRecognizer(target: self, action: #selector(tapCity(sender:)))
        lblCity.addGestureRecognizer(tapCity)
        lblCity.isUserInteractionEnabled = true
        nextArray.append(lblCity)
        
        let tapState = UITapGestureRecognizer(target: self, action: #selector(tapState(sender:)))
        lblState.addGestureRecognizer(tapState)
        lblState.isUserInteractionEnabled = true
        nextArray.append(lblState)
        
        let tapPostalCode = UITapGestureRecognizer(target: self, action: #selector(tapPostalCode(sender:)))
        lblPostalCode.addGestureRecognizer(tapPostalCode)
        lblPostalCode.isUserInteractionEnabled = true
        nextArray.append(lblPostalCode)
        
//        let tapCcode = UITapGestureRecognizer(target: self, action: #selector(tapCcode(sender:)))
//        lblCcode.addGestureRecognizer(tapCcode)
        lblCcode.isUserInteractionEnabled = false
//        nextArray.append(lblCcode)
        
        let tapMnumber = UITapGestureRecognizer(target: self, action: #selector(tapMnumber(sender:)))
        lblMnumber.addGestureRecognizer(tapMnumber)
        lblMnumber.isUserInteractionEnabled = true
        nextArray.append(lblMnumber)
        
        
//        LETTERPAD?.delegateAction = self
        UPPERLETTERPAD?.delegateAction = self
        NUMBERPAD?.delegateAction = self
        
        
        
        addSubview(view)
        
    }
    
    
    @objc func tapFirstName(sender: UITapGestureRecognizer){
        
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblFirstName
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tabLastName(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblLastName
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapAddress1(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblAddress1
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapAddress2(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblAddress2
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapLocality(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblLocality
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapCity(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblCity
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapState(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblState
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapPostalCode(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblPostalCode
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapCcode(sender: UITapGestureRecognizer){
//        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
////        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
////        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        currentLable = lblCcode
//        //        new.backgroundColor = .clear
//        for i in lblViewGroup{
//            if i == currentLable{
//                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
//            }else{
//                i.backgroundColor = .clear
//            }
//        }
//        viewCustomKeyboard.isHidden = false
//        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
//        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    @objc func tapMnumber(sender: UITapGestureRecognizer){
        NUMBERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        NUMBERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
//        LETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
//        LETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        UPPERLETTERPAD?.frame.size.width = (self.viewCustomKeyboard?.frame.width)!
        UPPERLETTERPAD?.frame.size.height = (self.viewCustomKeyboard?.frame.height)!
        currentLable = lblMnumber
        //        new.backgroundColor = .clear
        for i in lblViewGroup{
            if i == currentLable{
                currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
            }else{
                i.backgroundColor = .clear
            }
        }
        viewCustomKeyboard.isHidden = false
        //        currentLable?.backgroundColor = #colorLiteral(red: 1, green: 0.9882352941, blue: 0.4, alpha: 0.3214551446)
        viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
        
    }
    
    
    
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
            viewCustomKeyboard?.addSubview(UPPERLETTERPAD!)
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
            viewCustomKeyboard?.addSubview(NUMBERPAD!)
        }
        if flag == "NEXT"{
            var currentNextIndex : Int?
            print(nextArray.count)
            for (index,temp) in nextArray.enumerated(){
                
                print(index)
                if temp == currentLable{
                    currentNextIndex = index
                    temp.backgroundColor = .clear
                }
                else{
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
//            LETTERPAD?.removeFromSuperview()
//            viewCustomKeyboard?.addSubview(NUMBERPAD!)
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
//        if flag == "CLR"{
//            //            searchBar.text = ""
//        }
//        if flag == "DEL"{
//            let tempText = currentLable?.text ?? ""
//            currentLable?.text = String(tempText.dropLast())
//        }
//        if flag == "CANCEL"{
//            currentLable?.backgroundColor = .clear
//            viewCustomKeyboard.isHidden = true
//            LETTERPAD?.removeFromSuperview()
//            donePressed.DonePressed()
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
    }
    func searchproduct() {
        return
    }
    
    
}
