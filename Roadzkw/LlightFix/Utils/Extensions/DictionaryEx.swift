/*************************  *************************/
//
//  DictionaryEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit

extension Dictionary where Value: Equatable {
    func KeyForValue(_ val: Value) -> Key? {
        return first(where: { $1 == val })?.0
    }
}
