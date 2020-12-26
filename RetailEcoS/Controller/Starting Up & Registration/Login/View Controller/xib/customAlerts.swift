//
//  customAlerts.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2020-12-26.
//

import UIKit

class customAlerts: UIView {

    ///mark: property
    
    var btnClick: alertButtonclickEvent!
    
    
    ///mark: outlet
    
    @IBOutlet weak var viewAlert: UIView!
    
    
    ///mark: action
    @IBAction func btnOk(_ sender: UIButton) {
        btnClick.alertButtonClickEvent(Btn: sender)
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        btnClick.alertButtonClickEvent(Btn: sender)
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
        var view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = bounds
        addSubview(view)
    }

}


protocol alertButtonclickEvent {
    func alertButtonClickEvent(Btn: UIButton)
}
