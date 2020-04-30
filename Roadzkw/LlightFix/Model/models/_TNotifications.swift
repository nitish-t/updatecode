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
public enum TNotificationsAttributes: String {
   case b_read
   case pk_i_id
   case s_body
   case s_dt_created
   case s_title
}



// swiftlint:disable type_name
public class _TNotifications: NSManagedObject {
   public class var entityName: String {
      return "TNotification"
   }

   @objc @NSManaged public var b_read: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_body: String?
   @objc @NSManaged public var s_dt_created: String?
   @objc @NSManaged public var s_title: String?


   static let rKmapping : RKEntityMapping = {
        var TNotificationsMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TNotifications.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TNotificationsMapping?.addAttributeMappings(from: [
                "is_read":"b_read",
                "id":"pk_i_id",
                "body":"s_body",
                "created_at":"s_dt_created",
                "title":"s_title",
            ])
        TNotificationsMapping?.identificationAttributes = ["pk_i_id"]
        return TNotificationsMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TNotifications: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_read\" : \(b_read?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_body\" : \(s_body != nil ? "\"\(s_body?.description ?? "nil")\"" : "\(s_body?.description ?? "nil")");"
        description += "\n    \"s_dt_created\" : \(s_dt_created != nil ? "\"\(s_dt_created?.description ?? "nil")\"" : "\(s_dt_created?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TNotifications?{
        let obj = TNotifications.mr_createEntity()
        obj?.b_read = NSNumber(value: Randoms.randomBool())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_body = Randoms.randomFakeName()
        obj?.s_dt_created = Randoms.randomFakeName()
        obj?.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TNotifications]{
        var arr = [TNotifications]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TNotifications.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TNotificationsObject: NSObject {
   public class var entityName: String {
      return "TNotificationObject"
   }

   @objc public var b_read: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_body: String?
   @objc public var s_dt_created: String?
   @objc public var s_title: String?


   static let rKmapping : RKObjectMapping = {
        var TNotificationsObjectMapping = RKObjectMapping(for: TNotificationsObject.classForCoder())
        TNotificationsObjectMapping?.addAttributeMappings(from: [
                "is_read":"b_read",
                "id":"pk_i_id",
                "body":"s_body",
                "created_at":"s_dt_created",
                "title":"s_title",
            ])
        return TNotificationsObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TNotificationsObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_read\" : \(b_read?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_body\" : \(s_body != nil ? "\"\(s_body?.description ?? "nil")\"" : "\(s_body?.description ?? "nil")");"
        description += "\n    \"s_dt_created\" : \(s_dt_created != nil ? "\"\(s_dt_created?.description ?? "nil")\"" : "\(s_dt_created?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TNotificationsObject{
        let obj = TNotificationsObject()
        obj.b_read = NSNumber(value: Randoms.randomBool())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_body = Randoms.randomFakeName()
        obj.s_dt_created = Randoms.randomFakeName()
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TNotificationsObject]{
        var arr = [TNotificationsObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TNotificationsObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TNotificationsObject: NSObject,NSCoding,NSCopying {
   @objc public var b_read: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_body: String?
   @objc public var s_dt_created: String?
   @objc public var s_title: String?


   init(fromDictionary dictionary: [String:Any]){
        b_read = dictionary["is_read"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_body = dictionary["body"] as? String
        s_dt_created = dictionary["created_at"] as? String
        s_title = dictionary["title"] as? String

    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["is_read"] = b_read
        dictionary["id"] = pk_i_id
        dictionary["body"] = s_body
        dictionary["created_at"] = s_dt_created
        dictionary["title"] = s_title


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        b_read = aDecoder.decodeObject(forKey:"is_read") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_body = aDecoder.decodeObject(forKey:"body") as? String
        s_dt_created = aDecoder.decodeObject(forKey:"created_at") as? String
        s_title = aDecoder.decodeObject(forKey:"title") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if b_read != nil{
            aCoder.encode(b_read, forKey: "is_read")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_body != nil{
            aCoder.encode(s_body, forKey: "body")
        }
        if s_dt_created != nil{
            aCoder.encode(s_dt_created, forKey: "created_at")
        }
        if s_title != nil{
            aCoder.encode(s_title, forKey: "title")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TNotificationsObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TNotificationsObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_read\" : \(b_read?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_body\" : \(s_body != nil ? "\"\(s_body?.description ?? "nil")\"" : "\(s_body?.description ?? "nil")");"
        description += "\n    \"s_dt_created\" : \(s_dt_created != nil ? "\"\(s_dt_created?.description ?? "nil")\"" : "\(s_dt_created?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TNotificationsObject{
        let obj = TNotificationsObject(fromDictionary: ["":""])
        obj.b_read = NSNumber(value: Randoms.randomBool())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_body = Randoms.randomFakeName()
        obj.s_dt_created = Randoms.randomFakeName()
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TNotificationsObject]{
        var arr = [TNotificationsObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TNotificationsObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/