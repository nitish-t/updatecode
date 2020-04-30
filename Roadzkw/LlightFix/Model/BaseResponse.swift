/*************************  *************************/
//
//  BaseResponse.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import Foundation
import CoreData

#if canImport(Alamofire)
import Alamofire

@objc(BaseResponse)
public class BaseResponse: NSObject {
    
    public var pagination: Pagination?
    public var status: ResponceStatus?
    
    public var sliderArray = [TSliderObject]()
    public var adsArray = [TAdsObject]()
    public var carMakersArray = [TCarMakerObject]()
    public var settingsObject : TSettingObject?

    var userObject : TUserObject?
    
    var notificationsArray  = [TNotificationsObject]()
    var subscriptionsArray  = [TSubscriptionObject]()

    var carsArray  = [TCarObject]()

    var packagesArray  = [TPackageObject]()
    var servicesArray  = [TServiceObject]()

    public var coponObject : TCoponObject?

    var paymentlink : String?
    var order_id : String?
    
    var subscriptionsObject : TSubscriptionObject?

    
    var package_id : NSNumber?
    
    var not_read_notification_count : NSNumber?
    var noty : String?
    
    var checkMobile : String?
    var checkEmail : String?

    init(_ json:NSDictionary) {
        super.init()
        
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString) // <-- here is ur string

        } catch let myJSONError {
            print(myJSONError)
        }
        
        
        if let arr = json.value(forKeyPath: "items.sliders") as? [[String:Any]]{
            for dic in arr{
                let value = TSliderObject(fromDictionary: dic)
                sliderArray.append(value)
            }
        }
        if let arr = json.value(forKeyPath: "items.ads") as? [[String:Any]]{
            for dic in arr{
                let value = TAdsObject(fromDictionary: dic)
                adsArray.append(value)
            }
        }
        if let arr = json.value(forKeyPath: "items.car_makers") as? [[String:Any]]{
            for dic in arr{
                let value = TCarMakerObject(fromDictionary: dic)
                carMakersArray.append(value)
            }
        }
        if let arr = json.value(forKeyPath: "items") as? [[String:Any]]{
            for dic in arr{
                let value = TNotificationsObject(fromDictionary: dic)
                notificationsArray.append(value)
            }
        }
        if let arr = json.value(forKeyPath: "items") as? [[String:Any]]{
            for dic in arr{
                let value = TSubscriptionObject(fromDictionary: dic)
                subscriptionsArray.append(value)
            }
        }
        if let arr = json.value(forKeyPath: "items") as? [[String:Any]]{
            for dic in arr{
                let value = TCarObject(fromDictionary: dic)
                print(value)
                carsArray.append(value)
            }
        }
        if let arr = json.value(forKeyPath: "items") as? [[String:Any]]{
            for dic in arr{
                let value = TPackageObject(fromDictionary: dic)
                packagesArray.append(value)
            }
        }
        if let arr = json.value(forKeyPath: "items") as? [[String:Any]]{
            for dic in arr{
                let value = TServiceObject(fromDictionary: dic)
                servicesArray.append(value)
            }
        }
        
        
        if let dic = json.value(forKeyPath: "items") as? [String : Any]{
            coponObject = TCoponObject(fromDictionary: dic)
        }
        if let dic = json.value(forKeyPath: "items.setting") as? [String : Any]{
            settingsObject = TSettingObject(fromDictionary: dic)
        }
        if let dic = json.value(forKeyPath: "items") as? [String : Any]{
            userObject = TUserObject(fromDictionary: dic)
        }        
        if let dic = json as? [String : Any]{
            status = ResponceStatus(fromDictionary: dic)
        }
        if let dic = json.value(forKeyPath: "pagination") as? [String : Any]{
            pagination = Pagination(fromDictionary: dic)
        }
        if let dic = json.value(forKeyPath: "items.subscription") as? [String : Any]{
            subscriptionsObject = TSubscriptionObject(fromDictionary: dic)
        }
        
        if let dic = json.value(forKeyPath: "items.link") as? String{
            paymentlink = dic
        }
        if let dic = json.value(forKeyPath: "items.order_id") as? String{
            order_id = dic
        }
        if let dic = json.value(forKeyPath: "items.package_id") as? NSNumber{
            package_id = dic
        }
        if let dic = json.value(forKeyPath: "items.not_read_notification_count") as? NSNumber{
            not_read_notification_count = dic
        }
        
        if let dic = json.value(forKeyPath: "error.mobile") as? String{
            checkMobile = dic
        }
        if let dic = json.value(forKeyPath: "error.email") as? String{
            checkEmail = dic
        }
        
        if let dic = json.value(forKeyPath: "items.noty") as? String {
            noty = dic
        }
        
        
    }
}

public class ResponceStatus: NSObject
{
    public var success: NSNumber?
    public var codeNumber: NSNumber?
    public var message: String?
    
    init(fromDictionary dictionary: [String:Any]){
        success    = dictionary["status"] as? NSNumber
        codeNumber = dictionary["code"] as? NSNumber
        message    = dictionary["message"] as? String
    }
}

public class Pagination: NSObject
{
    public var i_per_page: NSNumber?
    public var i_total_pages: NSNumber?
    public var i_total_objects: NSNumber?
    public var i_current_page: NSNumber?
    public var i_items_on_page: NSNumber?
    
    init(fromDictionary dictionary: [String:Any]){
        i_per_page      = dictionary["i_per_page"] as? NSNumber
        i_total_pages   = dictionary["i_total_pages"] as? NSNumber
        i_total_objects = dictionary["i_total_objects"] as? NSNumber
        i_current_page  = dictionary["i_current_page"] as? NSNumber
        i_items_on_page = dictionary["i_items_on_page"] as? NSNumber
    }
}



#elseif canImport(RestKit)
import RestKit

@objcMembers
public class BaseResponse: NSObject {
    public var pagination:Pagination?
    public var status: ResponceStatus?
    
    public var userID: NSNumber?
    
    
    public static func prepareMapping() -> RKObjectMapping{
        let BaseREsponseMapping = RKObjectMapping(for: BaseResponse.classForCoder())
        BaseREsponseMapping?.addAttributeMappings(from: [
            "data.UserId": "userID",
            ])
        
        BaseREsponseMapping?.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "status", toKeyPath: "status", with: ResponceStatus.initMapping()))
        BaseREsponseMapping?.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "pagination", toKeyPath: "pagination", with: Pagination.initMapping()))
        
        
        return BaseREsponseMapping!;
        
    }
    
}

@objcMembers
public class ResponceStatus: NSObject
{
    public var success: NSNumber?
    public var codeNumber: NSNumber?
    public var message: String?
    
    public static func initMapping() -> RKObjectMapping {
        let StatusEsponseMapping = RKObjectMapping(for: ResponceStatus.classForCoder())
        StatusEsponseMapping?.addAttributeMappings(from: [
            "success": "success",
            "code": "codeNumber",
            "message": "message",
            ])
        return StatusEsponseMapping!
    }
}

@objcMembers
public class Pagination: NSObject
{
    public var i_per_page: NSNumber?
    public var i_total_pages: NSNumber?
    public var i_total_objects: NSNumber?
    public var i_current_page: NSNumber?
    public var i_items_on_page: NSNumber?
    
    public static func initMapping() -> RKObjectMapping {
        let EPagination = RKObjectMapping(for: Pagination.classForCoder())
        EPagination?.addAttributeMappings(from: [
            "i_per_page": "i_per_page",
            "i_total_pages": "i_total_pages",
            "i_total_objects": "i_total_objects",
            "i_current_page": "i_current_page",
            "i_items_on_page": "i_items_on_page"
            ])
        return EPagination!
    }
}
#endif
