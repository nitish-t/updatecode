/*************************  *************************/
//
//  GeneralCollectionViewData.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit

class GeneralCollectionViewData: NSObject {
    var reuseIdentifier: String = ""
    var object: Any?
    var cellSize: CGSize?
    init(reuseIdentifier: String, object: Any?) {
        self.reuseIdentifier = reuseIdentifier
        self.object = object
        super.init()
    }
    init(reuseIdentifier: String, object: Any?,cellSize:CGSize?) {
        self.reuseIdentifier = reuseIdentifier
        self.object = object
        self.cellSize = cellSize
        super.init()
    }
}
