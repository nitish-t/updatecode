//
//  PaymentWebViewController.swift
//  LlightFix
//
//  Created by  on 7/2/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import WebKit

class PaymentWebViewController: BaseViewController,WKNavigationDelegate,WKUIDelegate {

    var link : String?
    var object : TSubscriptionObject?
    var orderID : String?
    var resultOfPayment : Bool = true
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
        if let url = URL(string: self.link ?? "") {
            self.webView.load(URLRequest(url: url))
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
        let orderId =  UserDefaults.standard.string(forKey: "orderId")

        let request = SubscriptionsRequest(.check_payment)
        request.order_id = orderId
        NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
            if responce.status?.success == true {
                          self.performSegueWithCheck(withIdentifier: "goToSuccessfullPaymentScreen", sender: responce.status?.success)
            }
            else
            {
                self.navigationController?.popViewController(animated: true)
            }

        }
    //   self.performSegueWithCheck(withIdentifier: "unwindToPaymentMethodVC", sender: self)
        
   //    self.navigationController?.popViewController(animated: true)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let orderId =  UserDefaults.standard.string(forKey: "orderId")

            if segue.identifier == "goToSuccessfullPaymentScreen"{
            let vc = segue.destination as! PaymentResultViewController
           // vc.object = self.subscriptionObject
            vc.resultOfPayment = (sender as? Bool) ?? true
            vc.orderID = self.orderID
            vc.object = self.object
            vc.resultOfPayment = (sender as? Bool) ?? true
        }
    }
    
}
extension PaymentWebViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        RequestOperationBuilder().showHideLoaderView(showLoader:true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        RequestOperationBuilder().showHideLoaderView(showLoader: false)
    }
//
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!){
              //SVProgressHUD.show(withStatus: "Please wait..")
          }
          
          func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!)
          {
              //SVProgressHUD.dismiss()
          }
          
          func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error)
          {
              //SVProgressHUD.dismiss()
          }
          
          
          public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!){
              
             // SVProgressHUD.dismiss()
              //        navigation.act
              //        if let urlStr = navigationAction.request.URL?.absoluteString{
              //            //urlStr is what you want, I guess.
              //        }
              //        decisionHandler(.Allow)
              
          }
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void){
        
           
           if let urlStr = navigationAction.request.url?.absoluteString{
               //            print(urlStr)
            if(urlStr == "\("https://roadzco.com/en")")
               {
                   
                  // SVProgressHUD.showSuccess(withStatus: "Your payment has been done successfully")
               let orderId =  UserDefaults.standard.string(forKey: "orderId")

                       let request = SubscriptionsRequest(.check_payment)
                       request.order_id = orderId
                       NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                           if responce.status?.success == true {
                                         self.performSegueWithCheck(withIdentifier: "goToSuccessfullPaymentScreen", sender: responce.status?.success)
                           }
                           else
                           {
                               self.navigationController?.popViewController(animated: true)
                           }

                       }
                
                   //self.navigationController?.popViewController(animated: true)
               }
            else {
                if(urlStr == "\("")")
                   {
//                     let orderId =  UserDefaults.standard.string(forKey: "orderId")
        let orderId =  UserDefaults.standard.string(forKey: "orderId")
           let request = SubscriptionsRequest(.check_payment)
       request.order_id = orderId
       NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
//           if responce.status?.success == true {
//           }
//           else
//           {
//
//           }

       }
                    
                      // SVProgressHUD.showError(withStatus: "You have canceled payment")
                       //self.dismiss(animated: true, completion: nil)
               }
               
           }
           //        if let urlStr = navigationAction.request.URL?.absoluteString{
           //            //urlStr is what you want, I guess.
           //        }@
           decisionHandler(.allow)
       }
    
    
    
    }
    
    
    
    
    
    
    
}
