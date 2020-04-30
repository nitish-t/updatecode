/*************************  *************************/
//
//  RegestrationViewController.swift
//  LlightFix
//
//  Created by  on 6/29/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
//import AlertsPickers
import RLBAlertsPickers
import BEMCheckBox

class RegestrationViewController : BaseViewController {
    fileprivate enum RegestrationVCPickerType {
        case make
        case model
        case year
        
        var s_msg : String {
            switch self {
            case .make:
                return "RegistrationVC.lblCarMaker.text".localize_
            case .model:
                return "RegistrationVC.lblCarModel.text".localize_
            case .year:
                return "RegistrationVC.lblCarYear.text".localize_
            }
        }
    }
    
    enum RegestrationVCStep {
        case step1
        case step2
    }
    var stepStatus : RegestrationVCStep = .step1{
        didSet{
            switch stepStatus {
            case .step1:
                self.stackViewStep1.isHidden = false //showAnimated(in: self.stackViewStep1?.superview as! UIStackView)
                self.stackViewStep2.isHidden = true //hideAnimated(in: self.stackViewStep1?.superview as! UIStackView)
                self.lblBtnRegisterTitle.text = "RegistrationVC.lblNext.text".localize_
                self.imgBtnRegister.isHidden = false
                if UserProfile.sharedInstance.isRTL() == true {
                    self.imgStepStatus.image = UIImage(named: "ic_signup_page1Ar")
                } else {
                    self.imgStepStatus.image = UIImage(named: "ic_registration_step_1")
                }
                self.imgStepStatus.image = UIImage(named: "ic_registration_step_1")
                self.lblTitle.text = "RegistrationVC.lblTitle1.text".localize_
                break
            case .step2:
                self.stackViewStep1.isHidden = true //hideAnimated(in: self.stackViewStep1?.superview as! UIStackView)
                self.stackViewStep2.isHidden = false //showAnimated(in: self.stackViewStep1?.superview as! UIStackView)
                self.lblBtnRegisterTitle.text = "RegistrationVC.lblRegister.text".localize_
                self.imgBtnRegister.isHidden = true
                if UserProfile.sharedInstance.isRTL() == true {
                    self.imgStepStatus.image = UIImage(named: "ic_signup_page2Ar")
                } else {
                    self.imgStepStatus.image = UIImage(named: "ic_registration_step_2")
                }
                self.lblTitle.text = "RegistrationVC.lblTitle2.text".localize_
                
                break
            }
        }
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgStepStatus: UIImageView!
    
    @IBOutlet weak var stackViewStep1: UIStackView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: AllowedCharsTextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtMobileNumber: AllowedCharsTextField!
    @IBOutlet weak var imgFullNameCheck: UIImageView!
    @IBOutlet weak var imgEmailCheck: UIImageView!
    @IBOutlet weak var imgPasswordCheck: UIImageView!
    @IBOutlet weak var imgConfirmPasswordCheck: UIImageView!
    @IBOutlet weak var imgMobileNumberCheck: UIImageView!
    
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobileNumber: UILabel!
    
    @IBOutlet weak var stackViewStep2: UIStackView!
    @IBOutlet weak var lblCarMaker: UILabel!
    @IBOutlet weak var lblCarMakerStar: UILabel!
    @IBOutlet weak var lblCarModel: UILabel!
    @IBOutlet weak var lblCarModelStar: UILabel!
    @IBOutlet weak var lblCarYear: UILabel!
    @IBOutlet weak var lblCarYearStar: UILabel!
    @IBOutlet weak var txtCarPlateNumber: UITextField!
    @IBOutlet weak var txtCarColor: UITextField!
    
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var lblTemsValue: UILabel!
    
    @IBOutlet weak var lblBtnRegisterTitle: UILabel!
    @IBOutlet weak var imgBtnRegister: UIImageView!
    
    var carMaker : TCarMakerObject?{
        didSet{
            if carMaker != nil {
                self.lblCarMaker.text = self.carMaker?.s_title
                self.lblCarMakerStar.isHidden = true
            }
        }
    }
    var carModel : TCarModelObject?{
        didSet{
            if carModel != nil {
                self.lblCarModel.text = self.carModel?.s_title
                self.lblCarModelStar.isHidden = true
            }
        }
    }
    var carYear : TCarYearObject?{
        didSet{
            if carYear != nil {
                self.lblCarYear.text = self.carYear?.s_title
                self.lblCarYearStar.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txtCarColor.placeholder = "PaymentMethodVC.lblCarColor.text".localize_
        self.txtEmail.placeholder = "emailPlaceholder".localize_
         
        // Do any additional setup after loading the view.
        self.stackViewStep2.isHidden = true
        self.checkBox.boxType = .square
        
        let underlineAttriString = NSAttributedString(string: self.lblTemsValue.text ?? "",
                                                      attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
        self.lblTemsValue.attributedText = underlineAttriString
        
        
        self.imgFullNameCheck.isHidden        = true
        self.imgEmailCheck.isHidden           = true
        self.imgPasswordCheck.isHidden        = true
        self.imgConfirmPasswordCheck.isHidden = true
        self.imgMobileNumberCheck.isHidden    = true
        
        #if DEBUG
        #else
        #endif
        
        if UserProfile.sharedInstance.isRTL() == true {
            self.imgStepStatus.image = UIImage(named: "ic_signup_page1Ar")
            txtFullName.placeholder = "RegistrationVC.fullName.placeholder".localize_
     //       txtEmail.placeholder = "RegistrationVC.email.placeholder".localize_
           // txtMobileNumber.placeholder = "RegistrationVC.mobile.placeholder".localize_
            
        } else {
            self.imgStepStatus.image = UIImage(named: "ic_registration_step_1")
//          txtFullName.placeholder = "RegistrationVC.fullName.placeholder".localize_
//          txtEmail.placeholder = "RegistrationVC.email.placeholder".localize_
//          txtMobileNumber.placeholder = "RegistrationVC.mobile.placeholder".localize_
        }
        
        txtCarPlateNumber.keyboardType = UIKeyboardType.namePhonePad

    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "toPaymentMethodVC" {
            let vc = segue.destination as! PaymentMethodViewController
            vc.carObject = (sender as! NSArray).firstObject as? TCarObject
            vc.isFromRegistration = true
            vc.packageObject = (sender as! NSArray).lastObject as? TPackageObject

        }
     }
    
    func showErrorMSG(msgText:String) -> Bool {
        self.showPopAlert(title: "Error".localize_, message: "TextFeildValidation".localized(with: msgText))
        return false
    }
    func alreadyExist(msgText:String) -> Bool {
        self.showPopAlert(title: "Error".localize_, message: "alreadyExisted".localized(with: msgText))
        return false
    }
    
    
    func validation() -> Bool {
        if self.stepStatus == .step1 {
            if self.txtFullName.text?.isEmptyOrWhiteSpace() == true{
                return self.showErrorMSG(msgText: "UserName".localize_)
            }else if self.txtEmail.text?.isValidEmail() == false{
                return self.showErrorMSG(msgText: "Email".localize_)
            }else if self.txtPassword.text?.isEmptyOrWhiteSpace() == true || (self.txtPassword.text ?? "").count < 6{
                return self.showErrorMSG(msgText: "Password".localize_)
            }else if self.txtConfirmPassword.text?.isEmptyOrWhiteSpace() == true || self.txtConfirmPassword.text != self.txtPassword.text{
                return self.showErrorMSG(msgText: "InvalidPassword".localize_)
            }else if self.txtMobileNumber.text?.count != 8{
                self.showPopAlert(title: "Error".localize_, message: "MobileDigits".localized(with: "8"))
                return false
            }
        }else{
            if self.carMaker == nil {
                return self.showErrorMSG(msgText: "RegistrationVC.lblCarMaker.text".localize_)
            }else if self.carModel == nil {
                return self.showErrorMSG(msgText: "RegistrationVC.lblCarModel.text".localize_)
            }else if self.carYear == nil {
                return self.showErrorMSG(msgText: "RegistrationVC.lblCarYear.text".localize_)
            }
                //            else if self.txtCarPlateNumber.text?.isEmptyOrWhiteSpace() == true{
                //                return self.showErrorMSG(msgText: "RegistrationVC.lblCarPlateNumber.text".localize_)
                //            }
            else if self.txtCarColor.text?.isEmptyOrWhiteSpace() == true{
                return self.showErrorMSG(msgText: "RegistrationVC.lblCarColor.text".localize_)
            }else if self.checkBox.on == false{
                self.showPopAlert(title: "Error".localize_, message: "PleaseAcceptTheTerms".localize_)
                return false
            }
        }
        return true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        if self.stepStatus == .step2 {
            self.stepStatus = .step1
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSelectCarMaker(_ sender: Any) {
        self.presentPickerView(.make)
    }
    @IBAction func btnSelectCarModel(_ sender: Any) {
        if self.carMaker == nil {
            self.showErrorMSG(msgText: "RegistrationVC.lblCarMaker.text".localize_)
            return
        }
        self.presentPickerView(.model)
    }
    @IBAction func btnSelectCarYear(_ sender: Any) {
        if self.carModel == nil {
            self.showErrorMSG(msgText: "RegistrationVC.lblCarModel.text".localize_)
            return
        }
        self.presentPickerView(.year)
    }
    
    fileprivate func presentPickerView(_ type:RegestrationVCPickerType){
        let alert = UIAlertController(style: .actionSheet, title: "RegistrationVC.presentPickerView.title".localize_, message: type.s_msg)
        let tempData = TempClass.sharedInstance
        var pickerViewValues: [[String]] = []
        if type == .make {
            var arr = [String]()
            for obj in tempData.carMakersArray ?? [] {
                arr.append(obj.s_title ?? "")
            }
            pickerViewValues = [arr]
        }else if type == .model {
            var arr = [String]()
            for obj in carMaker?.models ?? [] {
                arr.append(obj.s_title ?? "")
            }
            pickerViewValues = [arr]
        }else if type == .year {
            var arr = [String]()
            for obj in carModel?.years ?? [] {
                arr.append(obj.s_title ?? "")
            }
            pickerViewValues = [arr]
        }
        var selectedIndex = 0
        
        /*
         alert.addPickerView(values: pickerViewValues, initialSelection: (column: 0, row: 0), withSerchBar: true) { vc, picker, index, values in
         selectedIndex = index.row
         }
         */
        
        alert.addPickerView(values: pickerViewValues) { (vc, picker, index, values) in
            selectedIndex = index.row
        }
        
        alert.addAction(title: "OK".localize_, color: UIColor(named: "#009BA2"), style: .default, isEnabled: true) { (alert) in
            switch type {
            case .make:
                if  tempData.carMakersArray?.count == 0 {
                    return
                }
                self.lblCarMaker.text   = pickerViewValues[0][selectedIndex]
                self.carMaker           = tempData.carMakersArray?[selectedIndex]
                break
            case .model:
                if  self.carMaker?.models.count == 0 {
                    return
                }
                self.lblCarModel.text = pickerViewValues[0][selectedIndex]
                self.carModel         = self.carMaker?.models[selectedIndex]
                break
            case .year:
                if  self.carModel?.years.count == 0 {
                    return
                }
                self.lblCarYear.text = pickerViewValues[0][selectedIndex]
                self.carYear         = self.carModel?.years[selectedIndex]
                break
            }
        }
        alert.addAction(title: "Cancel".localize_, style: .cancel)
        //        alert.show()
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnChangeTemsSelection(_ sender: Any) {
        self.checkBox.setOn(!self.checkBox.on, animated: true)
    }
    
    @IBAction func btnTerms(_ sender: Any) {
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        if !self.validation() {
            return
        }
        if self.stepStatus == .step1 {
            let request = UserRequest(.check_register_data)
            request.email = self.txtEmail.text
            request.mobile = self.txtMobileNumber.text
            NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                if (responce.checkMobile ?? "").isEmptyOrWhiteSpace() == false{
                    self.imgMobileNumberCheck.image = UIImage(named:"ic_wrong")
                    if UserProfile.sharedInstance.isRTL() == true {
                        self.alreadyExist(msgText: "رقم الجوال مستخدم مسبقا")
                    }
                    else {
                        self.alreadyExist(msgText: "The mobile number is already exist")
                    }
                }else{
                    self.imgMobileNumberCheck.image = UIImage(named:"ic_checkMark")
                }
                if (responce.checkEmail ?? "").isEmptyOrWhiteSpace() == false{
                    self.imgEmailCheck.image = UIImage(named:"ic_wrong")
                    if UserProfile.sharedInstance.isRTL() == true {
                        self.alreadyExist(msgText: "البريد الالكتروني مستخدم مسبقا")
                    }
                    else {
                        self.alreadyExist(msgText: "The Email is already exist.")
                    }
                }else{
                    self.imgEmailCheck.image = UIImage(named:"ic_checkMark")
                    
                }
                self.imgFullNameCheck.isHidden        = false
                self.imgEmailCheck.isHidden           = false
                self.imgPasswordCheck.isHidden        = false
                self.imgConfirmPasswordCheck.isHidden = false
                self.imgMobileNumberCheck.isHidden    = false

                if (responce.checkEmail ?? "").isEmptyOrWhiteSpace() == true && (responce.checkMobile ?? "").isEmptyOrWhiteSpace() == true {
                    self.stepStatus = .step2
                }
            }
        }else{
            self.view.endEditing(false)
            let request = UserRequest(.registration)
            request.email        = self.txtEmail.text
            request.password     = self.txtPassword.text
            request.full_name    = self.txtFullName.text
            request.mobile       = self.txtMobileNumber.text
            request.car_maker_id = self.carMaker?.pk_i_id
            request.car_model_id = self.carModel?.pk_i_id
            request.car_year_id  = self.carYear?.pk_i_id
            request.plate_number = self.txtCarPlateNumber.text?.replacingOccurrences(of: " - ", with: "")
            request.color        = self.txtCarColor.text
            NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                UserProfile.sharedInstance.currentUser = responce.userObject
//                let str = responce.status?.message ?? "RegisterSuccess".localize_
//                self.showPopAlert(title: "Done".localize_, message: str ,okAction: {
                    self.afterRegistration()
//                })
            }
        }
    }
    
    func afterRegistration(){
        let request = CarsRequest(.list)
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            var arr = [self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()]
//            if let car = responce.carsArray.first {
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectCarViewController") as? SelectCarViewController {
//                    vc.selectedCar = car
//                    arr.append(vc)
//                }
//                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PackagesViewController") as? PackagesViewController {
//                    vc.object = car
//                    arr.append(vc)
//                }
//            }
//            AppDelegate.sharedInstance.rootNavigationController?.setViewControllers(arr, animated: false)
            
            NLRequestWrapper.sharedInstance.makeRequest(request: GeneralRequest(.packages)).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce2) in
                
                let vc = PaymentMethodViewController.initiateInstance() as! PaymentMethodViewController
                vc.carObject = responce.carsArray.first
                vc.isFromRegistration = true
                vc.packageObject = responce2.packagesArray.first
                arr.append(vc)
                self.navigationController?.setViewControllers(arr, animated: true)
//                self.performSegueWithCheck(withIdentifier: "toPaymentMethodVC", sender: [responce.carsArray.first,responce2.packagesArray.first])

            }
        }
    }
}

extension RegestrationViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField == txtCarPlateNumber) {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString.applyPatternOnNumbers(pattern: "## - #######################################", replacmentCharacter: "#")
            return false
        }
        else {
            return true
        }
    }
}





