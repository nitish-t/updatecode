//
//  OurServicesViewController.swift
//  LlightFix
//
//  Created by  on 6/29/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import WebKit

enum OurServicesVCType {
    case maintenance_and_emergency
    case service_emergency
}

class OurServicesViewController: BaseViewController {

    @IBOutlet weak var btnMaintenance: UIButton!
    @IBOutlet weak var btnEmergency: UIButton!
    @IBOutlet weak var btnSubscribe: roundedButton!
    
    @IBOutlet weak var webView: WKWebView!
    
    var vcType: OurServicesVCType = .maintenance_and_emergency
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if self.vcType == .service_emergency {
            self.btnMaintenance.isHidden = true
            self.btnSubscribe.isHidden = true
            self.btnEmergency(self.btnEmergency)
        }else{
            self.btnSubscribe.isHidden = true
            self.btnMaintenance.superview?.isHidden = false
            self.btnMaintenance(self.btnMaintenance)
        }
        
    }
    
    func reseSelection(){
        self.btnMaintenance.setTitleColor(.black, for: .normal)
        self.btnEmergency.setTitleColor(.black, for: .normal)
        
        self.btnMaintenance.backgroundColor = UIColor(named: "#DEDFE0")
        self.btnEmergency.backgroundColor = UIColor(named: "#DEDFE0")
    }
    func updateBtnSelection(_ sender:UIButton){
        sender.backgroundColor = UIColor(named: "#009BA2")
        sender.setTitleColor(.white, for: .normal)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func updateWebViewContent(_ htmlString:String){
        let font = UIFont(name: AppFontName.regular, size: UIFont.getFontSize(14))!
        self.webView.loadHTMLString(htmlString.html(font: font), baseURL: nil)

    }
    @IBAction func btnMaintenance(_ sender:UIButton){
        self.reseSelection()
        self.updateBtnSelection(sender)
        self.updateWebViewContent((TempClass.sharedInstance.settingsObject?.s_service_maintenance ?? ""))
    }
    @IBAction func btnEmergency(_ sender:UIButton){
        self.reseSelection()
        self.updateBtnSelection(sender)
        self.updateWebViewContent((TempClass.sharedInstance.settingsObject?.s_service_emergency ?? ""))
    }
    @IBAction func btnLogin(_ sender: Any) {
        self.performSegueWithCheck(withIdentifier: "toLoginVC", sender: self)
    }
}


extension OurServicesViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        RequestOperationBuilder().showHideLoaderView(showLoader: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        RequestOperationBuilder().showHideLoaderView(showLoader: false)
    }
}
