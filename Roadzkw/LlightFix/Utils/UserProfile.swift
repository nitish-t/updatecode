/*************************  *************************/
//
//  UserProfile.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//



import UIKit
import MagicalRecord

class UserProfile: NSObject {
    static let sharedInstance = UserProfile()
    
    var currentUserID: NSNumber? {
        get {
            return UserDefaults.standard.value(forKey: "currentUserID") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentUserID")
            UserDefaults.standard.synchronize()
        }
    }
    
    var price: String {
        get {
            return UserDefaults.standard.value(forKey: "currentPrice") as! String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentPrice")
            UserDefaults.standard.synchronize()
        }
    }
    
    var currentUserToken: String? {
        get {
            return UserDefaults.standard.value(forKey: "currentUserToken") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentUserToken")
            UserDefaults.standard.synchronize()
        }
    }
    var currentUserFireBaseToken: String? {
        get {
            return UserDefaults.standard.value(forKey: "currentUserFireBaseToken") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentUserFireBaseToken")
            UserDefaults.standard.synchronize()
        }
    }
    var isTutorialShowen: NSNumber? {
        get {
            return UserDefaults.standard.value(forKey: "isTutorialShowen") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isTutorialShowen")
            UserDefaults.standard.synchronize()
        }
    }
    var isSelectLanguage: NSNumber? {
        get {
            return UserDefaults.standard.value(forKey: "isSelectLanguage") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isSelectLanguage")
            UserDefaults.standard.synchronize()
        }
    }
    var isLoginBefore: NSNumber? {
        get {
            return UserDefaults.standard.value(forKey: "isLoginBefore") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isLoginBefore")
            UserDefaults.standard.synchronize()
        }
    }
    var isSelectGest: NSNumber? {
        get {
            return UserDefaults.standard.value(forKey: "isSelectGest") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isSelectGest")
            UserDefaults.standard.synchronize()
        }
    }
    var currentUser: TUserObject? {
        get {
            let decoded  = (UserDefaults.standard.object(forKey: "currentUser") as? Data) ?? Data()
            return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? TUserObject
        }
        set {
            if let value = newValue{
                self.currentUserID = value.pk_i_id
                if let token = value.s_access_token {
                    self.currentUserToken = token
                    
                    NLRequestWrapper.sharedInstance.makeRequest(request: UserRequest(.update_token)).executeWithCheckResponse(showLodaer: false, showMsg: true) { (responce) in
                    }
                }
                UserProfile.sharedInstance.isSelectGest = NSNumber(value:false)
                let encodedData = NSKeyedArchiver.archivedData(withRootObject:value)
                UserDefaults.standard.set(encodedData, forKey: "currentUser")
                UserDefaults.standard.synchronize()
            }else{
                self.currentUserToken = nil
                self.currentUserID = nil
                UserDefaults.standard.set(nil, forKey: "currentUser")
                UserDefaults.standard.synchronize()
            }
            NotificationCenter.default.post(name: NSNotification.Name("userStatusChanged"), object: nil)
        }
    }
 
    func openMenuBaseedOnLang() -> Void {
        if isRTL() {
            AppDelegate.sharedInstance.sideMenuVC.toggleRightViewAnimated()
        }else{
            AppDelegate.sharedInstance.sideMenuVC.toggleLeftViewAnimated()
        }
    }
    func checkIfUserLogin(alert:Bool) -> Bool {
        if alert && self.currentUserID == nil {
            let alertController = UIAlertController(title: "loginRequiredAttention".localize_, message:"LoginIsRequired".localize_, preferredStyle:.alert)
            alertController.addAction(UIAlertAction(title: "Login".localize_, style:.default, handler: { (action) in
                let vc = AppDelegate.sharedInstance.rootNavigationController?.storyboard?.instantiateViewController(withIdentifier:"LoginViewController")
                AppDelegate.sharedInstance.rootNavigationController?.pushViewController(vc!, animated: true)//present(vc!, animated: true, completion: nil)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                
            }))
            AppDelegate.sharedInstance.rootNavigationController?.present(alertController, animated: true, completion: nil)
        }
        return self.currentUserID != nil
    }
    func selectedLang() -> String {
        let langs = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String>
        return (langs?.first)!
    }
//
    func isRTL() -> Bool {
        let langs = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String>
        return (langs?.first?.hasPrefix("ar"))! ? true : false
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//
//    func getCurrentMenu() -> NLSideMenuViewController! {
//        if let menuRight = applicationDelegate.rootNavigationController?.menuContainerViewController.rightMenuViewController as? NLSideMenuViewController{
//            return menuRight
//        }else if let menuLeft = applicationDelegate.rootNavigationController?.menuContainerViewController.leftMenuViewController as? NLSideMenuViewController{
//            return menuLeft
//        }
//        return NLSideMenuViewController.sharedInstance
//    }
}
