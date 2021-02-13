//
//  RetailSelectionController.swift
//  RetailEcoS
//
//  Created by Pace Automation on 2021-02-03.
//

import UIKit

class RetailSelectionController: UIViewController {
    
    ///mark: property
    let sectionInsets = UIEdgeInsets(top: 30.0,left: 0.0,bottom: 20.0,right: 0.0)
    var retailVertivcalList = ["Apparel","Beauty","Electrical","Eyewear","Fashion","Footwear","Furniture","Grocery","Appliances","Jewellery","Luggage","Stationary"]
    var retailVerticalDetails : [(UIImage,UIImage,UIImage, Bool,String)] = [(UIImage(named: "imgApparel")!,UIImage(named: "imgApparel")!,UIImage(named: "imgApparel-1")!, false,"Apparel"),(UIImage(named: "imgBeauty")!,UIImage(named: "imgBeauty")!,UIImage(named: "imgBeauty-1")!, false,"Beauty"),(UIImage(named: "imgElectrical")!,UIImage(named: "imgElectrical")!,UIImage(named: "imgElectrical-1")!, false,"Electrical"),(UIImage(named: "imgEyewear")!,UIImage(named: "imgEyewear")!,UIImage(named: "imgEyewear-1")!, false,"Eyewear"),(UIImage(named: "imgFashion")!,UIImage(named: "imgFashion")!,UIImage(named: "imgFashion-1")!, false,"Fashion"),(UIImage(named: "imgFootwear")!,UIImage(named: "imgFootwear")!,UIImage(named: "imgFootwear-1")!, false,"Footwear"),(UIImage(named: "imgFurniture")!,UIImage(named: "imgFurniture")!,UIImage(named: "imgFurniture-1")!, false,"Furniture"),(UIImage(named: "imgGrocery")!,UIImage(named: "imgGrocery")!,UIImage(named: "imgGrocery-1")!, false,"Grocery"),(UIImage(named: "imgAppliance")!,UIImage(named: "imgAppliance")!,UIImage(named: "imgAppliance-1")!, false,"Appliances"),(UIImage(named: "imgJewellery")!,UIImage(named: "imgJewellery")!,UIImage(named: "imgJewellery-1")!, false,"Jewellery"),(UIImage(named: "imgLuggage")!,UIImage(named: "imgLuggage")!,UIImage(named: "imgLuggage-1")!, false,"Luggage"),(UIImage(named: "imgStationary")!,UIImage(named: "imgStationary")!,UIImage(named: "imgStationary-1")!, false,"Stationary")]
    
   
    
    ///mark: outlet
    
    @IBOutlet weak var viewCollectionBackground: UIView!
    @IBOutlet weak var retailSelectionCV: UICollectionView!
    
    ///mark: action
    
    @IBAction func btnGoNext(_ sender: Any) {
        
        self.performSegue(withIdentifier: "showHomeScreen", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        //        newRetail.append((UIImage(named: "dfs")!, false))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showHomeScreen" else{
            return
        }
        
        let getHomeController = segue.destination as! HomeSelectionListController
        getHomeController.retailVerticalDetails = retailVerticalDetails
    }
    
    
    
    ///mark : function
    
    func initialConfig() {
        self.viewCollectionBackground.shadowEffects(shadow: .WithBorder, getView: self.viewCollectionBackground, cornerRadius: 50)
        
        retailSelectionCV.delegate = self
        retailSelectionCV.dataSource = self
        
    }
    
    
    
    
}


///mark: extension

extension RetailSelectionController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let width  = (self.retailSelectionCV.frame.size.width ) / 5
        let height  = (self.retailSelectionCV.frame.size.height ) / 4
        
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
}


///Mark: Collection View Delegate
extension RetailSelectionController: UICollectionViewDelegate,UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 12
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RetailSelectionCell", for: indexPath) as? RetailSelectionCell{
            
            //            cell.viewCell.shadowEffects(shadow: .WithBorder, getView: cell.viewCell, cornerRadius: 10)
            cell.imgCell.image = retailVerticalDetails[indexPath.row].0
            cell.lblCell.text = retailVerticalDetails[indexPath.row].4
            return cell
            
        }
        
        return UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RetailSelectionCell", for: indexPath) as? RetailSelectionCell{
            
            retailVerticalDetails[indexPath.row].3 = !retailVerticalDetails[indexPath.row].3
            
            if retailVerticalDetails[indexPath.row].3 {
                retailVerticalDetails[indexPath.row].0 = retailVerticalDetails[indexPath.row].2
                
                for i in 0..<12{
                    if i != indexPath.row{
                        retailVerticalDetails[i].0 = retailVerticalDetails[i].1
                        retailVerticalDetails[i].3 = false
                    }
                }
                
                collectionView.reloadData()
            }else{
                
                retailVerticalDetails[indexPath.row].0 = retailVerticalDetails[indexPath.row].1
                collectionView.reloadData()
            }
        }
        
    }
}

