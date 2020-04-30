/*************************  *************************/
// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to machine.stencil instead.

#if canImport(SwiftRandom)
import SwiftRandom
#endif

#if canImport(RestKit)
import Foundation
import CoreData
import RestKit

// swiftlint:disable file_length
// swiftlint:disable type_body_length
public enum TSettingAttributes: String {
   case i_skip_ads_timer
   case pk_i_id
   case s_about_us
   case s_address
   case s_facebook
   case s_info_email
   case s_instagram
   case s_latitude
   case s_linkedin
   case s_logo
   case s_longitude
   case s_mobile
   case s_privacy
   case s_service_emergency
   case s_service_emergency_guest
   case s_service_maintenance
   case s_terms
   case s_title
   case s_twitter
   case s_youtube_emergency
   case s_youtube_maintenance
}



// swiftlint:disable type_name
public class _TSetting: NSManagedObject {
   public class var entityName: String {
      return "TSetting"
   }

   @objc @NSManaged public var i_skip_ads_timer: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_about_us: String?
   @objc @NSManaged public var s_address: String?
   @objc @NSManaged public var s_facebook: String?
   @objc @NSManaged public var s_info_email: String?
   @objc @NSManaged public var s_instagram: String?
   @objc @NSManaged public var s_latitude: String?
   @objc @NSManaged public var s_linkedin: String?
   @objc @NSManaged public var s_logo: String?
   @objc @NSManaged public var s_longitude: String?
   @objc @NSManaged public var s_mobile: String?
   @objc @NSManaged public var s_privacy: String?
   @objc @NSManaged public var s_service_emergency: String?
   @objc @NSManaged public var s_service_emergency_guest: String?
   @objc @NSManaged public var s_service_maintenance: String?
   @objc @NSManaged public var s_terms: String?
   @objc @NSManaged public var s_title: String?
   @objc @NSManaged public var s_twitter: String?
   @objc @NSManaged public var s_youtube_emergency: String?
   @objc @NSManaged public var s_youtube_maintenance: String?


   static let rKmapping : RKEntityMapping = {
        var TSettingMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TSetting.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TSettingMapping?.addAttributeMappings(from: [
                "skip_ads_timer":"i_skip_ads_timer",
                "id":"pk_i_id",
                "about_us":"s_about_us",
                "address":"s_address",
                "facebook":"s_facebook",
                "info_email":"s_info_email",
                "instagram":"s_instagram",
                "latitude":"s_latitude",
                "linkedin":"s_linkedin",
                "logo":"s_logo",
                "longitude":"s_longitude",
                "mobile":"s_mobile",
                "privacy":"s_privacy",
                "service_emergency":"s_service_emergency",
                "service_emergency_guest":"s_service_emergency_guest",
                "service_maintenance":"s_service_maintenance",
                "terms":"s_terms",
                "title":"s_title",
                "twitter":"s_twitter",
                "youtube_emergency":"s_youtube_emergency",
                "youtube_maintenance":"s_youtube_maintenance",
            ])
        TSettingMapping?.identificationAttributes = ["pk_i_id"]
        return TSettingMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TSetting: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_skip_ads_timer\" : \(i_skip_ads_timer?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_about_us\" : \(s_about_us != nil ? "\"\(s_about_us?.description ?? "nil")\"" : "\(s_about_us?.description ?? "nil")");"
        description += "\n    \"s_address\" : \(s_address != nil ? "\"\(s_address?.description ?? "nil")\"" : "\(s_address?.description ?? "nil")");"
        description += "\n    \"s_facebook\" : \(s_facebook != nil ? "\"\(s_facebook?.description ?? "nil")\"" : "\(s_facebook?.description ?? "nil")");"
        description += "\n    \"s_info_email\" : \(s_info_email != nil ? "\"\(s_info_email?.description ?? "nil")\"" : "\(s_info_email?.description ?? "nil")");"
        description += "\n    \"s_instagram\" : \(s_instagram != nil ? "\"\(s_instagram?.description ?? "nil")\"" : "\(s_instagram?.description ?? "nil")");"
        description += "\n    \"s_latitude\" : \(s_latitude != nil ? "\"\(s_latitude?.description ?? "nil")\"" : "\(s_latitude?.description ?? "nil")");"
        description += "\n    \"s_linkedin\" : \(s_linkedin != nil ? "\"\(s_linkedin?.description ?? "nil")\"" : "\(s_linkedin?.description ?? "nil")");"
        description += "\n    \"s_logo\" : \(s_logo != nil ? "\"\(s_logo?.description ?? "nil")\"" : "\(s_logo?.description ?? "nil")");"
        description += "\n    \"s_longitude\" : \(s_longitude != nil ? "\"\(s_longitude?.description ?? "nil")\"" : "\(s_longitude?.description ?? "nil")");"
        description += "\n    \"s_mobile\" : \(s_mobile != nil ? "\"\(s_mobile?.description ?? "nil")\"" : "\(s_mobile?.description ?? "nil")");"
        description += "\n    \"s_privacy\" : \(s_privacy != nil ? "\"\(s_privacy?.description ?? "nil")\"" : "\(s_privacy?.description ?? "nil")");"
        description += "\n    \"s_service_emergency\" : \(s_service_emergency != nil ? "\"\(s_service_emergency?.description ?? "nil")\"" : "\(s_service_emergency?.description ?? "nil")");"
        description += "\n    \"s_service_emergency_guest\" : \(s_service_emergency_guest != nil ? "\"\(s_service_emergency_guest?.description ?? "nil")\"" : "\(s_service_emergency_guest?.description ?? "nil")");"
        description += "\n    \"s_service_maintenance\" : \(s_service_maintenance != nil ? "\"\(s_service_maintenance?.description ?? "nil")\"" : "\(s_service_maintenance?.description ?? "nil")");"
        description += "\n    \"s_terms\" : \(s_terms != nil ? "\"\(s_terms?.description ?? "nil")\"" : "\(s_terms?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    \"s_twitter\" : \(s_twitter != nil ? "\"\(s_twitter?.description ?? "nil")\"" : "\(s_twitter?.description ?? "nil")");"
        description += "\n    \"s_youtube_emergency\" : \(s_youtube_emergency != nil ? "\"\(s_youtube_emergency?.description ?? "nil")\"" : "\(s_youtube_emergency?.description ?? "nil")");"
        description += "\n    \"s_youtube_maintenance\" : \(s_youtube_maintenance != nil ? "\"\(s_youtube_maintenance?.description ?? "nil")\"" : "\(s_youtube_maintenance?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSetting?{
        let obj = TSetting.mr_createEntity()
        obj?.i_skip_ads_timer = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_about_us = Randoms.randomFakeName()
        obj?.s_address = Randoms.randomFakeName()
        obj?.s_facebook = Randoms.randomFakeName()
        obj?.s_info_email = Randoms.randomFakeName()
        obj?.s_instagram = Randoms.randomFakeName()
        obj?.s_latitude = Randoms.randomFakeName()
        obj?.s_linkedin = Randoms.randomFakeName()
        obj?.s_logo = Randoms.randomFakeName()
        obj?.s_longitude = Randoms.randomFakeName()
        obj?.s_mobile = Randoms.randomFakeName()
        obj?.s_privacy = Randoms.randomFakeName()
        obj?.s_service_emergency = Randoms.randomFakeName()
        obj?.s_service_emergency_guest = Randoms.randomFakeName()
        obj?.s_service_maintenance = Randoms.randomFakeName()
        obj?.s_terms = Randoms.randomFakeName()
        obj?.s_title = Randoms.randomFakeName()
        obj?.s_twitter = Randoms.randomFakeName()
        obj?.s_youtube_emergency = Randoms.randomFakeName()
        obj?.s_youtube_maintenance = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TSetting]{
        var arr = [TSetting]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TSetting.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TSettingObject: NSObject {
   public class var entityName: String {
      return "TSettingObject"
   }

   @objc public var i_skip_ads_timer: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_about_us: String?
   @objc public var s_address: String?
   @objc public var s_facebook: String?
   @objc public var s_info_email: String?
   @objc public var s_instagram: String?
   @objc public var s_latitude: String?
   @objc public var s_linkedin: String?
   @objc public var s_logo: String?
   @objc public var s_longitude: String?
   @objc public var s_mobile: String?
   @objc public var s_privacy: String?
   @objc public var s_service_emergency: String?
   @objc public var s_service_emergency_guest: String?
   @objc public var s_service_maintenance: String?
   @objc public var s_terms: String?
   @objc public var s_title: String?
   @objc public var s_twitter: String?
   @objc public var s_youtube_emergency: String?
   @objc public var s_youtube_maintenance: String?


   static let rKmapping : RKObjectMapping = {
        var TSettingObjectMapping = RKObjectMapping(for: TSettingObject.classForCoder())
        TSettingObjectMapping?.addAttributeMappings(from: [
                "skip_ads_timer":"i_skip_ads_timer",
                "id":"pk_i_id",
                "about_us":"s_about_us",
                "address":"s_address",
                "facebook":"s_facebook",
                "info_email":"s_info_email",
                "instagram":"s_instagram",
                "latitude":"s_latitude",
                "linkedin":"s_linkedin",
                "logo":"s_logo",
                "longitude":"s_longitude",
                "mobile":"s_mobile",
                "privacy":"s_privacy",
                "service_emergency":"s_service_emergency",
                "service_emergency_guest":"s_service_emergency_guest",
                "service_maintenance":"s_service_maintenance",
                "terms":"s_terms",
                "title":"s_title",
                "twitter":"s_twitter",
                "youtube_emergency":"s_youtube_emergency",
                "youtube_maintenance":"s_youtube_maintenance",
            ])
        return TSettingObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TSettingObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_skip_ads_timer\" : \(i_skip_ads_timer?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_about_us\" : \(s_about_us != nil ? "\"\(s_about_us?.description ?? "nil")\"" : "\(s_about_us?.description ?? "nil")");"
        description += "\n    \"s_address\" : \(s_address != nil ? "\"\(s_address?.description ?? "nil")\"" : "\(s_address?.description ?? "nil")");"
        description += "\n    \"s_facebook\" : \(s_facebook != nil ? "\"\(s_facebook?.description ?? "nil")\"" : "\(s_facebook?.description ?? "nil")");"
        description += "\n    \"s_info_email\" : \(s_info_email != nil ? "\"\(s_info_email?.description ?? "nil")\"" : "\(s_info_email?.description ?? "nil")");"
        description += "\n    \"s_instagram\" : \(s_instagram != nil ? "\"\(s_instagram?.description ?? "nil")\"" : "\(s_instagram?.description ?? "nil")");"
        description += "\n    \"s_latitude\" : \(s_latitude != nil ? "\"\(s_latitude?.description ?? "nil")\"" : "\(s_latitude?.description ?? "nil")");"
        description += "\n    \"s_linkedin\" : \(s_linkedin != nil ? "\"\(s_linkedin?.description ?? "nil")\"" : "\(s_linkedin?.description ?? "nil")");"
        description += "\n    \"s_logo\" : \(s_logo != nil ? "\"\(s_logo?.description ?? "nil")\"" : "\(s_logo?.description ?? "nil")");"
        description += "\n    \"s_longitude\" : \(s_longitude != nil ? "\"\(s_longitude?.description ?? "nil")\"" : "\(s_longitude?.description ?? "nil")");"
        description += "\n    \"s_mobile\" : \(s_mobile != nil ? "\"\(s_mobile?.description ?? "nil")\"" : "\(s_mobile?.description ?? "nil")");"
        description += "\n    \"s_privacy\" : \(s_privacy != nil ? "\"\(s_privacy?.description ?? "nil")\"" : "\(s_privacy?.description ?? "nil")");"
        description += "\n    \"s_service_emergency\" : \(s_service_emergency != nil ? "\"\(s_service_emergency?.description ?? "nil")\"" : "\(s_service_emergency?.description ?? "nil")");"
        description += "\n    \"s_service_emergency_guest\" : \(s_service_emergency_guest != nil ? "\"\(s_service_emergency_guest?.description ?? "nil")\"" : "\(s_service_emergency_guest?.description ?? "nil")");"
        description += "\n    \"s_service_maintenance\" : \(s_service_maintenance != nil ? "\"\(s_service_maintenance?.description ?? "nil")\"" : "\(s_service_maintenance?.description ?? "nil")");"
        description += "\n    \"s_terms\" : \(s_terms != nil ? "\"\(s_terms?.description ?? "nil")\"" : "\(s_terms?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    \"s_twitter\" : \(s_twitter != nil ? "\"\(s_twitter?.description ?? "nil")\"" : "\(s_twitter?.description ?? "nil")");"
        description += "\n    \"s_youtube_emergency\" : \(s_youtube_emergency != nil ? "\"\(s_youtube_emergency?.description ?? "nil")\"" : "\(s_youtube_emergency?.description ?? "nil")");"
        description += "\n    \"s_youtube_maintenance\" : \(s_youtube_maintenance != nil ? "\"\(s_youtube_maintenance?.description ?? "nil")\"" : "\(s_youtube_maintenance?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSettingObject{
        let obj = TSettingObject()
        obj.i_skip_ads_timer = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_about_us = Randoms.randomFakeName()
        obj.s_address = Randoms.randomFakeName()
        obj.s_facebook = Randoms.randomFakeName()
        obj.s_info_email = Randoms.randomFakeName()
        obj.s_instagram = Randoms.randomFakeName()
        obj.s_latitude = Randoms.randomFakeName()
        obj.s_linkedin = Randoms.randomFakeName()
        obj.s_logo = Randoms.randomFakeName()
        obj.s_longitude = Randoms.randomFakeName()
        obj.s_mobile = Randoms.randomFakeName()
        obj.s_privacy = Randoms.randomFakeName()
        obj.s_service_emergency = Randoms.randomFakeName()
        obj.s_service_emergency_guest = Randoms.randomFakeName()
        obj.s_service_maintenance = Randoms.randomFakeName()
        obj.s_terms = Randoms.randomFakeName()
        obj.s_title = Randoms.randomFakeName()
        obj.s_twitter = Randoms.randomFakeName()
        obj.s_youtube_emergency = Randoms.randomFakeName()
        obj.s_youtube_maintenance = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TSettingObject]{
        var arr = [TSettingObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TSettingObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TSettingObject: NSObject,NSCoding,NSCopying {
   @objc public var i_skip_ads_timer: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_about_us: String?
   @objc public var s_address: String?
   @objc public var s_facebook: String?
   @objc public var s_info_email: String?
   @objc public var s_instagram: String?
   @objc public var s_latitude: String?
   @objc public var s_linkedin: String?
   @objc public var s_logo: String?
   @objc public var s_longitude: String?
   @objc public var s_mobile: String?
   @objc public var s_privacy: String?
   @objc public var s_service_emergency: String?
   @objc public var s_service_emergency_guest: String?
   @objc public var s_service_maintenance: String?
   @objc public var s_terms: String?
   @objc public var s_title: String?
   @objc public var s_twitter: String?
   @objc public var s_youtube_emergency: String?
   @objc public var s_youtube_maintenance: String?


   init(fromDictionary dictionary: [String:Any]){
        i_skip_ads_timer = dictionary["skip_ads_timer"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_about_us = dictionary["about_us"] as? String
        s_address = dictionary["address"] as? String
        s_facebook = dictionary["facebook"] as? String
        s_info_email = dictionary["info_email"] as? String
        s_instagram = dictionary["instagram"] as? String
        s_latitude = dictionary["latitude"] as? String
        s_linkedin = dictionary["linkedin"] as? String
        s_logo = dictionary["logo"] as? String
        s_longitude = dictionary["longitude"] as? String
        s_mobile = dictionary["mobile"] as? String
        s_privacy = dictionary["privacy"] as? String
        s_service_emergency = dictionary["service_emergency"] as? String
        s_service_emergency_guest = dictionary["service_emergency_guest"] as? String
        s_service_maintenance = dictionary["service_maintenance"] as? String
        s_terms = dictionary["terms"] as? String
        s_title = dictionary["title"] as? String
        s_twitter = dictionary["twitter"] as? String
        s_youtube_emergency = dictionary["youtube_emergency"] as? String
        s_youtube_maintenance = dictionary["youtube_maintenance"] as? String

    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["skip_ads_timer"] = i_skip_ads_timer
        dictionary["id"] = pk_i_id
        dictionary["about_us"] = s_about_us
        dictionary["address"] = s_address
        dictionary["facebook"] = s_facebook
        dictionary["info_email"] = s_info_email
        dictionary["instagram"] = s_instagram
        dictionary["latitude"] = s_latitude
        dictionary["linkedin"] = s_linkedin
        dictionary["logo"] = s_logo
        dictionary["longitude"] = s_longitude
        dictionary["mobile"] = s_mobile
        dictionary["privacy"] = s_privacy
        dictionary["service_emergency"] = s_service_emergency
        dictionary["service_emergency_guest"] = s_service_emergency_guest
        dictionary["service_maintenance"] = s_service_maintenance
        dictionary["terms"] = s_terms
        dictionary["title"] = s_title
        dictionary["twitter"] = s_twitter
        dictionary["youtube_emergency"] = s_youtube_emergency
        dictionary["youtube_maintenance"] = s_youtube_maintenance


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        i_skip_ads_timer = aDecoder.decodeObject(forKey:"skip_ads_timer") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_about_us = aDecoder.decodeObject(forKey:"about_us") as? String
        s_address = aDecoder.decodeObject(forKey:"address") as? String
        s_facebook = aDecoder.decodeObject(forKey:"facebook") as? String
        s_info_email = aDecoder.decodeObject(forKey:"info_email") as? String
        s_instagram = aDecoder.decodeObject(forKey:"instagram") as? String
        s_latitude = aDecoder.decodeObject(forKey:"latitude") as? String
        s_linkedin = aDecoder.decodeObject(forKey:"linkedin") as? String
        s_logo = aDecoder.decodeObject(forKey:"logo") as? String
        s_longitude = aDecoder.decodeObject(forKey:"longitude") as? String
        s_mobile = aDecoder.decodeObject(forKey:"mobile") as? String
        s_privacy = aDecoder.decodeObject(forKey:"privacy") as? String
        s_service_emergency = aDecoder.decodeObject(forKey:"service_emergency") as? String
        s_service_emergency_guest = aDecoder.decodeObject(forKey:"service_emergency_guest") as? String
        s_service_maintenance = aDecoder.decodeObject(forKey:"service_maintenance") as? String
        s_terms = aDecoder.decodeObject(forKey:"terms") as? String
        s_title = aDecoder.decodeObject(forKey:"title") as? String
        s_twitter = aDecoder.decodeObject(forKey:"twitter") as? String
        s_youtube_emergency = aDecoder.decodeObject(forKey:"youtube_emergency") as? String
        s_youtube_maintenance = aDecoder.decodeObject(forKey:"youtube_maintenance") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if i_skip_ads_timer != nil{
            aCoder.encode(i_skip_ads_timer, forKey: "skip_ads_timer")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_about_us != nil{
            aCoder.encode(s_about_us, forKey: "about_us")
        }
        if s_address != nil{
            aCoder.encode(s_address, forKey: "address")
        }
        if s_facebook != nil{
            aCoder.encode(s_facebook, forKey: "facebook")
        }
        if s_info_email != nil{
            aCoder.encode(s_info_email, forKey: "info_email")
        }
        if s_instagram != nil{
            aCoder.encode(s_instagram, forKey: "instagram")
        }
        if s_latitude != nil{
            aCoder.encode(s_latitude, forKey: "latitude")
        }
        if s_linkedin != nil{
            aCoder.encode(s_linkedin, forKey: "linkedin")
        }
        if s_logo != nil{
            aCoder.encode(s_logo, forKey: "logo")
        }
        if s_longitude != nil{
            aCoder.encode(s_longitude, forKey: "longitude")
        }
        if s_mobile != nil{
            aCoder.encode(s_mobile, forKey: "mobile")
        }
        if s_privacy != nil{
            aCoder.encode(s_privacy, forKey: "privacy")
        }
        if s_service_emergency != nil{
            aCoder.encode(s_service_emergency, forKey: "service_emergency")
        }
        if s_service_emergency_guest != nil{
            aCoder.encode(s_service_emergency_guest, forKey: "service_emergency_guest")
        }
        if s_service_maintenance != nil{
            aCoder.encode(s_service_maintenance, forKey: "service_maintenance")
        }
        if s_terms != nil{
            aCoder.encode(s_terms, forKey: "terms")
        }
        if s_title != nil{
            aCoder.encode(s_title, forKey: "title")
        }
        if s_twitter != nil{
            aCoder.encode(s_twitter, forKey: "twitter")
        }
        if s_youtube_emergency != nil{
            aCoder.encode(s_youtube_emergency, forKey: "youtube_emergency")
        }
        if s_youtube_maintenance != nil{
            aCoder.encode(s_youtube_maintenance, forKey: "youtube_maintenance")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TSettingObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TSettingObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_skip_ads_timer\" : \(i_skip_ads_timer?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_about_us\" : \(s_about_us != nil ? "\"\(s_about_us?.description ?? "nil")\"" : "\(s_about_us?.description ?? "nil")");"
        description += "\n    \"s_address\" : \(s_address != nil ? "\"\(s_address?.description ?? "nil")\"" : "\(s_address?.description ?? "nil")");"
        description += "\n    \"s_facebook\" : \(s_facebook != nil ? "\"\(s_facebook?.description ?? "nil")\"" : "\(s_facebook?.description ?? "nil")");"
        description += "\n    \"s_info_email\" : \(s_info_email != nil ? "\"\(s_info_email?.description ?? "nil")\"" : "\(s_info_email?.description ?? "nil")");"
        description += "\n    \"s_instagram\" : \(s_instagram != nil ? "\"\(s_instagram?.description ?? "nil")\"" : "\(s_instagram?.description ?? "nil")");"
        description += "\n    \"s_latitude\" : \(s_latitude != nil ? "\"\(s_latitude?.description ?? "nil")\"" : "\(s_latitude?.description ?? "nil")");"
        description += "\n    \"s_linkedin\" : \(s_linkedin != nil ? "\"\(s_linkedin?.description ?? "nil")\"" : "\(s_linkedin?.description ?? "nil")");"
        description += "\n    \"s_logo\" : \(s_logo != nil ? "\"\(s_logo?.description ?? "nil")\"" : "\(s_logo?.description ?? "nil")");"
        description += "\n    \"s_longitude\" : \(s_longitude != nil ? "\"\(s_longitude?.description ?? "nil")\"" : "\(s_longitude?.description ?? "nil")");"
        description += "\n    \"s_mobile\" : \(s_mobile != nil ? "\"\(s_mobile?.description ?? "nil")\"" : "\(s_mobile?.description ?? "nil")");"
        description += "\n    \"s_privacy\" : \(s_privacy != nil ? "\"\(s_privacy?.description ?? "nil")\"" : "\(s_privacy?.description ?? "nil")");"
        description += "\n    \"s_service_emergency\" : \(s_service_emergency != nil ? "\"\(s_service_emergency?.description ?? "nil")\"" : "\(s_service_emergency?.description ?? "nil")");"
        description += "\n    \"s_service_emergency_guest\" : \(s_service_emergency_guest != nil ? "\"\(s_service_emergency_guest?.description ?? "nil")\"" : "\(s_service_emergency_guest?.description ?? "nil")");"
        description += "\n    \"s_service_maintenance\" : \(s_service_maintenance != nil ? "\"\(s_service_maintenance?.description ?? "nil")\"" : "\(s_service_maintenance?.description ?? "nil")");"
        description += "\n    \"s_terms\" : \(s_terms != nil ? "\"\(s_terms?.description ?? "nil")\"" : "\(s_terms?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    \"s_twitter\" : \(s_twitter != nil ? "\"\(s_twitter?.description ?? "nil")\"" : "\(s_twitter?.description ?? "nil")");"
        description += "\n    \"s_youtube_emergency\" : \(s_youtube_emergency != nil ? "\"\(s_youtube_emergency?.description ?? "nil")\"" : "\(s_youtube_emergency?.description ?? "nil")");"
        description += "\n    \"s_youtube_maintenance\" : \(s_youtube_maintenance != nil ? "\"\(s_youtube_maintenance?.description ?? "nil")\"" : "\(s_youtube_maintenance?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSettingObject{
        let obj = TSettingObject(fromDictionary: ["":""])
        obj.i_skip_ads_timer = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_about_us = Randoms.randomFakeName()
        obj.s_address = Randoms.randomFakeName()
        obj.s_facebook = Randoms.randomFakeName()
        obj.s_info_email = Randoms.randomFakeName()
        obj.s_instagram = Randoms.randomFakeName()
        obj.s_latitude = Randoms.randomFakeName()
        obj.s_linkedin = Randoms.randomFakeName()
        obj.s_logo = Randoms.randomFakeName()
        obj.s_longitude = Randoms.randomFakeName()
        obj.s_mobile = Randoms.randomFakeName()
        obj.s_privacy = Randoms.randomFakeName()
        obj.s_service_emergency = Randoms.randomFakeName()
        obj.s_service_emergency_guest = Randoms.randomFakeName()
        obj.s_service_maintenance = Randoms.randomFakeName()
        obj.s_terms = Randoms.randomFakeName()
        obj.s_title = Randoms.randomFakeName()
        obj.s_twitter = Randoms.randomFakeName()
        obj.s_youtube_emergency = Randoms.randomFakeName()
        obj.s_youtube_maintenance = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TSettingObject]{
        var arr = [TSettingObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TSettingObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/