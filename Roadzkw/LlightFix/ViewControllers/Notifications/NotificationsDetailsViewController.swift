//
//  NotificationsDetailsViewController.swift
//  LlightFix
//
//  Created by  on 9/5/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import MIBlurPopup

class NotificationsDetailsViewController: UIViewController {

    var object : TNotificationsObject?
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var txtView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblTitle.text = self.object?.s_title
        self.txtView.text = self.object?.s_body
        self.lblDate.text = self.object?.dt_created?.timeAgoSinceNow()
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
extension NotificationsDetailsViewController:MIBlurPopupDelegate{
    
    var popupView: UIView {
        return self.view
    }
    var blurEffectStyle: UIBlurEffect.Style {
        return .dark
    }
    var initialScaleAmmount: CGFloat {
        return 0.9
    }
    var animationDuration: TimeInterval {
        return 0.2
    }
}
