//
//  SelectLanguageViewController.swift
//  LlightFix
//
//  Created by  on 9/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class SelectLanguageViewController: BaseViewController {
    var addsarray = NSArray()
    var sliderrr = NSArray()
var  launchscreen = LaunchScreenViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        
        UserProfile.sharedInstance.isSelectLanguage = NSNumber(value:true)
        
       
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(true)
        let request = GeneralRequest(.home)
                      NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                          TempClass.sharedInstance.sliderArray    = responce.sliderArray
                          TempClass.sharedInstance.adsArray       = responce.adsArray
                          TempClass.sharedInstance.carMakersArray = responce.carMakersArray
                          TempClass.sharedInstance.settingsObject = responce.settingsObject
                       
                       
                       self.addsarray = responce.adsArray as NSArray
                       self.sliderrr = responce.sliderArray as NSArray
               }
             
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnEN(_ sender: Any) {
        if UserProfile.sharedInstance.isRTL() == false {
            showaddsaray()
            //LaunchScreenViewController.startApp()
            
//            launchscreen.startApp()
        }else{
            SettingsViewController.changeLangTo("en")
        }
    }
    @IBAction func btnAR(_ sender: Any) {
        if UserProfile.sharedInstance.isRTL() == true {
               showaddsaray()
          //  LaunchScreenViewController.startApp()
//            launchscreen.startApp()
        }else{
            SettingsViewController.changeLangTo("ar")
        }
    }
    func showaddsaray() {
        let rootNav = AppDelegate.sharedInstance.rootNavigationController
        if sliderrr.count > 0  {
            rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "TutorialViewController") ?? TutorialViewController()], animated: true)
        } else if addsarray.count > 0 {
             rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "AdsViewController") ?? AdsViewController()], animated: true)
        } else {
            if (UserProfile.sharedInstance.isLoginBefore?.boolValue ?? false) == false {
            rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "BeforeLoginViewController") ?? BeforeLoginViewController()], animated: true)
            } else{
                rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()], animated: true)
            }
        }
        
       
    }
    
    
//
//    func showaddsaray(){
//         let rootNav = AppDelegate.sharedInstance.rootNavigationController
//        if sliderrr.count > 0 {
//        if (UserProfile.sharedInstance.isLoginBefore?.boolValue ?? false) == false {
//            rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "BeforeLoginViewController") ?? BeforeLoginViewController()], animated: true)
//
//                }else{
//    rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()], animated: true)
//                           }
//        }else if sliderrr.count > 0{
//            rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "TutorialViewController") ?? TutorialViewController()], animated: true)
//            //UserProfile.sharedInstance.isTutorialShowen = NSNumber(value: true)
//        } else if self.addsarray.count == 1 {
//            rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "AdsViewController") ?? AdsViewController()], animated: true)
//        }
//
//
//    }
       
    
}
