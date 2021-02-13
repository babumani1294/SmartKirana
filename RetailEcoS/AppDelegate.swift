//
//  AppDelegate.swift
//  Demo Screen
//
//  Developed by 
//© Copyright - Confluence Pte Ltd - Singapore - All Rights reserved

import UIKit
import Contacts
import Photos
import Contacts
import CoreLocation


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        CNContactStore().requestAccess(for: .contacts) { (access, error) in
//            if access{
//                print("contact access granted")
//                permissions.0 = true
//            }else{
//                print("contact access not granted")
//                permissions.0 = false
//            }
//        }
//        
//        //Camera
//           AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
//               if response {
//                print(" camera access granted")
//                permissions.1 = true
//               } else {
//                print(" camera access not granted")
//                permissions.1 = false
//               }
//           }
//
//           //Photos
//           let photos = PHPhotoLibrary.authorizationStatus()
//          
//               PHPhotoLibrary.requestAuthorization({status in
//                if status == .authorized{
//                       print(" phot access granted")
//                    permissions.2 = true
//                   } else {
//                    print("photo access not granted")
//                    permissions.2 = false
//                   }
//               })
           
       
        return true
    }

}


