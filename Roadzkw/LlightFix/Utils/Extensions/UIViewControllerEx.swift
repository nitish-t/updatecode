/*************************  *************************/
//
//  UIViewControllerEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import UINavigationBar_Addition
import FDTake
import MapKit

extension UIViewController{
    @nonobjc class var className_: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    static func initiateInstance()->UIViewController{
        return  (AppDelegate.sharedInstance.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "\(className_)"))!
    }
    func initWithParams(params:Dictionary<String,Any>?) -> UIViewController{
        return self
    }
    
    static func navigate(_ prevVC: UIViewController, params: Dictionary<String, Any>) {
        prevVC.navigationController?.pushViewController(initiateInstance().initWithParams(params: params), animated: true)
    }
    
    static func present(_ prevVC: UIViewController, params: Dictionary<String, Any>) {
        prevVC.present(initiateInstance().initWithParams(params: params), animated: true, completion: nil)
        
    }
    
    static func present(nc: UINavigationController?, params: Dictionary<String, Any>) {
        nc?.pushViewController(initiateInstance().initWithParams(params: params), animated: true)
    }
    
    func showPopAlert(title:String,message msg:String,okAction:(() -> Void)? = nil)  {
        let alertController = UIAlertController(title: title.localize_, message: msg.localize_, preferredStyle: .alert)
        alertController.addAction(title: "OK".localize_, color: UIColor(named: "#009BA2"), style: .default, isEnabled: true) { (alert) in
            okAction?()
        }
        self.present(alertController, animated: true, completion: nil)
    }


    func setNavigationBarTransparent() {
        self.navigationController?.navigationBar.makeTransparent()
    }
    func setNavigationBarDefault() {
        self.navigationController?.navigationBar.makeDefault()
    }
    
    func changeNavBar(NavBarTransparent:Bool,statusBarWhite:Bool) {
        if NavBarTransparent == true {
            self.setNavigationBarTransparent()
        }else{
            self.setNavigationBarDefault()
        }
        if statusBarWhite == true {
            self.navigationController?.navigationBar.barStyle = .black
            self.navigationController?.navigationBar.tintColor = UIColor.white
        }else{
            self.navigationController?.navigationBar.barStyle = .default
            self.navigationController?.navigationBar.tintColor = UIColor.black
        }
        
        self.navigationController?.navigationBar.backItem?.title = " "
    }
    
    func fdTake_action(_ sender:UIView, completionBlock: @escaping ((_ photo: UIImage, _ info: [AnyHashable: Any]) -> Void))  {
        let fdTake = FDTakeController()
        fdTake.presentingView = sender
        fdTake.allowsVideo = false
        fdTake.present()
        fdTake.didGetPhoto = {(_ photo: UIImage, _ info: [AnyHashable : Any]) in
            completionBlock(photo,info)
        }
    }
    func openMaps(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let googleMapsInstalled = UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
        if googleMapsInstalled {
            UIApplication.shared.openURL(URL(string: "comgooglemaps-x-callback://" +
                "?q=\(latitude),\(longitude)&zoom=14&views=traffic")!)
//            UIApplication.shared.openURL(URL(string: "comgooglemaps-x-callback://" +
//                "?daddr=\(latitude),\(longitude)&directionsmode=bicycling&zoom=17")!)
        } else {
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.openInMaps(launchOptions: nil)
        }
    }
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    func performSegueWithCheck(withIdentifier identifier: String, sender: Any?) {
        if canPerformSegue(withIdentifier: identifier){
            self.performSegue(withIdentifier: identifier, sender: sender)
        }
    }
    func canPerformSegue(withIdentifier identifier: String) -> Bool {
        //first fetch segue templates set in storyboard.
        guard let identifiers = value(forKey: "storyboardSegueTemplates") as? [NSObject] else {
            //if cannot fetch, return false
            return false
        }
        //check every object in segue templates, if it has a value for key _identifier equals your identifier.
        let canPerform = identifiers.contains { (object) -> Bool in
            if let id = object.value(forKey: "_identifier") as? String {
                if id == identifier{
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        return canPerform
    }
    
    func setApplicationLang(isEn:Bool,withRootVCIdentifier:String?,completion: ((Bool) -> Void)? = nil) {
        var transition: UIView.AnimationOptions = .transitionFlipFromLeft
        if isEn == true {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        if let ident = withRootVCIdentifier {
            let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            rootviewcontroller.rootViewController = self.storyboard?.instantiateViewController(withIdentifier: ident)
        }
        let mainwindow = (UIApplication.shared.delegate?.window!)!
        mainwindow.backgroundColor = UIColor(hue: 0.6477, saturation: 0.6314, brightness: 0.6077, alpha: 0.8)
        UIView.transition(with: mainwindow, duration: 0.55001, options: transition, animations: { () -> Void in
        }) { (finished) -> Void in
            completion?(finished)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5, execute: {
                UIFont.overrideInitialize()
            })
            
        }
    }
    @IBInspectable
    var localized: String? {
        get {
            return self.title
        }
        set {
            self.title = newValue?.localize_
        }
    }
    @IBAction func btnBackVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
