/*************************  *************************/
//
//  UITextFieldEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {
    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    //    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    //        if action == #selector(copy(_:)) ||
    //            action == #selector(paste(_:)) ||
    //            action == #selector(selectAll(_:)) ||
    //            action == #selector(cut(_:)) ||
    //            action == #selector(select(_:)) ||
    //            action == #selector(delete(_:))
    //        {
    //            return false
    //        }
    //        return super.canPerformAction(action, withSender: sender)
    //    }
    
    
    func shakeError(baseColor: UIColor = UIColor.red, numberOfShakes shakes: Float = 3, revert: Bool = true) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "shadowColor")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
    @IBInspectable var maxLength: Int {
        get {
            guard let l = maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    @IBInspectable
    var localized: String? {
        get {
            return self.placeholder
        }
        set {
            self.placeholder = newValue?.localize_
        }
    }
}

class AllowedCharsTextField: UITextField, UITextFieldDelegate {
    @IBInspectable var allowedChars: String = ""
    @IBInspectable var bannedChars: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
        autocorrectionType = .no
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.count > 0 else {
            return true
        }
        if allowedChars.count > 0 {
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return prospectiveText.containsOnlyCharactersIn(matchCharacters: allowedChars)
        }else if bannedChars.count > 0 {
            let currentText = textField.text ?? ""
            let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return prospectiveText.doesNotContainCharactersIn(matchCharacters: bannedChars)
        }else{
            return true
        }
    }
}


extension String{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    func containsOnlyCharactersIn(matchCharacters: String) -> Bool {
        let disallowedCharacterSet = NSCharacterSet(charactersIn: matchCharacters).inverted
        return self.rangeOfCharacter(from: disallowedCharacterSet) == nil
    }
    func doesNotContainCharactersIn(matchCharacters: String) -> Bool {
        let characterSet = NSCharacterSet(charactersIn: matchCharacters)
        return self.rangeOfCharacter(from: characterSet as CharacterSet) == nil
    }
}
