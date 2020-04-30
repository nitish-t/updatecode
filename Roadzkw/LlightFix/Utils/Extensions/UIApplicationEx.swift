/*************************  *************************/
//
//  UIApplicationEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit

extension UIApplication {
    class func topViewController_(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController_(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController_(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController_(controller: presented)
        }
        return controller
    }
}
