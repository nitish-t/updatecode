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
public enum TCarYearAttributes: String {
   case i_car_model_id
   case pk_i_id
   case s_title
}



// swiftlint:disable type_name
public class _TCarYear: NSManagedObject {
   public class var entityName: String {
      return "TCarYear"
   }

   @objc @NSManaged public var i_car_model_id: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_title: String?


   static let rKmapping : RKEntityMapping = {
        var TCarYearMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TCarYear.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TCarYearMapping?.addAttributeMappings(from: [
                "car_model_id":"i_car_model_id",
                "id":"pk_i_id",
                "title":"s_title",
            ])
        TCarYearMapping?.identificationAttributes = ["pk_i_id"]
        return TCarYearMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TCarYear: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_car_model_id\" : \(i_car_model_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarYear?{
        let obj = TCarYear.mr_createEntity()
        obj?.i_car_model_id = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCarYear]{
        var arr = [TCarYear]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TCarYear.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TCarYearObject: NSObject {
   public class var entityName: String {
      return "TCarYearObject"
   }

   @objc public var i_car_model_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_title: String?


   static let rKmapping : RKObjectMapping = {
        var TCarYearObjectMapping = RKObjectMapping(for: TCarYearObject.classForCoder())
        TCarYearObjectMapping?.addAttributeMappings(from: [
                "car_model_id":"i_car_model_id",
                "id":"pk_i_id",
                "title":"s_title",
            ])
        return TCarYearObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TCarYearObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_car_model_id\" : \(i_car_model_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarYearObject{
        let obj = TCarYearObject()
        obj.i_car_model_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCarYearObject]{
        var arr = [TCarYearObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarYearObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TCarYearObject: NSObject,NSCoding,NSCopying {
   @objc public var i_car_model_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_title: String?


   init(fromDictionary dictionary: [String:Any]){
        i_car_model_id = dictionary["car_model_id"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_title = dictionary["title"] as? String

    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["car_model_id"] = i_car_model_id
        dictionary["id"] = pk_i_id
        dictionary["title"] = s_title


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        i_car_model_id = aDecoder.decodeObject(forKey:"car_model_id") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_title = aDecoder.decodeObject(forKey:"title") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if i_car_model_id != nil{
            aCoder.encode(i_car_model_id, forKey: "car_model_id")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_title != nil{
            aCoder.encode(s_title, forKey: "title")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TCarYearObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TCarYearObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_car_model_id\" : \(i_car_model_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarYearObject{
        let obj = TCarYearObject(fromDictionary: ["":""])
        obj.i_car_model_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCarYearObject]{
        var arr = [TCarYearObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarYearObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/