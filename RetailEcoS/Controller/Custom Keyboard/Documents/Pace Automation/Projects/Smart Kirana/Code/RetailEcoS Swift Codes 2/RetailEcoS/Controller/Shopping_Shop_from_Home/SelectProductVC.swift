//
//  SelectProductVC.swift
//  RetailEcoS
//  SelectProductVC
//  Description - Various Product selection options
//  Developed By:
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit

class SelectProductVC: UIViewController {

    @IBOutlet weak var ProdcutouterLayer: UIStackView!
    @IBOutlet weak var ProdcutouterLayer1: UIStackView!
    @IBOutlet weak var ProdcutouterLayer2: UIStackView!

    
    @IBOutlet weak var product1view: UIView!
    @IBOutlet weak var product2view: UIView!
    @IBOutlet weak var product3view: UIView!
    
    @IBOutlet weak var product4view: UIView!
    @IBOutlet weak var product5view: UIView!
    @IBOutlet weak var product6view: UIView!
    
    @IBOutlet weak var product7view: UIView!
    @IBOutlet weak var product8view: UIView!
    @IBOutlet weak var product9view: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ProdcutouterLayer.layer.borderWidth = 1
        self.ProdcutouterLayer.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product1view.layer.borderWidth = 1
        self.product1view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product2view.layer.borderWidth = 1
        self.product2view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product3view.layer.borderWidth = 1
        self.product3view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        
        
        self.ProdcutouterLayer1.layer.borderWidth = 1
        self.ProdcutouterLayer1.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product4view.layer.borderWidth = 1
        self.product4view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product5view.layer.borderWidth = 1
        self.product5view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product6view.layer.borderWidth = 1
        self.product6view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        
        self.ProdcutouterLayer2.layer.borderWidth = 1
        self.ProdcutouterLayer2.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product7view.layer.borderWidth = 1
        self.product7view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product8view.layer.borderWidth = 1
        self.product8view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        self.product9view.layer.borderWidth = 1
        self.product9view.layer.borderColor = #colorLiteral(red: 0.003921568627, green: 0.631372549, blue: 1, alpha: 1)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
