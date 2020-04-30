/*************************  *************************/
//
//  ArrayEX.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

extension Array {
    func indexOfObject(object : AnyObject) -> NSInteger {
        return (self as NSArray).index(of: object)
    }
    
    mutating func removeObject<T>(obj: T) where T : Equatable {
        self = self.filter({$0 as? T != obj})
    }
}
