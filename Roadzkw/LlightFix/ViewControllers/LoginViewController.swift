/*************************  *************************/
//
//  LoginViewController.swift
//  LlightFix
//
//  Created by  on 6/27/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class LoginViewController : BaseViewController {
    
    @IBOutlet weak var txtEmail: AllowedCharsTextField!
    @IBOutlet weak var txtPassword: UITextField!

    @IBOutlet weak var bgview: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.txtEmail.placeholder = "emailPlaceholder".localize_


//        self.txtEmail.text = "gk@gmail.com"
//        self.txtPassword.text = "123456"
        
       // self.txtEmail.placeholder = "email.address@gmail.com"
        

        if UserProfile.sharedInstance.isRTL() == true {
            bgview.isHidden = true
            let flippedImage = UIImage(named: "bg_views_")?.imageFlippedForRightToLeftLayoutDirection()
            let addImageView = UIImageView(image: flippedImage)
        addImageView.frame = CGRect(x: 0, y: self.view.frame.height - bgview.frame.height+150, width: bgview.frame.width - 320, height: bgview.frame.height - 150)
            addImageView.image = flippedImage
            self.view.addSubview(addImageView)
           
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
        if self.txtEmail.text?.isValidEmail() == false{
            return self.showErrorMSG(msgText: "Email".localize_)
        }else if self.txtPassword.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "Password".localize_)
        }
        return true
    }
    @IBAction func btnLogin(_ sender: Any) {
        if !self.validation() {
            return
        }
        let request = UserRequest(.login)
        request.email = self.txtEmail.text
        request.password = self.txtPassword.text
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            UserProfile.sharedInstance.currentUser = responce.userObject
            self.showPopAlert(title: "Done".localize_, message: responce.status?.message ?? "logInSuccess".localize_,okAction: {
                self.closeVC()
            })
        }
    }
    @IBAction func btnGest(_ sender: Any) {
        self.closeVC()
    }
    func closeVC(){
//        if self.navigationController?.viewControllers.count == 1 && self.navigationController?.viewControllers.first is LoginViewController {
            self.navigationController?.setViewControllers([self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()], animated: true)
//        }else{
//            self.dismiss(animated: true, completion: nil)
//        }
    }
}
