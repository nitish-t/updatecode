/*************************  *************************/
//
//  NSNumberEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit

extension NSNumber{
    var formatedNumber: String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 3
        fmt.decimalSeparator = "."
        fmt.groupingSeparator = ","
        return (fmt.string(from: (self)) ?? "0.0").removeArabicNumbers
    }
    var formatedTwoNumber: String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 2
        fmt.decimalSeparator = "."
        fmt.groupingSeparator = ","
        return (fmt.string(from: (self)) ?? "0.0").removeArabicNumbers
    }
    var formatedZeroNumber: String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 0
        fmt.decimalSeparator = "."
        fmt.groupingSeparator = ","
        return (fmt.string(from: (self)) ?? "0.0").removeArabicNumbers
    }
}
