/*************************  *************************/
//
//  SideMenuTableViewCell.swift
//  LlightFix
//
//  Created by  on 6/29/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class SideMenuTableViewCell : GeneralTableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func configerCell() {
        let obj = self.object.object as! SideMenuVCCellType
        self.img.image = UIImage(named: obj.s_image_name)
        self.lblTitle.text = obj.s_title
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserProfile.sharedInstance.openMenuBaseedOnLang()
        let obj = self.object.object as! SideMenuVCCellType
        switch obj {
        case .home:
            if let vc = self.parentVC.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                self.presentVC(vc: vc)
            }
            break
        case .profile:
            if UserProfile.sharedInstance.checkIfUserLogin(alert: true) == false {
                return
            }
            self.presentVC(segueID: "toProfileVC")
            break
        case .login:
            //print("check user default value", UserProfile.sharedInstance.isSelectGest) // RegestrationViewController
//            if let vc = self.parentVC.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
//                self.presentVC(vc: vc,push:true)
//            }
            if UserProfile.sharedInstance.isSelectGest?.boolValue == true{
                
//                if let vc = self.parentVC.storyboard?.instantiateViewController(withIdentifier: "RegestrationViewController") {
//                    self.presentVC(vc: vc,push:true)
//                }
                
                if let vc = self.parentVC.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                    self.presentVC(vc: vc,push:true)
                    
                }
                
            }else{
                if let vc = self.parentVC.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") {
                    self.presentVC(vc: vc,push:true)
                }
            }
            
            break
        case .my_cars:
            if UserProfile.sharedInstance.checkIfUserLogin(alert: true) == false {
                return
            }
            self.presentVC(segueID: "toMyCarsVC")
            break
        case .my_subscriptions:
            if UserProfile.sharedInstance.checkIfUserLogin(alert: true) == false {
                return
            }
            self.presentVC(segueID: "toMySubscriptionsVC")
            break
        case .our_services:
            self.presentVC(segueID: "toOurServicesVC")
            break
        case .about_us:
            if let vc = self.parentVC.storyboard?.instantiateViewController(withIdentifier: "StaticPagesViewController") {
                (vc as! StaticPagesViewController).vcType = .about_us
                self.presentVC(vc: vc,present: true)
            }
            break
        case .contact_us:
//            if UserProfile.sharedInstance.checkIfUserLogin(alert: true) == false {
//                return
//            }
            self.presentVC(segueID: "toContactUSVC")
            break
        case .settings:
            self.presentVC(segueID: "toSettingsVC")
            break
        case .logout:
            let alertController = UIAlertController(title: "Attention".localize_, message:"DoYouWantToLogout".localize_, preferredStyle:.alert)
            alertController.addAction(UIAlertAction(title: "Logout".localize_, style:.default, handler: { (action) in
                let request = UserRequest(.logout)
                NLRequestWrapper.sharedInstance.makeRequest(request: request).executeWithCheckResponse(showLodaer: true, showMsg: true) { (responce) in
                    UserProfile.sharedInstance.currentUser = nil
                }
            }))
            alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
                
            }))

            AppDelegate.sharedInstance.rootNavigationController?.present(alertController, animated: true, completion: nil)
            break
        }
    }
    func presentVC(segueID:String? = nil,vc:UIViewController? = nil,present:Bool = false,push:Bool = false){
        if segueID != nil {
            AppDelegate.sharedInstance.rootNavigationController.performSegueWithCheck(withIdentifier: segueID ?? "", sender: self)
        }else if vc == nil {
            return
        }else if present == true {
            AppDelegate.sharedInstance.rootNavigationController.present(vc!, animated: true, completion: nil)
        }else if push == true {
            AppDelegate.sharedInstance.rootNavigationController?.pushViewController(vc!, animated: true)
        }else{
            AppDelegate.sharedInstance.rootNavigationController?.setViewControllers([vc!], animated: true)
        }
    }
}
