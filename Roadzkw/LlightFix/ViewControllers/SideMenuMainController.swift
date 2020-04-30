//
//  SideMenuMainController.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//
import UIKit
import LGSideMenuController
class SideMenuMainController: LGSideMenuController {

    var sideMenu : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.changeNavBar(NavBarTransparent: true, statusBarWhite: false)

        AppDelegate.sharedInstance.sideMenuVC = self
        self.delegate = self
        
        sideMenu = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuViewController")
        
        if UserProfile.sharedInstance.isRTL() == false {
            self.leftViewController = sideMenu
            self.leftViewWidth = CGFloat(UIScreen.main.bounds.width * 0.75)
            self.leftViewCoverBlurEffect = UIBlurEffect.init(style: .light)
            self.leftViewPresentationStyle = .scaleFromBig
            self.isLeftViewSwipeGestureEnabled = false
            self.leftViewBackgroundColor = sideMenu?.view.backgroundColor
        } else {
            self.rightViewController = sideMenu
            self.rightViewWidth = CGFloat(UIScreen.main.bounds.width * 0.75)
            self.rightViewPresentationStyle = .scaleFromBig
            self.rightViewCoverBlurEffect = UIBlurEffect.init(style: .light)
            self.isRightViewSwipeGestureEnabled = false
            self.rightViewBackgroundColor = sideMenu?.view.backgroundColor
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

}

extension SideMenuMainController : LGSideMenuDelegate{
    func willShowLeftView(_ leftView: UIView, sideMenuController: LGSideMenuController) {
        self.sideMenu?.viewWillAppear(true)
    }
    func willShowRightView(_ rightView: UIView, sideMenuController: LGSideMenuController) {
        self.sideMenu?.viewWillAppear(true)
    }
}
