//
//  StaticPagesViewController.swift
//  LlightFix
//
//  Created by  on 6/29/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import WebKit
enum StaticPagesVCType {
    case terms
    case about_us
    case privacy
    
    var s_text : String? {
        switch self {
        case .terms:
            return TempClass.sharedInstance.settingsObject?.s_terms ?? ""
        case .about_us:
            return TempClass.sharedInstance.settingsObject?.s_about_us ?? ""
        case .privacy:
            return TempClass.sharedInstance.settingsObject?.s_privacy ?? ""
        }
    }
    var s_title : String? {
        switch self {
        case .terms:
            return "RegistrationVC.lblTemsValue.text".localize_
        case .about_us:
            return "SideMenuVC.CellType.about_us".localize_
        case .privacy:
            return "SideMenuVC.CellType.privacy".localize_
        }
    }
    
}
class StaticPagesViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    var vcType : StaticPagesVCType = .terms
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblTitle.text = self.vcType.s_title
        let font = UIFont(name: AppFontName.regular, size: UIFont.getFontSize(14))!
        self.webView.loadHTMLString(self.vcType.s_text?.html(font: font) ?? "", baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension StaticPagesViewController : UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        RequestOperationBuilder().showHideLoaderView(showLoader: true)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        RequestOperationBuilder().showHideLoaderView(showLoader: false)
    }
}
