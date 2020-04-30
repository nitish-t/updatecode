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
public enum TCarModelAttributes: String {
   case i_car_maker_id
   case pk_i_id
   case s_title
}

public enum TCarModelRelationships: String {
   case years
}


// swiftlint:disable type_name
public class _TCarModel: NSManagedObject {
   public class var entityName: String {
      return "TCarModel"
   }

   @objc @NSManaged public var i_car_maker_id: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_title: String?

   @objc @NSManaged public var years: NSSet

   static let rKmapping : RKEntityMapping = {
        var TCarModelMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TCarModel.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TCarModelMapping?.addAttributeMappings(from: [
                "car_maker_id":"i_car_maker_id",
                "id":"pk_i_id",
                "title":"s_title",
            ])
        TCarModelMapping?.identificationAttributes = ["pk_i_id"]
        return TCarModelMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
                    TCarModel.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_years", toKeyPath: "years" , with: TCarYear.rKmapping))
    }

    public override var description: String{
        var description: String = "<TCarModel: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_car_maker_id\" : \(i_car_maker_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    years = [TCarYear].count = \(years.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarModel?{
        let obj = TCarModel.mr_createEntity()
        obj?.i_car_maker_id = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_title = Randoms.randomFakeName()
        //Reletions
        obj?.years = NSSet(array: TCarYear.demoArray())
        return obj
    }
    static func demoArray()-> [TCarModel]{
        var arr = [TCarModel]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TCarModel.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TCarModelObject: NSObject {
   public class var entityName: String {
      return "TCarModelObject"
   }

   @objc public var i_car_maker_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_title: String?

   @objc public var years = [TCarYearObject]()

   static let rKmapping : RKObjectMapping = {
        var TCarModelObjectMapping = RKObjectMapping(for: TCarModelObject.classForCoder())
        TCarModelObjectMapping?.addAttributeMappings(from: [
                "car_maker_id":"i_car_maker_id",
                "id":"pk_i_id",
                "title":"s_title",
            ])
        return TCarModelObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
                    TCarModelObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_years", toKeyPath: "years" , with: TCarYearObject.rKmapping))
    }

    public override var description: String{
        var description: String = "<TCarModelObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_car_maker_id\" : \(i_car_maker_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    years = [TCarYearObject].count = \(years.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarModelObject{
        let obj = TCarModelObject()
        obj.i_car_maker_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        obj.years = TCarYearObject.demoArray()
        return obj
    }
    static func demoArray()-> [TCarModelObject]{
        var arr = [TCarModelObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarModelObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TCarModelObject: NSObject,NSCoding,NSCopying {
   @objc public var i_car_maker_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_title: String?

   @objc public var years = [TCarYearObject]()

   init(fromDictionary dictionary: [String:Any]){
        i_car_maker_id = dictionary["car_maker_id"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_title = dictionary["title"] as? String

        if let arr = dictionary["car_years"] as? [[String:Any]]{
            for dic in arr{
                let value = TCarYearObject(fromDictionary: dic)
                years.append(value)
            }
        }
    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["car_maker_id"] = i_car_maker_id
        dictionary["id"] = pk_i_id
        dictionary["title"] = s_title

        do {
            var dictionaryElements = [[String:Any]]()
            for obj in years {
                dictionaryElements.append(obj.toDictionary())
            }
            dictionary["car_years"] = dictionaryElements
        }

		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        i_car_maker_id = aDecoder.decodeObject(forKey:"car_maker_id") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_title = aDecoder.decodeObject(forKey:"title") as? String

        years = aDecoder.decodeObject(forKey:"car_years") as? [TCarYearObject] ?? [TCarYearObject]()
    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if i_car_maker_id != nil{
            aCoder.encode(i_car_maker_id, forKey: "car_maker_id")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_title != nil{
            aCoder.encode(s_title, forKey: "title")
        }

        if years != nil{
            aCoder.encode(years, forKey: "car_years")
        }
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TCarModelObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TCarModelObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_car_maker_id\" : \(i_car_maker_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    years = [TCarYearObject].count = \(years.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarModelObject{
        let obj = TCarModelObject(fromDictionary: ["":""])
        obj.i_car_maker_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        obj.years = TCarYearObject.demoArray()
        return obj
    }
    static func demoArray()-> [TCarModelObject]{
        var arr = [TCarModelObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarModelObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/