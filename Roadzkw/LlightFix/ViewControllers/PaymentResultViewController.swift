//
//  PaymentResultViewController.swift
//  LlightFix
//
//  Created by  on 7/3/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class PaymentResultViewController: BaseViewController {

    var object : TSubscriptionObject?
    var orderID : String?
    var resultOfPayment : Bool = true
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDone: roundedButton!
    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblCarModel: UILabel!
    @IBOutlet weak var lblEmergencySubscription: UILabel!
    @IBOutlet weak var lblSubscriptionDate: UILabel!
    @IBOutlet weak var lblSubscriptionExpiryDate: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.resultOfPayment == true {
            self.img.image = UIImage(named: "ic_payment_ok")
            self.lblTitle.text = "PaymentResultVC.lblTitle.SUCCESS.text".localize_
            self.btnDone.setTitle("PaymentResultVC.btnDone.SUCCESS.text".localize_, for: .normal)
            self.btnDone.backgroundColor = UIColor(named: "#00A2AA")
        }else{
            self.img.image = UIImage(named: "ic_payment_no")
            self.lblTitle.text = "PaymentResultVC.lblTitle.DECLINE.text".localize_
            self.btnDone.setTitle("PaymentResultVC.btnDone.DECLINE.text".localize_, for: .normal)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.3) {
                self.btnDone.backgroundColor = UIColor(named: "#FF002B")
            }
        }
        let orderId =  UserDefaults.standard.string(forKey: "orderId")

       // self.lblOrderID.text = self.object?.s_ref_id
        self.lblOrderID.text = orderId
        self.lblCarModel.text = self.object?.car?.s_name
        self.lblEmergencySubscription.text = "PaymentMethodVC.lblEmergencySubscriptionValue.text".localize_
        self.lblSubscriptionDate.text = self.object?.s_dt_subscription_start
        self.lblSubscriptionExpiryDate.text = self.object?.s_dt_subscription_end
        let tempTotalValue = Float(self.object?.s_final_total ?? UserProfile.sharedInstance.price)
//.formatedZeroNumber
        let newPrice = NSNumber(value: tempTotalValue!)
        if newPrice.stringValue != "0" {
            self.lblTotalPrice.text = "\(newPrice) \("KD".localize_)"
        }
        else{
            let WithDeximalPrice = NSNumber(value: tempTotalValue!).formatedTwoNumber
            self.lblTotalPrice.text = "\(WithDeximalPrice) \("KD".localize_)"

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
    @IBAction func btnBack(_ sender: Any) {
        self.performSegueWithCheck(withIdentifier: "unwindToHomeVC", sender: self)
    }
    @IBAction func btnDone(_ sender: Any) {
        if self.resultOfPayment == false {
            self.performSegueWithCheck(withIdentifier: "unwindToPaymentMethodVC", sender: self)
        }else{
            self.performSegueWithCheck(withIdentifier: "unwindToHomeVC", sender: self)
        }
    }
}
