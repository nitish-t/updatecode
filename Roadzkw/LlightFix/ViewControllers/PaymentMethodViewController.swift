//
//  PaymentMethodViewController.swift
//  LlightFix
//
//  Created by  on 7/2/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class PaymentMethodViewController: BaseViewController {

    var carObject:TCarObject?
    var packageObject:TPackageObject?
    
    @IBOutlet weak var imgSteps: UIImageView!
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblSubscriptionLength: UILabel!
    @IBOutlet weak var lblSubscriptionDate: UILabel!
    @IBOutlet weak var lblSubscriptionEndDate: UILabel!
    @IBOutlet weak var txtCopon: UITextField!
    @IBOutlet weak var lblCoponValue: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    var paymentlink : String?
    var order_id : String?
    var isFromRegistration : Bool = false
    var subscriptionObject:TSubscriptionObject?

    var coponValue : NSNumber? {
        didSet {
            if self.coponValue != nil {
                self.lblCoponValue.superview?.isHidden = false
                self.lblCoponValue.text = "\(self.coponValue?.stringValue ?? "0")%"
                
                var tempTotalValue = Float(self.packageObject?.s_price_ ?? UserProfile.sharedInstance.price)
              //  tempTotalValue = (Float(self.packageObject?.s_price_ ?? "0.0") ?? 0.0) * (self.coponValue?.floatValue ?? 0.0 / 100.0)
                
                let newPrice = Float(tempTotalValue! - (tempTotalValue! * (self.coponValue!.floatValue) / 100))
                self.lblTotalPrice.text = "\(NSNumber(value:newPrice ?? 0).formatedTwoNumber) \("KD".localize_)"
            }else{
                let tempTotalValue = Float(self.packageObject?.s_price_ ?? UserProfile.sharedInstance.price)

                let newPrice = NSNumber(value: tempTotalValue!).formatedZeroNumber
                
                self.lblTotalPrice.text = "\(newPrice) \("KD".localize_)"
                self.lblCoponValue.superview?.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.coponValue = nil
        self.lblCarName.text = self.carObject?.s_name
//        self.lblSubscriptionLength.text =
        self.lblSubscriptionDate.text = (NSDate().addingDays(2)! as NSDate).dateString(customFormat: "dd / MM / yyyy")
        self.lblSubscriptionEndDate.text = ((NSDate().addingDays(1)! as NSDate).addingYears(1)! as NSDate).dateString(customFormat: "dd / MM / yyyy")
       // let userPrice = UserProfile.sharedInstance.price
        
        let tempTotalValue = Float(self.packageObject?.s_price_ ?? UserProfile.sharedInstance.price)

        let newPrice = NSNumber(value: tempTotalValue!).formatedZeroNumber

        self.lblTotalPrice.text = "\(newPrice) \("KD".localize_)"
        self.imgSteps.isHidden = !self.isFromRegistration
        if UserProfile.sharedInstance.isRTL() == true {
            self.imgSteps.image = UIImage(named: "ic_signup_page3Ar")
        } else {
            self.imgSteps.image = UIImage(named: "ic_registration_step_3")
        }

    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toPaymentWebVC" {
            let vc = segue.destination as! PaymentWebViewController
            vc.link = self.paymentlink
            vc.object = self.subscriptionObject
            vc.resultOfPayment = (sender as? Bool) ?? true
            vc.orderID = self.order_id
        }else if segue.identifier == "toPaymentResultVC"{
            let vc = segue.destination as! PaymentResultViewController
            vc.object = self.subscriptionObject
            vc.resultOfPayment = (sender as? Bool) ?? true
            vc.orderID = self.order_id
        }
    }
    
    @IBAction func btnApplayCopon(_ sender: Any) {
        if (self.txtCopon.text ?? "").isEmptyOrWhiteSpace() == true {
            self.coponValue = nil
            return
        }
        let request = SubscriptionsRequest(.check_coupon)
        request.coupon = self.txtCopon.text
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            self.coponValue = responce.coponObject?.i_discount_percentage
            self.showPopAlert(title: "".localize_, message: responce.status?.message ?? "",okAction: {
            })
            
            
            
            
        }
    }
    @IBAction func btnPay(_ sender: Any) {
        let request = SubscriptionsRequest(.make)
        request.car_id = self.carObject?.pk_i_id
        request.coupon = self.coponValue != nil ? self.txtCopon.text : nil
        request.package_id = self.packageObject?.pk_i_id != nil ? self.packageObject?.pk_i_id : 1
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            if (responce.paymentlink ?? "").isEmptyOrWhiteSpace() == false {
                self.subscriptionObject = responce.subscriptionsObject
                self.paymentlink = responce.paymentlink
                self.order_id = responce.order_id
                UserDefaults.standard.set(String(responce.order_id!), forKey: "orderId")
                self.performSegueWithCheck(withIdentifier: "toPaymentWebVC", sender: responce.status?.success)
            }
        }
    }
    
    @IBAction func unwindToPaymentMethodVC(_ segue:UIStoryboardSegue){
        if segue.source is PaymentWebViewController {
            let request = SubscriptionsRequest(.check_payment)
            request.order_id = self.order_id
            NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                self.performSegueWithCheck(withIdentifier: "toPaymentResultVC", sender: responce.status?.success)
            }
        }
    }
}
