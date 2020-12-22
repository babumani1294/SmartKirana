//
//  PermissionVC.swift
//  RetailEcoS
//  PermissionVC
//  Description - To get system permission for internal function
//  Developed By:
// © Copyright - Confluence Pte Ltd - Singapore - All Rights reserved


import UIKit
//gitChecks
class PermissionVC: UIViewController {

    @IBOutlet weak var permissionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    //Border color for Permission view
        permissionView.layer.borderWidth = 1
        permissionView.layer.borderColor = #colorLiteral(red: 0.05882352941, green: 0.2588235294, blue: 0.9019607843, alpha: 1)
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
           print(deviceID)
        
        
     
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
