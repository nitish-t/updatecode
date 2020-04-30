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
public enum TUserAttributes: String {
   case b_email_verified
   case pk_i_id
   case s_access_token
   case s_device_type
   case s_email
   case s_full_name
   case s_image
   case s_mobile
}



// swiftlint:disable type_name
public class _TUser: NSManagedObject {
   public class var entityName: String {
      return "TUser"
   }

   @objc @NSManaged public var b_email_verified: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_access_token: String?
   @objc @NSManaged public var s_device_type: String?
   @objc @NSManaged public var s_email: String?
   @objc @NSManaged public var s_full_name: String?
   @objc @NSManaged public var s_image: String?
   @objc @NSManaged public var s_mobile: String?


   static let rKmapping : RKEntityMapping = {
        var TUserMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TUser.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TUserMapping?.addAttributeMappings(from: [
                "b_email_verified":"b_email_verified",
                "id":"pk_i_id",
                "access_token":"s_access_token",
                "device_type":"s_device_type",
                "email":"s_email",
                "full_name":"s_full_name",
                "profile_image":"s_image",
                "mobile":"s_mobile",
            ])
        TUserMapping?.identificationAttributes = ["pk_i_id"]
        return TUserMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TUser: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_email_verified\" : \(b_email_verified?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_access_token\" : \(s_access_token != nil ? "\"\(s_access_token?.description ?? "nil")\"" : "\(s_access_token?.description ?? "nil")");"
        description += "\n    \"s_device_type\" : \(s_device_type != nil ? "\"\(s_device_type?.description ?? "nil")\"" : "\(s_device_type?.description ?? "nil")");"
        description += "\n    \"s_email\" : \(s_email != nil ? "\"\(s_email?.description ?? "nil")\"" : "\(s_email?.description ?? "nil")");"
        description += "\n    \"s_full_name\" : \(s_full_name != nil ? "\"\(s_full_name?.description ?? "nil")\"" : "\(s_full_name?.description ?? "nil")");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n    \"s_mobile\" : \(s_mobile != nil ? "\"\(s_mobile?.description ?? "nil")\"" : "\(s_mobile?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TUser?{
        let obj = TUser.mr_createEntity()
        obj?.b_email_verified = NSNumber(value: Randoms.randomBool())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_access_token = Randoms.randomFakeName()
        obj?.s_device_type = Randoms.randomFakeName()
        obj?.s_email = Randoms.randomFakeName()
        obj?.s_full_name = Randoms.randomFakeName()
        obj?.s_image = Randoms.randomFakeName()
        obj?.s_mobile = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TUser]{
        var arr = [TUser]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TUser.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TUserObject: NSObject {
   public class var entityName: String {
      return "TUserObject"
   }

   @objc public var b_email_verified: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_access_token: String?
   @objc public var s_device_type: String?
   @objc public var s_email: String?
   @objc public var s_full_name: String?
   @objc public var s_image: String?
   @objc public var s_mobile: String?


   static let rKmapping : RKObjectMapping = {
        var TUserObjectMapping = RKObjectMapping(for: TUserObject.classForCoder())
        TUserObjectMapping?.addAttributeMappings(from: [
                "b_email_verified":"b_email_verified",
                "id":"pk_i_id",
                "access_token":"s_access_token",
                "device_type":"s_device_type",
                "email":"s_email",
                "full_name":"s_full_name",
                "profile_image":"s_image",
                "mobile":"s_mobile",
            ])
        return TUserObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TUserObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_email_verified\" : \(b_email_verified?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_access_token\" : \(s_access_token != nil ? "\"\(s_access_token?.description ?? "nil")\"" : "\(s_access_token?.description ?? "nil")");"
        description += "\n    \"s_device_type\" : \(s_device_type != nil ? "\"\(s_device_type?.description ?? "nil")\"" : "\(s_device_type?.description ?? "nil")");"
        description += "\n    \"s_email\" : \(s_email != nil ? "\"\(s_email?.description ?? "nil")\"" : "\(s_email?.description ?? "nil")");"
        description += "\n    \"s_full_name\" : \(s_full_name != nil ? "\"\(s_full_name?.description ?? "nil")\"" : "\(s_full_name?.description ?? "nil")");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n    \"s_mobile\" : \(s_mobile != nil ? "\"\(s_mobile?.description ?? "nil")\"" : "\(s_mobile?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TUserObject{
        let obj = TUserObject()
        obj.b_email_verified = NSNumber(value: Randoms.randomBool())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_access_token = Randoms.randomFakeName()
        obj.s_device_type = Randoms.randomFakeName()
        obj.s_email = Randoms.randomFakeName()
        obj.s_full_name = Randoms.randomFakeName()
        obj.s_image = Randoms.randomFakeName()
        obj.s_mobile = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TUserObject]{
        var arr = [TUserObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TUserObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TUserObject: NSObject,NSCoding,NSCopying {
   @objc public var b_email_verified: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_access_token: String?
   @objc public var s_device_type: String?
   @objc public var s_email: String?
   @objc public var s_full_name: String?
   @objc public var s_image: String?
   @objc public var s_mobile: String?


   init(fromDictionary dictionary: [String:Any]){
        b_email_verified = dictionary["b_email_verified"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_access_token = dictionary["access_token"] as? String
        s_device_type = dictionary["device_type"] as? String
        s_email = dictionary["email"] as? String
        s_full_name = dictionary["full_name"] as? String
        s_image = dictionary["profile_image"] as? String
        s_mobile = dictionary["mobile"] as? String
    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["b_email_verified"] = b_email_verified
        dictionary["id"] = pk_i_id
        dictionary["access_token"] = s_access_token
        dictionary["device_type"] = s_device_type
        dictionary["email"] = s_email
        dictionary["full_name"] = s_full_name
        dictionary["profile_image"] = s_image
        dictionary["mobile"] = s_mobile


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        b_email_verified = aDecoder.decodeObject(forKey:"b_email_verified") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_access_token = aDecoder.decodeObject(forKey:"access_token") as? String
        s_device_type = aDecoder.decodeObject(forKey:"device_type") as? String
        s_email = aDecoder.decodeObject(forKey:"email") as? String
        s_full_name = aDecoder.decodeObject(forKey:"full_name") as? String
        s_image = aDecoder.decodeObject(forKey:"profile_image") as? String
        s_mobile = aDecoder.decodeObject(forKey:"mobile") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if b_email_verified != nil{
            aCoder.encode(b_email_verified, forKey: "b_email_verified")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_access_token != nil{
            aCoder.encode(s_access_token, forKey: "access_token")
        }
        if s_device_type != nil{
            aCoder.encode(s_device_type, forKey: "device_type")
        }
        if s_email != nil{
            aCoder.encode(s_email, forKey: "email")
        }
        if s_full_name != nil{
            aCoder.encode(s_full_name, forKey: "full_name")
        }
        if s_image != nil{
            aCoder.encode(s_image, forKey: "profile_image")
        }
        if s_mobile != nil{
            aCoder.encode(s_mobile, forKey: "mobile")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TUserObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TUserObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_email_verified\" : \(b_email_verified?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_access_token\" : \(s_access_token != nil ? "\"\(s_access_token?.description ?? "nil")\"" : "\(s_access_token?.description ?? "nil")");"
        description += "\n    \"s_device_type\" : \(s_device_type != nil ? "\"\(s_device_type?.description ?? "nil")\"" : "\(s_device_type?.description ?? "nil")");"
        description += "\n    \"s_email\" : \(s_email != nil ? "\"\(s_email?.description ?? "nil")\"" : "\(s_email?.description ?? "nil")");"
        description += "\n    \"s_full_name\" : \(s_full_name != nil ? "\"\(s_full_name?.description ?? "nil")\"" : "\(s_full_name?.description ?? "nil")");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n    \"s_mobile\" : \(s_mobile != nil ? "\"\(s_mobile?.description ?? "nil")\"" : "\(s_mobile?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TUserObject{
        let obj = TUserObject(fromDictionary: ["":""])
        obj.b_email_verified = NSNumber(value: Randoms.randomBool())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_access_token = Randoms.randomFakeName()
        obj.s_device_type = Randoms.randomFakeName()
        obj.s_email = Randoms.randomFakeName()
        obj.s_full_name = Randoms.randomFakeName()
        obj.s_image = Randoms.randomFakeName()
        obj.s_mobile = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TUserObject]{
        var arr = [TUserObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TUserObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/
