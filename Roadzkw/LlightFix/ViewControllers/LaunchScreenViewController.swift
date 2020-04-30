//
//  LaunchScreenViewController.swift
//  LlightFix
//
//  Created by  on 6/27/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class LaunchScreenViewController: BaseViewController {
    var addsarray = NSArray()
    var sliderrr = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let request = GeneralRequest(.home)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in

            TempClass.sharedInstance.sliderArray    = responce.sliderArray
            TempClass.sharedInstance.adsArray       = responce.adsArray
            TempClass.sharedInstance.carMakersArray = responce.carMakersArray
            TempClass.sharedInstance.settingsObject = responce.settingsObject
            self.addsarray = responce.adsArray as NSArray
            self.sliderrr = responce.sliderArray as! NSArray
            
            
            
            let request = GeneralRequest(.packages)
            NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                TempClass.sharedInstance.packageArray = responce.packagesArray

                self.startApp()
            }
        }
        
    }
     func startApp(){
        let rootNav = AppDelegate.sharedInstance.rootNavigationController

        if (UserProfile.sharedInstance.isSelectLanguage?.boolValue ?? false) == false {
            rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "SelectLanguageViewController") ?? SelectLanguageViewController()], animated: true)
            }else if  (UserProfile.sharedInstance.isLoginBefore?.boolValue ?? false) == true {
               rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()], animated: true)
            }else  if sliderrr.count > 0 {
              rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "TutorialViewController") ?? TutorialViewController()], animated: true)
               
        } else if  addsarray.count > 0{
             rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "AdsViewController") ?? AdsViewController()], animated: true)
        } else {
            if (UserProfile.sharedInstance.isLoginBefore?.boolValue ?? false) == false {
            rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "BeforeLoginViewController") ?? BeforeLoginViewController()], animated: true)
            } else{
                rootNav?.setViewControllers([rootNav?.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()], animated: true)
            }
        }
       

            
        }
        
        
        
    //}
        
        
        


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
