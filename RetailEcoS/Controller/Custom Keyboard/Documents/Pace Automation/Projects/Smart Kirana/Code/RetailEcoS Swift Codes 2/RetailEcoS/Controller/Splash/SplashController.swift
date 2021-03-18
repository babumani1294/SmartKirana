//
//  SplashController.swift
//  RetailEcoS
//
//  Created by GBC  on 16/01/21.
//

import UIKit

class SplashController: UIViewController {
    
    ///mark: property
    var lblColor = (UIColor.gray,UIColor.systemBlue,UIColor.orange)
    
    
    ///mark: outlet
    @IBOutlet weak var imgSplsh12: UIImageView!
    @IBOutlet weak var imgSplsh3: UIImageView!
    
    @IBOutlet weak var lblSplsh12Title: UILabel!
    @IBOutlet weak var lblSplsh123SubTitle: UILabel!
    
    @IBOutlet weak var lblSplsh3Title: UILabel!
    @IBOutlet weak var lblSplsh3SubTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perform(#selector(showSplash), with: nil, afterDelay: 2)
        
    }
    
    
    ///mark: function
    @objc func showSplash(){
        
        UIView.animate(withDuration: 5, animations: {
            
            self.imgSplsh12.alpha = 1
            

            self.changeTitle(lbl: (self.lblSplsh12Title,"Novus Retail",UIColor.lightGray,1,UIFont.boldSystemFont(ofSize: 25.0)))
        
            self.changeTitle(lbl: (self.lblSplsh123SubTitle,"Your Retail Business Partner",UIColor.darkGray,1,UIFont.systemFont(ofSize: 17)))
            
        }, completion: { (finished: Bool) in
            
            
            UIView.animate(withDuration: 1, animations: {
                self.imgSplsh12.alpha = 0
                self.changeTitle(lbl: (self.lblSplsh12Title,""), lblColor: UIColor.lightGray, alpha: 0)
                self.changeTitle(lbl: (self.lblSplsh123SubTitle,""), lblColor: UIColor.darkGray, alpha: 0)
            })
            
            
            UIView.animate(withDuration: 5, animations: {
                self.imgSplsh12.alpha = 1
                
                self.changeTitle(lbl: (self.lblSplsh12Title,"RetailEcoS"), lblColor: UIColor.systemBlue, alpha: 1)
                self.changeTitle(lbl: (self.lblSplsh123SubTitle,"Powered & Serviced By"), lblColor: UIColor.darkGray, alpha: 1)
                self.imgSplsh12.image = UIImage(named: "Logo")
            }, completion: { (finished: Bool) in
                
                self.imgSplsh12.alpha = 0
                
                UIView.animate(withDuration: 1, animations: {
                    
                    self.changeTitle(lbl: (self.lblSplsh12Title,""), lblColor: UIColor.systemBlue, alpha: 0)
                    self.changeTitle(lbl: (self.lblSplsh123SubTitle,""), lblColor: UIColor.systemBlue, alpha: 0)
                    
                })
                
                UIView.animate(withDuration: 5, animations: {
                    self.imgSplsh3.alpha = 1
                    
                    self.changeTitle(lbl: (self.lblSplsh123SubTitle,"Confluence",UIColor.orange,1,UIFont.boldSystemFont(ofSize: 25.0)))
                    
                    self.changeTitle(lbl: (self.lblSplsh3Title,"Technology Simplified"), lblColor: self.lblColor.1, alpha: 0.8)
                    self.changeTitle(lbl: (self.lblSplsh3SubTitle,"From"), lblColor: self.lblColor.0, alpha: 1)
                }, completion: { (finished: Bool) in
                    self.performSegue(withIdentifier: "showPermissionScreen", sender: self)
                })
            })
        })
    }

    func changeTitle(lbl: (UILabel,String),lblColor: UIColor,alpha: CGFloat){
        lbl.0.text = lbl.1
        lbl.0.textColor = lblColor
        lbl.0.alpha = alpha
    }
    func changeTitle(lbl: (UILabel,String,UIColor,CGFloat,UIFont)){
        lbl.0.text = lbl.1
        lbl.0.textColor = lbl.2
        lbl.0.alpha = lbl.3
        lbl.0.font = lbl.4
    }
    
}






