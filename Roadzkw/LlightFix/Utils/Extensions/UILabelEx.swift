/*************************  *************************/
//
//  UILabelEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var localized: String? {
        get {
            return self.text
        }
        set {
            self.text = newValue?.localize_
        }
    }

}
