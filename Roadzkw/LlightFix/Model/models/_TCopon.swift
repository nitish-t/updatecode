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
public enum TCoponAttributes: String {
   case i_discount_percentage
   case pk_i_id
   case s_coupon
   case s_end_date
   case s_start_date
}



// swiftlint:disable type_name
public class _TCopon: NSManagedObject {
   public class var entityName: String {
      return "TCopon"
   }

   @objc @NSManaged public var i_discount_percentage: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_coupon: String?
   @objc @NSManaged public var s_end_date: String?
   @objc @NSManaged public var s_start_date: String?


   static let rKmapping : RKEntityMapping = {
        var TCoponMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TCopon.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TCoponMapping?.addAttributeMappings(from: [
                "discount_percentage":"i_discount_percentage",
                "id":"pk_i_id",
                "coupon":"s_coupon",
                "end_date":"s_end_date",
                "start_date":"s_start_date",
            ])
        TCoponMapping?.identificationAttributes = ["pk_i_id"]
        return TCoponMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TCopon: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_discount_percentage\" : \(i_discount_percentage?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_coupon\" : \(s_coupon != nil ? "\"\(s_coupon?.description ?? "nil")\"" : "\(s_coupon?.description ?? "nil")");"
        description += "\n    \"s_end_date\" : \(s_end_date != nil ? "\"\(s_end_date?.description ?? "nil")\"" : "\(s_end_date?.description ?? "nil")");"
        description += "\n    \"s_start_date\" : \(s_start_date != nil ? "\"\(s_start_date?.description ?? "nil")\"" : "\(s_start_date?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCopon?{
        let obj = TCopon.mr_createEntity()
        obj?.i_discount_percentage = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_coupon = Randoms.randomFakeName()
        obj?.s_end_date = Randoms.randomFakeName()
        obj?.s_start_date = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCopon]{
        var arr = [TCopon]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TCopon.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TCoponObject: NSObject {
   public class var entityName: String {
      return "TCoponObject"
   }

   @objc public var i_discount_percentage: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_coupon: String?
   @objc public var s_end_date: String?
   @objc public var s_start_date: String?


   static let rKmapping : RKObjectMapping = {
        var TCoponObjectMapping = RKObjectMapping(for: TCoponObject.classForCoder())
        TCoponObjectMapping?.addAttributeMappings(from: [
                "discount_percentage":"i_discount_percentage",
                "id":"pk_i_id",
                "coupon":"s_coupon",
                "end_date":"s_end_date",
                "start_date":"s_start_date",
            ])
        return TCoponObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TCoponObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_discount_percentage\" : \(i_discount_percentage?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_coupon\" : \(s_coupon != nil ? "\"\(s_coupon?.description ?? "nil")\"" : "\(s_coupon?.description ?? "nil")");"
        description += "\n    \"s_end_date\" : \(s_end_date != nil ? "\"\(s_end_date?.description ?? "nil")\"" : "\(s_end_date?.description ?? "nil")");"
        description += "\n    \"s_start_date\" : \(s_start_date != nil ? "\"\(s_start_date?.description ?? "nil")\"" : "\(s_start_date?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCoponObject{
        let obj = TCoponObject()
        obj.i_discount_percentage = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_coupon = Randoms.randomFakeName()
        obj.s_end_date = Randoms.randomFakeName()
        obj.s_start_date = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCoponObject]{
        var arr = [TCoponObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCoponObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TCoponObject: NSObject,NSCoding,NSCopying {
   @objc public var i_discount_percentage: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_coupon: String?
   @objc public var s_end_date: String?
   @objc public var s_start_date: String?


   init(fromDictionary dictionary: [String:Any]){
    
    let numString = dictionary["discount_percentage"] as? String
    
        i_discount_percentage = numString?.numberValue
        pk_i_id = dictionary["id"] as? NSNumber
        s_coupon = dictionary["coupon"] as? String
        s_end_date = dictionary["end_date"] as? String
        s_start_date = dictionary["start_date"] as? String

    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()
        dictionary["discount_percentage"] = i_discount_percentage
        dictionary["id"] = pk_i_id
        dictionary["coupon"] = s_coupon
        dictionary["end_date"] = s_end_date
        dictionary["start_date"] = s_start_date


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        i_discount_percentage = aDecoder.decodeObject(forKey:"discount_percentage") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_coupon = aDecoder.decodeObject(forKey:"coupon") as? String
        s_end_date = aDecoder.decodeObject(forKey:"end_date") as? String
        s_start_date = aDecoder.decodeObject(forKey:"start_date") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if i_discount_percentage != nil{
            aCoder.encode(i_discount_percentage, forKey: "discount_percentage")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_coupon != nil{
            aCoder.encode(s_coupon, forKey: "coupon")
        }
        if s_end_date != nil{
            aCoder.encode(s_end_date, forKey: "end_date")
        }
        if s_start_date != nil{
            aCoder.encode(s_start_date, forKey: "start_date")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TCoponObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TCoponObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_discount_percentage\" : \(i_discount_percentage?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_coupon\" : \(s_coupon != nil ? "\"\(s_coupon?.description ?? "nil")\"" : "\(s_coupon?.description ?? "nil")");"
        description += "\n    \"s_end_date\" : \(s_end_date != nil ? "\"\(s_end_date?.description ?? "nil")\"" : "\(s_end_date?.description ?? "nil")");"
        description += "\n    \"s_start_date\" : \(s_start_date != nil ? "\"\(s_start_date?.description ?? "nil")\"" : "\(s_start_date?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCoponObject{
        let obj = TCoponObject(fromDictionary: ["":""])
        obj.i_discount_percentage = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_coupon = Randoms.randomFakeName()
        obj.s_end_date = Randoms.randomFakeName()
        obj.s_start_date = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCoponObject]{
        var arr = [TCoponObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCoponObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/
