//
//  ProfileViewController.swift
//  LlightFix
//
//  Created by  on 6/30/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: AllowedCharsTextField!
    @IBOutlet weak var txtPhoneNumber: AllowedCharsTextField!
    @IBOutlet weak var lblEmailStatus: UILabel!
    @IBOutlet weak var btnResendEmail: roundedButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserProfile.sharedInstance.isRTL() == true {
             self.txtEmail.placeholder = "لك عنوان البريد الإلكتروني"

         } else {
             self.txtEmail.placeholder = "You email address"
         }

        // Do any additional setup after loading the view.
        self.updateUI()
        let request = UserRequest(.porfile)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            UserProfile.sharedInstance.currentUser = responce.userObject
            self.updateUI()
            
            let udid = UIDevice.current.identifierForVendor?.uuidString

        }
    }
    func updateUI(){
        let user = UserProfile.sharedInstance.currentUser
        self.txtName.text = user?.s_full_name
        self.txtEmail.text = user?.s_email
        self.txtPhoneNumber.text = user?.s_mobile
        
        if user?.b_email_verified?.boolValue == true {
            self.lblEmailStatus.localized = "ProfileVC.lblEmailStatus.text_active"
            self.btnResendEmail.isHidden = true
            self.txtEmail.isEnabled = false
        }else{
            self.lblEmailStatus.localized = "ProfileVC.lblEmailStatus.text_not_active"
            self.btnResendEmail.isHidden = false
            self.txtEmail.isEnabled = true
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
    func showErrorMSG(msgText:String) -> Bool {
        self.showPopAlert(title: "Error".localize_, message: "TextFeildValidation".localized(with: msgText))
        return false
    }
    func validation() -> Bool {
        if self.txtName.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "UserName".localize_)
        }else if self.txtEmail.text?.isValidEmail() == false{
            return self.showErrorMSG(msgText: "Email".localize_)
        }else if self.txtPhoneNumber.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "RegistrationVC.lblMobile.text".localize_)
        }
        return true
    }
    @IBAction func btnUpdate(_ sender: Any) {
        if !self.validation() {
            return
        }
        let request = UserRequest(.update)
        request.email        = self.txtEmail.text
        request.full_name    = self.txtName.text
        request.mobile       = self.txtPhoneNumber.text
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            UserProfile.sharedInstance.currentUser = responce.userObject
            self.showPopAlert(title: "Done".localize_, message: responce.status?.message ?? "UpdateProfileSuccess".localize_,okAction: {

            })
        }
    }
    @IBAction func btnResendEmail(_ sender: Any) {
        let request = UserRequest(.resend_email)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.showPopAlert(title: "Done".localize_, message: responce.status?.message ?? "DoneSuccessfully".localize_,okAction: {
                
            })
        }
    }
    
}
