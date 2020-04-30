//
//  SideMenuViewController.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

enum SideMenuVCCellType {
    case home
    case profile
    case login
    case my_cars
    case my_subscriptions
    case our_services
    case about_us
    case contact_us
    case settings
    case logout
    
    var s_title : String {
        switch self {
        case .home:
            return "SideMenuVC.CellType.home".localize_
        case .profile:
            return "SideMenuVC.CellType.profile".localize_
        case .login:
            return "SideMenuVC.CellType.login".localize_
        case .my_cars:
            return "SideMenuVC.CellType.my_cars".localize_
        case .my_subscriptions:
            return "SideMenuVC.CellType.my_subscriptions".localize_
        case .our_services:
            return "SideMenuVC.CellType.our_services".localize_
        case .about_us:
            return "SideMenuVC.CellType.about_us".localize_
        case .contact_us:
            return "SideMenuVC.CellType.contact_us".localize_
        case .settings:
            return "SideMenuVC.CellType.settings".localize_
        case .logout:
            return "SideMenuVC.CellType.logout".localize_
        }
    }
    
    var s_image_name : String {
        switch self {
        case .home:
            return "ic_home"
        case .profile:
            return "ic_user"
        case .login:
            return "ic_user"
        case .my_cars:
            return "ic_car"
        case .my_subscriptions:
            return "ic_mysubscriptions"
        case .our_services:
            return "ic_services"
        case .about_us:
            return "ic_menu_logo_small"
        case .contact_us:
            return "ic_contact_us"
        case .settings:
            return "ic_settings"
        case .logout:
            return "ic_logout"
        }
    }
}

class SideMenuViewController: BaseViewController {

    @IBOutlet weak var tableView: GeneralTableView!
    @IBOutlet weak var stackViewLogoContaner: UIStackView!
    @IBOutlet weak var lblUserName: UILabel!
    
    let settings = TempClass.sharedInstance.settingsObject
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupView()
    }
    func setupView(){
        self.tableView.clearData(true)
        let user = UserProfile.sharedInstance.currentUser
        if UserProfile.sharedInstance.checkIfUserLogin(alert: false) == false {
            self.stackViewLogoContaner.isHidden = false
            self.lblUserName.superview?.isHidden = true
//            self.addCell(.home)
            self.addCell(.login)
            self.addCell(.about_us)
            self.addCell(.contact_us)
            self.addCell(.settings)            
        }else{
            self.lblUserName.text = "\(user?.s_full_name ?? "")\n\(user?.s_email ?? "")"
            self.stackViewLogoContaner.isHidden = true
            self.lblUserName.superview?.isHidden = false
//            self.addCell(.home)
//            self.addCell(.profile)
            self.addCell(.my_cars)
//            self.addCell(.my_subscriptions)
            self.addCell(.our_services)
            self.addCell(.about_us)
            self.addCell(.contact_us)
            self.addCell(.settings)
            self.addCell(.logout)
        }
        self.tableView.reloadData()
    }
    func addCell(_ type : SideMenuVCCellType){
        self.tableView.objects.append(GeneralTableViewData(reuseIdentifier: "SideMenuTableViewCell", object: type, rowHeight: nil))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btnProfile(_ sender: Any) {
        UserProfile.sharedInstance.openMenuBaseedOnLang()
        AppDelegate.sharedInstance.rootNavigationController.performSegueWithCheck(withIdentifier: "toProfileVC", sender: self)
    }
    @IBAction func btnFacebook(_ sender: Any) {
        self.openExternalURL(self.settings?.s_facebook ?? "")
    }
    @IBAction func btnTwitter(_ sender: Any) {
        self.openExternalURL(self.settings?.s_twitter ?? "")
    }
    @IBAction func btnInstagram(_ sender: Any) {
        self.openExternalURL(self.settings?.s_instagram ?? "")
    }
    
    func openExternalURL(_ path:String){
        var checkedPath = path
        if checkedPath.hasPrefix("http") == false {
            checkedPath = "https://" + checkedPath
        }
        if let url = URL(string: checkedPath) {
            if UIApplication.shared.canOpenURL(url) == true{
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                self.showPopAlert(title: "Error".localize_, message: "An error occurred".localize_)
            }
        }else{
            self.showPopAlert(title: "Error".localize_, message: "An error occurred".localize_)
        }
    }
}
