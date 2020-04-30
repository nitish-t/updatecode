/*************************  *************************/
//
//  UIBarItemEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

extension UIBarItem {
    @IBInspectable
    var localized: String? {
        get {
            return self.title
        }
        set {
            self.title = newValue?.localize_
        }
    }
}
