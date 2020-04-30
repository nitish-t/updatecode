/*************************  *************************/
//
//  UIButtonEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

extension UIButton {
    @IBInspectable
    var localized: String? {
        get {
            return self.titleLabel?.text
        }
        set {
            self.setTitle(newValue?.localize_, for: .normal)
        }
    }
    @IBInspectable
    var localizedImg: String? {
        get {
            return UserDefaults.standard.value(forKey: "localizedImg extension UIButton") as? String
        }
        set {
            UserDefaults.standard.setValue("localizedImg extension UIButton", newValue)
            UserDefaults.standard.synchronize()
            self.setImage(UIImage(named: newValue?.localize_ ?? ""), for: .normal)
        }
    }
}
