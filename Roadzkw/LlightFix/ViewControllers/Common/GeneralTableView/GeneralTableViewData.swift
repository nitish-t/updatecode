/*************************  *************************/
//
//  GeneralTableViewData.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class GeneralTableViewData: NSObject {
    
    var rowHeight: NSNumber?
    var reuseIdentifier: String = ""
    var object: Any?
    init(reuseIdentifier: String, object: Any?, rowHeight:NSNumber?) {
        self.reuseIdentifier = reuseIdentifier
        self.object = object
        self.rowHeight = rowHeight
        super.init()
    }
}
