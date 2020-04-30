/*********  *********/
//
//  MyCarsTableViewCell.swift
//  LlightFix
//
//  Created by  on 7/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class MyCarsTableViewCell : GeneralTableViewCell, UITableViewDelegate {

    @IBOutlet weak var add: roundedButton!
    @IBOutlet weak var plattxt: UITextField!
    @IBOutlet weak var platnumber: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var stackViewContaner: UIStackView!
    @IBOutlet weak var lblSubNumber: UILabel!
    @IBOutlet weak var lblPaletNumber: UILabel!
    @IBOutlet weak var lblCarColor: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var lblEndDate: UILabel!
    @IBOutlet weak var stackViewDates: UIStackView!
    @IBOutlet weak var lblNoSub: UILabel!
    @IBOutlet weak var stackViewNoSubScript: UIStackView!
    @IBOutlet weak var viewPayButton: UIView!
    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var lblTitleStatus: UILabel!
    
    var platano = ""
    var caridnumber = NSNumber()
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
         plattxt.delegate = self
          let data =   self.platano.replacingOccurrences(of: " - ", with: "")
          self.lblPaletNumber.text! = data
     
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
        override func configerCell() {
            let obj = self.object.object as! TCarObject
            print (obj)
            print(platano)
//            if platano == "" {
//
//            } else {
//                let data =   self.platano.replacingOccurrences(of: " - ", with: "")
//                self.lblPaletNumber.text! = data
//            }
//
            let carid = obj.pk_i_id
            self.caridnumber = carid!
            self.lblTitle.text = obj.s_name
            let pltno = obj.s_plate_number
            self.lblPaletNumber.text = pltno
            self.lblCarColor.text = obj.s_color
            self.stackViewContaner.isHidden = !obj.isCellShowAllInfo
            self.imgArrow.image = UIImage(named: obj.isCellShowAllInfo ? "ic_drop_down_arrow_up" : "ic_drop_down_arrow")
            self.btnStatus.setTitle("AddCarVC.btnPay.text".localize_, for: UIControl.State.normal)
             self.add.setTitle("Add".localize_, for: UIControl.State.normal)
      
               self.add.addTarget(self, action: #selector(addcarpaltnumber), for: .touchUpInside)
            self.btnStatus.addTarget(self, action: #selector(callPaymentScreen), for: .touchUpInside)

            if let sub = obj.subscription {
                self.stackViewDates.isHidden = false
                self.lblNoSub.isHidden = true
                self.lblSubNumber.superview?.isHidden = false
                self.lblStartDate.text = sub.s_dt_subscription_start
                self.lblEndDate.text   = sub.s_dt_subscription_end
                self.lblSubNumber.text = sub.s_ref_id
                
                if sub.b_payed == 1 {
                                    self.btnStatus.isHidden = true
                                    if sub.s_status == "not_active" {
                                        self.lblTitleStatus.textColor = UIColor.gray
                                        self.lblTitleStatus.text = "MyCarsVC.lblStatus.text".localize_
                                    } else {
                                        self.lblTitleStatus.textColor = #colorLiteral(red: 0, green: 0.5450980392, blue: 0.568627451, alpha: 1)
                                        self.lblTitleStatus.text = "MyCarsVC.lblStatus.active".localize_

                                    }
                }
                else {
                                                 self.lblTitleStatus.text = obj.subscription?.s_status
                                     self.stackViewDates.isHidden = true
                                     self.lblSubNumber.superview?.isHidden = true
                                     self.lblNoSub.isHidden = false
                                      self.btnStatus.isHidden = false
                                     self.lblTitleStatus.text = "MyCarsVC.lblStatus.notPaid".localize_
                                     self.lblTitleStatus.textColor = UIColor.red

                }

            }else{

                self.lblTitleStatus.text = obj.subscription?.s_status
                self.stackViewDates.isHidden = true
                self.lblSubNumber.superview?.isHidden = true
                self.lblNoSub.isHidden = false
                 self.btnStatus.isHidden = false
                self.lblTitleStatus.text = "MyCarsVC.lblStatus.notPaid".localize_
                self.lblTitleStatus.textColor = UIColor.red
            }
            if UserProfile.sharedInstance.isRTL() == true {
                 self.lblTitleStatus.textAlignment = .right
             }
             else  {
                 self.lblTitleStatus.textAlignment = .left
             }
        }
        override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let obj = self.object.object as! TCarObject
            obj.isCellShowAllInfo = !obj.isCellShowAllInfo
            tableView.reloadRows(at: [self.indexPath], with: .automatic)
            
        }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let obj = self.object.object as! TCarObject
        self.btnStatus.setTitle("AddCarVC.btnPay.text".localize_, for: UIControl.State.normal)
        self.btnStatus.addTarget(self, action: #selector(callPaymentScreen), for: .touchUpInside)
        self.btnStatus.isHidden = false
        if let sub = obj.subscription {
            if sub.b_payed == 1 {
                                                self.btnStatus.isHidden = true
                                               if sub.s_status == "not_active" {
                                                   self.lblTitleStatus.textColor = UIColor.gray
                                                self.lblTitleStatus.text = "MyCarsVC.lblStatus.text".localize_
                                               } else {
                                                   self.lblTitleStatus.textColor = #colorLiteral(red: 0, green: 0.5450980392, blue: 0.568627451, alpha: 1)
                                                self.lblTitleStatus.text = "MyCarsVC.lblStatus.active".localize_

                                               }
                           }
                           else {
                                                           self.lblTitleStatus.text = obj.subscription?.s_status
                                                self.stackViewDates.isHidden = true
                                                self.lblSubNumber.superview?.isHidden = true
                                                self.lblNoSub.isHidden = false
                                                 self.btnStatus.isHidden = false
                                                self.lblTitleStatus.text = "MyCarsVC.lblStatus.notPaid".localize_
                                                self.lblTitleStatus.textColor = UIColor.red

                           }
        }
        else {
            self.btnStatus.isHidden = false
             self.lblTitleStatus.text = "MyCarsVC.lblStatus.notPaid".localize_
            self.lblTitleStatus.textColor = UIColor.red
        }
        if UserProfile.sharedInstance.isRTL() == true {
            self.lblTitleStatus.textAlignment = .right
        }
        else  {
            self.lblTitleStatus.textAlignment = .left
        }

    }
        @IBAction func btnDelete(_ sender: Any) {
            let obj = self.object.object as! TCarObject

            let alertController = UIAlertController(title: "Attention".localize_, message:"MyCarsTableViewCell.btnDelete.alert.msg".localize_, preferredStyle:.alert)
            alertController.addAction(UIAlertAction(title: "MyCarsTableViewCell.btnDelete.text".localize_, style:.destructive, handler: { (action) in
                let request = CarsRequest(.delete)
                request.pk_i_id = obj.pk_i_id
                NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                    (self.parentVC as! MyCarsViewController).setupTableView()
                }
            }))
            alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                
            }))
            self.parentVC.present(alertController, animated: true, completion: nil)
        }
        
        
    
    @objc func callPaymentScreen() {
            let obj = self.object.object as! TCarObject
            
            let dataInfo:[String: TCarObject] = ["dataInfo": obj]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "goToPaymentScreen"), object: nil, userInfo: dataInfo)
        }

    
    @objc func addcarpaltnumber() {
        let request = UserRequest(.UpdatePlate)
        self.platano = plattxt.text!
        request.plate_number = self.platano.replacingOccurrences(of: " - ", with: "")
        request.carid = caridnumber
      NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
        print(responce)
         self.tableView.reloadRows(at: [self.indexPath], with: .automatic)
           }
        
   
    }
    
    
    }
extension MyCarsTableViewCell : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if (textField == plattxt) {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            textField.text = newString.applyPatternOnNumbers(pattern: "## - #######################################", replacmentCharacter: "#")
            return false
        }
        else {
            return true
        }
    }
}
