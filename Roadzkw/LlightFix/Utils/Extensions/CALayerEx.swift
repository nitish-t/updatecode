/*************************  *************************/
//
//  CALayerEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit

extension CALayer {
    var borderColor_: UIColor {
        get {
            return self.borderColor_
        }
        set {
            self.borderColor = newValue.cgColor
        }
    }
}
