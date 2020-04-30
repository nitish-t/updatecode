/*************************  *************************/
//
//  UIKitHelper.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class customHeightNavigationBarPlusStatusBar: NSLayoutConstraint {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.constant = self.constantHeight
    }
    
    var constantHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.height + self.constant
    }
}

class customHeightBottomPlusSafeArea: NSLayoutConstraint {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.constant = self.constantHeight
    }
    
    var constantHeight: CGFloat {
        let heightStatusBar = (UIApplication.shared.keyWindow?.window?.safeAreaInsets.bottom ?? 0.0) + self.constant
        return heightStatusBar
    }
}

class customHeightStatusBar: NSLayoutConstraint {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.constant = self.constantHeight
    }
    
    var constantHeight: CGFloat {
        let heightStatusBar = UIApplication.shared.statusBarFrame.height
        return heightStatusBar
    }
}

class roundedImage: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2.0
    }
}

class roundedLabel: UILabel {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2.0
    }
}

class roundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2.0
    }
}

class roundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height / 2.0
    }
}

class customMaskUIView: UIView {
    
    enum RoundType: String {
        case lowerRightCorner = "lowerRightCorner"
        case lowerLeftCorner = "lowerLeftCorner"
        case lowerCorner = "lowerCorner"
        case topRightCorner = "topRightCorner"
        case topLeftCorner = "topLeftCorner"
        case topCorner = "topCorner"
        case allCournerWithoutTopRightCorner = "allCournerWithoutTopRightCorner"
        case allCournerWithoutTopLeftCorner = "allCournerWithoutTopLeftCorner"
        case allCournerWithoutBottomRightCorner = "allCournerWithoutBottomRightCorner"
        case allCournerWithoutBottomleftCorner = "allCournerWithoutBottomleftCorner"
        case topLeftCornerAndLowerRightCorner = "topLeftCornerAndLowerRightCorner"
        case topRightCornerAndLowerLeftCorner = "topRightCornerAndLowerLeftCorner"
        case topRightCornerAndlowerRightCorner = "topRightCornerAndlowerRightCorner"
        case topLeftCornerAndlowerLeftCorner = "topLeftCornerAndlowerLeftCorner"
        case none = "None"
    }
    
    var roundshapeType: RoundType = .none
    
    func roundCorners(radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            switch roundshapeType  {
            case .lowerRightCorner :
                self.layer.maskedCorners = [.layerMaxXMaxYCorner]
                break
            case .lowerLeftCorner :
                self.layer.maskedCorners = [.layerMinXMaxYCorner]
                break
            case .lowerCorner :
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                break
            case .topRightCorner :
                self.layer.maskedCorners = [.layerMaxXMinYCorner]
                break
            case .topLeftCorner :
                self.layer.maskedCorners = [.layerMinXMinYCorner]
                break
            case .topCorner :
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                break
            case .allCournerWithoutTopRightCorner:
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
                break
            case .allCournerWithoutTopLeftCorner:
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                break
            case .allCournerWithoutBottomRightCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
                break
            case .allCournerWithoutBottomleftCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topLeftCornerAndLowerRightCorner:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topRightCornerAndLowerLeftCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
                break
            case .topRightCornerAndlowerRightCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topLeftCornerAndlowerLeftCorner:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                break
            case .none:
                break
            }
        } else {
            switch roundshapeType  {
            case .lowerRightCorner :
                self.roundLowerVersion(corners: [.bottomRight], radius: radius)
                break
            case .lowerLeftCorner :
                self.roundLowerVersion(corners: [.bottomLeft], radius: radius)
                break
            case .lowerCorner :
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight], radius: radius)
                break
            case .topRightCorner :
                self.roundLowerVersion(corners: [.topRight], radius: radius)
                break
            case .topLeftCorner :
                self.roundLowerVersion(corners: [.topLeft], radius: radius)
                break
            case .topCorner :
                self.roundLowerVersion(corners: [.topRight, .topLeft], radius: radius)
                break
            case .allCournerWithoutTopRightCorner:
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight, .topLeft], radius: radius)
                break
            case .allCournerWithoutTopLeftCorner:
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight, .topRight], radius: radius)
                break
            case .allCournerWithoutBottomRightCorner:
                self.roundLowerVersion(corners: [.topRight, .topLeft, .bottomLeft], radius: radius)
                break
            case .allCournerWithoutBottomleftCorner:
                self.roundLowerVersion(corners: [.topRight, .topLeft, .bottomRight], radius: radius)
                break
            case .none:
                break
            case .topLeftCornerAndLowerRightCorner:
                self.roundLowerVersion(corners: [.topLeft, .bottomRight], radius: radius)
                break
            case .topRightCornerAndLowerLeftCorner:
                self.roundLowerVersion(corners: [.topRight, .bottomLeft], radius: radius)
                break
            case .topRightCornerAndlowerRightCorner:
                self.roundLowerVersion(corners: [.topRight, .bottomRight], radius: radius)
                break
            case .topLeftCornerAndlowerLeftCorner:
                self.roundLowerVersion(corners: [.topLeft, .bottomLeft], radius: radius)
                break
            }
        }
        self.clipsToBounds = true
    }
    
    func roundLowerVersion(corners: UIRectCorner, radius: CGFloat) {
        let bounds = self.bounds
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}


class customMaskUIButton: UIButton {
    
    enum RoundType: String {
        case lowerRightCorner = "lowerRightCorner"
        case lowerLeftCorner = "lowerLeftCorner"
        case lowerCorner = "lowerCorner"
        case topRightCorner = "topRightCorner"
        case topLeftCorner = "topLeftCorner"
        case topCorner = "topCorner"
        case allCournerWithoutTopRightCorner = "allCournerWithoutTopRightCorner"
        case allCournerWithoutTopLeftCorner = "allCournerWithoutTopLeftCorner"
        case allCournerWithoutBottomRightCorner = "allCournerWithoutBottomRightCorner"
        case allCournerWithoutBottomleftCorner = "allCournerWithoutBottomleftCorner"
        case topLeftCornerAndLowerRightCorner = "topLeftCornerAndLowerRightCorner"
        case topRightCornerAndLowerLeftCorner = "topRightCornerAndLowerLeftCorner"
        case topRightCornerAndlowerRightCorner = "topRightCornerAndlowerRightCorner"
        case topLeftCornerAndlowerLeftCorner = "topLeftCornerAndlowerLeftCorner"
        case none = "None"
    }
    
    var roundshapeType: RoundType = .none
    
    func roundCorners(radius: CGFloat) {
        if #available(iOS 11.0, *) {
            self.layer.cornerRadius = radius
            switch roundshapeType  {
            case .lowerRightCorner :
                self.layer.maskedCorners = [.layerMaxXMaxYCorner]
                break
            case .lowerLeftCorner :
                self.layer.maskedCorners = [.layerMinXMaxYCorner]
                break
            case .lowerCorner :
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                break
            case .topRightCorner :
                self.layer.maskedCorners = [.layerMaxXMinYCorner]
                break
            case .topLeftCorner :
                self.layer.maskedCorners = [.layerMinXMinYCorner]
                break
            case .topCorner :
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
                break
            case .allCournerWithoutTopRightCorner:
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
                break
            case .allCournerWithoutTopLeftCorner:
                self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner]
                break
            case .allCournerWithoutBottomRightCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner]
                break
            case .allCournerWithoutBottomleftCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topLeftCornerAndLowerRightCorner:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topRightCornerAndLowerLeftCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMaxYCorner]
                break
            case .topRightCornerAndlowerRightCorner:
                self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
                break
            case .topLeftCornerAndlowerLeftCorner:
                self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
                break
            case .none:
                break
            }
        } else {
            switch roundshapeType  {
            case .lowerRightCorner :
                self.roundLowerVersion(corners: [.bottomRight], radius: radius)
                break
            case .lowerLeftCorner :
                self.roundLowerVersion(corners: [.bottomLeft], radius: radius)
                break
            case .lowerCorner :
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight], radius: radius)
                break
            case .topRightCorner :
                self.roundLowerVersion(corners: [.topRight], radius: radius)
                break
            case .topLeftCorner :
                self.roundLowerVersion(corners: [.topLeft], radius: radius)
                break
            case .topCorner :
                self.roundLowerVersion(corners: [.topRight, .topLeft], radius: radius)
                break
            case .allCournerWithoutTopRightCorner:
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight, .topLeft], radius: radius)
                break
            case .allCournerWithoutTopLeftCorner:
                self.roundLowerVersion(corners: [.bottomLeft, .bottomRight, .topRight], radius: radius)
                break
            case .allCournerWithoutBottomRightCorner:
                self.roundLowerVersion(corners: [.topRight, .topLeft, .bottomLeft], radius: radius)
                break
            case .allCournerWithoutBottomleftCorner:
                self.roundLowerVersion(corners: [.topRight, .topLeft, .bottomRight], radius: radius)
                break
            case .none:
                break
            case .topLeftCornerAndLowerRightCorner:
                self.roundLowerVersion(corners: [.topLeft, .bottomRight], radius: radius)
                break
            case .topRightCornerAndLowerLeftCorner:
                self.roundLowerVersion(corners: [.topRight, .bottomLeft], radius: radius)
                break
            case .topRightCornerAndlowerRightCorner:
                self.roundLowerVersion(corners: [.topRight, .bottomRight], radius: radius)
                break
            case .topLeftCornerAndlowerLeftCorner:
                self.roundLowerVersion(corners: [.topLeft, .bottomLeft], radius: radius)
                break
            }
        }
        self.clipsToBounds = true
    }
    
    func roundLowerVersion(corners: UIRectCorner, radius: CGFloat) {
        let bounds = self.bounds
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
