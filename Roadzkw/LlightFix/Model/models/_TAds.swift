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
public enum TAdsAttributes: String {
   case i_order
   case pk_i_id
   case s_image
}



// swiftlint:disable type_name
public class _TAds: NSManagedObject {
   public class var entityName: String {
      return "TAds"
   }

   @objc @NSManaged public var i_order: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_image: String?


   static let rKmapping : RKEntityMapping = {
        var TAdsMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TAds.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TAdsMapping?.addAttributeMappings(from: [
                "order_number":"i_order",
                "id":"pk_i_id",
                "image":"s_image",
            ])
        TAdsMapping?.identificationAttributes = ["pk_i_id"]
        return TAdsMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TAds: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_order\" : \(i_order?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TAds?{
        let obj = TAds.mr_createEntity()
        obj?.i_order = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_image = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TAds]{
        var arr = [TAds]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TAds.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TAdsObject: NSObject {
   public class var entityName: String {
      return "TAdsObject"
   }

   @objc public var i_order: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_image: String?


   static let rKmapping : RKObjectMapping = {
        var TAdsObjectMapping = RKObjectMapping(for: TAdsObject.classForCoder())
        TAdsObjectMapping?.addAttributeMappings(from: [
                "order_number":"i_order",
                "id":"pk_i_id",
                "image":"s_image",
            ])
        return TAdsObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TAdsObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_order\" : \(i_order?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TAdsObject{
        let obj = TAdsObject()
        obj.i_order = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_image = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TAdsObject]{
        var arr = [TAdsObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TAdsObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TAdsObject: NSObject,NSCoding,NSCopying {
   @objc public var i_order: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_image: String?


   init(fromDictionary dictionary: [String:Any]){
        i_order = dictionary["order_number"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_image = dictionary["image"] as? String

    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["order_number"] = i_order
        dictionary["id"] = pk_i_id
        dictionary["image"] = s_image


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        i_order = aDecoder.decodeObject(forKey:"order_number") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_image = aDecoder.decodeObject(forKey:"image") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if i_order != nil{
            aCoder.encode(i_order, forKey: "order_number")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_image != nil{
            aCoder.encode(s_image, forKey: "image")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TAdsObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TAdsObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_order\" : \(i_order?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TAdsObject{
        let obj = TAdsObject(fromDictionary: ["":""])
        obj.i_order = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_image = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TAdsObject]{
        var arr = [TAdsObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TAdsObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/