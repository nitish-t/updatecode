/*************************  *************************/
//
//  UIImageViewEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView{
    func sd_setImage_(urlString:String,placeholderImage:UIImage? = UIImage(named: KDefaultImageName)){
        self.setIndicatorStyle(.gray)
        self.setShowActivityIndicator(true)
        self.sd_setImage(with: URL(string: urlString ), placeholderImage: placeholderImage, options: .refreshCached)
    }
    @IBInspectable var imageTintColor: UIColor? {
        get {
            return self.tintColor
        }
        set {
            let image = self.image?.withRenderingMode(newValue == nil ? .alwaysOriginal : .alwaysTemplate)
            self.image = image
            self.tintColor = newValue
        }
    }
    @IBInspectable
    var localizedImg: String? {
        get {
            return UserDefaults.standard.value(forKey: "localizedImg IMG-\(self.hash)") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey:"localizedImg IMG-\(self.hash)")
            UserDefaults.standard.synchronize()
            self.image = UIImage(named: newValue?.localize_ ?? "")
        }
    }

}
