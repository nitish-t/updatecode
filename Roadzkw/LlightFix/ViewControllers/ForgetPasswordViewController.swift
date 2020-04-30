/*************************  *************************/
//
//  ForgetPasswordViewController.swift
//  LlightFix
//
//  Created by  on 6/29/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class ForgetPasswordViewController : BaseViewController {
    
    @IBOutlet weak var txtEmail: AllowedCharsTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEmail.placeholder = "emailPlaceholder".localize_

//        if UserProfile.sharedInstance.isRTL() == true {
//            txtEmail.placeholder = "email.adress@gmail.com"
//        }else  {
//            txtEmail.placeholder = "email.adress@gmail.com"
//        }
        // Do any additional setup after loading the view.
        
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
        if self.txtEmail.text?.isValidEmail() == false{
            return self.showErrorMSG(msgText: "Email".localize_)
        }
        return true
    }
    @IBAction func btnSendPassword(_ sender: Any) {
        if !self.validation() {
            return
        }
        let request = UserRequest(.forgetPassword)
        request.email = self.txtEmail.text
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.showPopAlert(title: "Done".localize_, message: responce.status?.message ?? "ResetCodeToResetPasswordSuccess".localize_,okAction: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
