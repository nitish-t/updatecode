/*************************  *************************/
//
//  ChangePasswordViewController.swift
//  LlightFix
//
//  Created by  on 7/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class ChangePasswordViewController : UIViewController {
    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmNewPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        #if DEBUG
        #else
        #endif
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
        if self.txtCurrentPassword.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "ChangePasswordVC.lblCurrentPassword.text".localize_)
        }else if self.txtNewPassword.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "ChangePasswordVC.lblNewPassword.text".localize_)
        }else if self.txtConfirmNewPassword.text?.isEmptyOrWhiteSpace() == true || self.txtConfirmNewPassword.text != self.txtNewPassword.text{
            return self.showErrorMSG(msgText: "ChangePasswordVC.lblReNewPassword.text".localize_)
        }
        return true
    }
    @IBAction func btnChange(_ sender: Any) {
        if !self.validation() {
            return
        }
        let request = UserRequest(.update_password)
        request.password = self.txtCurrentPassword.text
        request.NewPassword = self.txtNewPassword.text 
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.showPopAlert(title: "Done".localize_, message: responce.status?.message ?? "SuccessSendRequest".localize_,okAction: {
                self.navigationController?.popViewController(animated: true)
            })
        }
    }
}
