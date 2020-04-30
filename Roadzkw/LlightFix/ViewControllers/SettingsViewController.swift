//
//  SettingsViewController.swift
//  LlightFix
//
//  Created by  on 6/30/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
//import AlertsPickers
import RLBAlertsPickers
import Alamofire

class SettingsViewController: BaseViewController {

    @IBOutlet weak var btnEn: UIButton!
    @IBOutlet weak var btnAr: UIButton!
    
    @IBOutlet weak var btnNotification_on: UIButton!
    @IBOutlet weak var btnNotification_off: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.updateUI()
        
        self.Notification()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateUI()
       // self.Notification()
    }
    
    func updateUI(){
        if UserProfile.sharedInstance.isRTL() == true {
            self.btnEn.setTitleColor(UIColor(named: "#333132 - 25 OP"), for: .normal)
            self.btnAr.setTitleColor(UIColor(named: "#333132"), for: .normal)
        }else{
            self.btnEn.setTitleColor(UIColor(named: "#333132"), for: .normal)
            self.btnAr.setTitleColor(UIColor(named: "#333132 - 25 OP"), for: .normal)
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
    
    
     @IBAction func btnNoti_on(_ sender: Any) {
        
        let request = UserRequest(.update_notification_status)
        request.deviceId = UserProfile.sharedInstance.currentUserFireBaseToken
        request.setting = "1"
        request.discription = ""
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            debugPrint(responce)
            self.btnNotification_on.setTitleColor(UIColor.black, for: .normal)
            self.btnNotification_off.setTitleColor(UIColor.gray, for: .normal)
        }

        }
    
     @IBAction func btnNoti_off(_ sender: Any) {
        
        let request = UserRequest(.update_notification_status)
        request.deviceId = UserProfile.sharedInstance.currentUserFireBaseToken
        request.setting = "0"
        request.discription = ""
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            debugPrint(responce)
            self.btnNotification_on.setTitleColor(UIColor.gray, for: .normal)
            self.btnNotification_off.setTitleColor(UIColor.black, for: .normal)

        }
        }
    
    @IBAction func btnEn(_ sender: Any) {
        SettingsViewController.changeLangTo("en")
//        self.setApplicationLang(isEn: false, withRootVCIdentifier: "SideMenuMainController")
    }
    @IBAction func btnAr(_ sender: Any) {
        SettingsViewController.changeLangTo("ar")
//        self.setApplicationLang(isEn: true, withRootVCIdentifier: "SideMenuMainController")
    }
    @IBAction func btnTerms(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "StaticPagesViewController") {
            (vc as! StaticPagesViewController).vcType = .terms
            AppDelegate.sharedInstance.rootNavigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnPrivacy(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "StaticPagesViewController") {
            (vc as! StaticPagesViewController).vcType = .privacy
            AppDelegate.sharedInstance.rootNavigationController?.present(vc, animated: true, completion: nil)
        }
    }
    static func changeLangTo(_ lang:String){
        let alertController = UIAlertController(title: "Attention".localize_, message:"messege_application_will_exit".localize_, preferredStyle:.alert)
        alertController.addAction(title: "OK".localize_, color: UIColor(named: "#009BA2"), style: .default, isEnabled: true) { (alert) in
            L102Language.setAppleLAnguageTo(lang: lang)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                exit(0)
            })
        }
        alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
            
        }))
        AppDelegate.sharedInstance.rootNavigationController?.present(alertController, animated: true, completion: nil)
    }
    
    
    func Notification()
    {
        let request = UserRequest(.get_notification_status_update)
        request.deviceId = UserProfile.sharedInstance.currentUserFireBaseToken
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            
            if responce.noty == "1" {
                self.btnNotification_on.setTitleColor(UIColor.black, for: .normal)
                self.btnNotification_off.setTitleColor(UIColor.gray, for: .normal)
            }
            else {
                self.btnNotification_on.setTitleColor(UIColor.gray, for: .normal)
                self.btnNotification_off.setTitleColor(UIColor.black, for: .normal)
            }
        }
    }
}
