//
//  ContactUSViewController.swift
//  LlightFix
//
//  Created by  on 6/30/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class ContactUSViewController: BaseViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: AllowedCharsTextField!
    @IBOutlet weak var txtMobile: AllowedCharsTextField!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var lblInfoPhone: UILabel!
    @IBOutlet weak var lblInfoEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let user = UserProfile.sharedInstance.currentUser
        let settings = TempClass.sharedInstance.settingsObject
        
        self.txtName.text = user?.s_full_name
        self.txtEmail.text = user?.s_email
        self.txtMobile.text = user?.s_mobile
        self.lblInfoPhone.text = settings?.s_mobile
        self.lblInfoEmail.text = settings?.s_info_email
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
        }else if self.txtMobile.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "RegistrationVC.lblMobile.text".localize_)
        }else if self.txtMessage.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "ContactUSVC.lblMessage.text".localize_)
        }
        return true
    }

    @IBAction func btnSubmit(_ sender: Any) {
        if !self.validation() {
            return
        }
        let request = GeneralRequest(.contact_us)
        request.name = self.txtName.text
        request.email = self.txtEmail.text
        request.phone = self.txtMobile.text
        request.message = self.txtMessage.text
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.showPopAlert(title: "Done".localize_, message: responce.status?.message ?? "SuccessSendRequest".localize_,okAction: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
    @IBAction func btnPhoneNumber(_ sender: Any) {
        if let url = URL(string: "tel://\((self.lblInfoPhone.text ?? "").removeWhiteSpaceAndArabicNumbers)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    @IBAction func btnEmail(_ sender: Any) {
        if let url = URL(string: "mailto://\(self.lblInfoEmail.text ?? "")") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
}
