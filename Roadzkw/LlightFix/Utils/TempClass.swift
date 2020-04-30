//
//  TempClass.swift
//  LlightFix
//
//  Created by  on 6/27/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class TempClass: NSObject {
    static let sharedInstance = TempClass()
    
    var sliderArray: [TSliderObject]? {
        get {
            return (self.getValue("TempClass_sliderArray") as [TSliderObject]?) ?? nil
        }
        set {
            self.setValue("TempClass_sliderArray",newValue)
        }
    }
    var adsArray: [TAdsObject]? {
        get {
            return (self.getValue("TempClass_adsArray") as [TAdsObject]?) ?? nil
        }
        set {
            self.setValue("TempClass_adsArray",newValue)
        }
    }
    var carMakersArray: [TCarMakerObject]? {
        get {
            return (self.getValue("TempClass_carMakersArray") as [TCarMakerObject]?) ?? nil
        }
        set {
            self.setValue("TempClass_carMakersArray",newValue)
        }
    }
    var settingsObject: TSettingObject? {
        get {
            return (self.getValue("TempClass_settingsObject") as TSettingObject?) ?? nil
        }
        set {
            self.setValue("TempClass_settingsObject",newValue)
        }
    }
    
    var packageArray: [TPackageObject]? {
        get {
            return (self.getValue("TempClass_packageArray") as [TPackageObject]?) ?? nil
        }
        set {
            self.setValue("TempClass_packageArray",newValue)
        }
    }
}

extension NSObject {
    func getValue<T>(_ key:String) -> T? {
        let decoded  = (UserDefaults.standard.object(forKey: key) as? Data) ?? Data()
        return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? T
    }
    func setValue(_ key:String,_ value : Any?){
        if value != nil{
            let encodedData = NSKeyedArchiver.archivedData(withRootObject:value!)
            UserDefaults.standard.set(encodedData, forKey: key)
            UserDefaults.standard.synchronize()
        }else{
            UserDefaults.standard.set(nil, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}
