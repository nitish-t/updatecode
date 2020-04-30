//
//  AddCarViewController.swift
//  LlightFix
//
//  Created by  on 7/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class AddCarViewController: BaseViewController {
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
    @IBOutlet weak var lblCarMaker: UILabel!
    @IBOutlet weak var lblCarMakerStar: UILabel!
    @IBOutlet weak var lblCarModel: UILabel!
    @IBOutlet weak var lblCarModelStar: UILabel!
    @IBOutlet weak var lblCarYear: UILabel!
    @IBOutlet weak var lblCarYearStar: UILabel!
    @IBOutlet weak var lblCarPlateNumber: UILabel!
    @IBOutlet weak var lblCarPlateStar: UILabel!
    @IBOutlet weak var lblCarColor: UILabel!
    @IBOutlet weak var lblCarColorStar: UILabel!

    @IBOutlet weak var txtCarPlateNumber: UITextField!
    @IBOutlet weak var txtCarColor: UITextField!

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
        self.lblCarPlateNumber.text = "\n" + "RegistrationVC.lblCarPlateNumber.text".localize_
        self.lblCarPlateStar.text = "\n" + "*"
        
        self.lblCarColor.text = "\n" + "RegistrationVC.lblCarColor.text".localize_
        self.lblCarColorStar.text = "\n" + "*"
        self.txtCarColor.placeholder = "AddCarVC.txtCarColor.placeholder".localize_
        txtCarPlateNumber.keyboardType = UIKeyboardType.namePhonePad
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
        if self.carMaker == nil {
            return self.showErrorMSG(msgText: "RegistrationVC.lblCarMaker.text".localize_)
        }else if self.carModel == nil {
            return self.showErrorMSG(msgText: "RegistrationVC.lblCarModel.text".localize_)
        }else if self.carYear == nil {
            return self.showErrorMSG(msgText: "RegistrationVC.lblCarYear.text".localize_)
        }
//        else if self.txtCarPlateNumber.text?.isEmptyOrWhiteSpace() == true{
//            return self.showErrorMSG(msgText: "RegistrationVC.lblCarPlateNumber.text".localize_)
//        }
        else if self.txtCarColor.text?.isEmptyOrWhiteSpace() == true{
            return self.showErrorMSG(msgText: "RegistrationVC.lblCarColor.text".localize_)
        }
        return true
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
                //self.lblCarMaker.textColor = UIColor(hex: 0x333132)
                self.lblCarMaker.textColor = UserProfile.sharedInstance.hexStringToUIColor(hex: "0x333132")
                self.lblCarMaker.text   = pickerViewValues[0][selectedIndex]
                self.carMaker           = tempData.carMakersArray?[selectedIndex]
                break
            case .model:
                if  self.carMaker?.models.count == 0 {
                    return
                }
                self.lblCarModel.textColor = UserProfile.sharedInstance.hexStringToUIColor(hex: "0x333132")
                self.lblCarModel.text = pickerViewValues[0][selectedIndex]
                self.carModel         = self.carMaker?.models[selectedIndex]
                break
            case .year:
                if  self.carModel?.years.count == 0 {
                    return
                }
                self.lblCarYear.textColor = UserProfile.sharedInstance.hexStringToUIColor(hex: "0x333132")
                self.lblCarYear.text = pickerViewValues[0][selectedIndex]
                self.carYear         = self.carModel?.years[selectedIndex]
                break
            }
        }
        
        alert.addAction(title: "Cancel".localize_, style: .cancel)
        alert.show()
    }
    
    func alreadyExist(msgText:String) -> Bool {
        self.showPopAlert(title: "Error".localize_, message: "alreadyExisted".localized(with: msgText))
        return false
    }
    
    @IBAction func btnAddCar(_ sender: Any) {
        if !self.validation() {
            return
        }
        let request = CarsRequest(.add)
        request.car_maker_id = self.carMaker?.pk_i_id
        request.car_model_id = self.carModel?.pk_i_id
        request.car_year_id  = self.carYear?.pk_i_id
        request.plate_number = self.txtCarPlateNumber.text?.replacingOccurrences(of: " - ", with: "")
        request.color        = self.txtCarColor.text
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            

            print(responce.status?.codeNumber)
            print(responce.status?.message)

            if responce.status?.codeNumber?.intValue == 203 {
                if UserProfile.sharedInstance.isRTL() == true {
                    self.alreadyExist(msgText: "رقم اللوحة مستخدم مسبقا")
                }
                else {
                    self.alreadyExist(msgText: "The plate number is already exist")
                }
            }
            else {
                self.showPopAlert(title: "Done".localize_, message: responce.status?.message ?? "SuccessSendRequest".localize_,okAction: {
                   // self.performSegueWithCheck(withIdentifier: "unwindToMyCarsVC", sender: self)
                    
                    self.afterRegistration()
                })
            }
           // UserProfile.sharedInstance.currentUser = responce.userObject
        }
    }
    
    
    
    
     func afterRegistration(){
            let request = CarsRequest(.list)
            NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                var arr = [self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") ?? HomeViewController()]
   
                
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

extension AddCarViewController : UITextFieldDelegate{
    
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
