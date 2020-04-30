//
//  ServiceStatusViewController.swift
//  LlightFix
//
//  Created by  on 7/3/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class ServiceStatusViewController: UIViewController {

    var resultOfService : Bool? = true
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblSubStatus: UILabel!
    @IBOutlet weak var btnOnTopForClose: UIButton!
    @IBOutlet weak var stackViewOK: UIStackView!
    @IBOutlet weak var lblWeAreOnTheWay: UILabel!
    @IBOutlet weak var lblWeWillCallYou: UILabel!
    @IBOutlet weak var btnClose: roundedButton!
    @IBOutlet weak var btnHomeAsGest: roundedButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
//            UserProfile.sharedInstance.isSelectGest = NSNumber(value:false)
            self.img.image = UIImage(named: "ic_payment_ok")
            self.btnClose.localized = "requestSignup"
            self.btnStatus.localized = "ServiceStatusVC.lblStatus.text.Demo"
            self.lblSubStatus.isHidden = true
            self.lblSubTitle.isHidden = false
            self.stackViewOK.isHidden = true
            self.lblSubTitle.localized = "ServiceStatusVC.lblSubTitle.text.Demo"
            self.btnHomeAsGest.isHidden = false
            return
        }else{
            self.btnHomeAsGest.isHidden = true
        }
        if self.resultOfService == true {
            self.img.image = UIImage(named: "ic_payment_ok")
            self.btnStatus.localized = "ServiceStatusVC.lblStatus.text.Successfully"
            self.lblSubStatus.isHidden = true
            self.lblSubTitle.isHidden = true
            self.stackViewOK.isHidden = false
        }else{
            self.img.image = UIImage(named: "ic_payment_no")
            self.btnStatus.localized = "ServiceStatusVC.lblStatus.text.Failed"
            self.lblSubStatus.isHidden = true
            self.lblSubTitle.isHidden = true
            self.stackViewOK.isHidden = true
        }
        self.btnStatus.titleLabel?.adjustsFontSizeToFitWidth = true
        self.btnOnTopForClose.isHidden = self.lblSubStatus.isHidden
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnClose(_ sender: Any) {
        if UserProfile.sharedInstance.isSelectGest?.boolValue == true {
            UserProfile.sharedInstance.isSelectGest = NSNumber(value:false)
           
//               if let vc = self.parentVC.storyboard?.instantiateViewController(withIdentifier: "RegestrationViewController") {
//                               self.presentVC(vc: vc,push:true)
//            }
            
            self.navigationController?.setViewControllers([HomeViewController.initiateInstance(),RegestrationViewController.initiateInstance()], animated: true)

//            self.navigationController?.setViewControllers([HomeViewController.initiateInstance(),LoginViewController.initiateInstance()], animated: true)
        }else{
            self.performSegueWithCheck(withIdentifier: "unwindToHomeVC", sender: self)
        }
    }
    @IBAction func btnHomeAsGest(_ sender: Any) {
        self.performSegueWithCheck(withIdentifier: "unwindToHomeVC", sender: self)
    }
    
}
