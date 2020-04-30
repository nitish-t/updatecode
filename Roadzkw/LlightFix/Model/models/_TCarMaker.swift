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
public enum TCarMakerAttributes: String {
   case pk_i_id
   case s_title
}

public enum TCarMakerRelationships: String {
   case models
}


// swiftlint:disable type_name
public class _TCarMaker: NSManagedObject {
   public class var entityName: String {
      return "TCarMaker"
   }

   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_title: String?

   @objc @NSManaged public var models: NSSet

   static let rKmapping : RKEntityMapping = {
        var TCarMakerMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TCarMaker.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TCarMakerMapping?.addAttributeMappings(from: [
                "id":"pk_i_id",
                "title":"s_title",
            ])
        TCarMakerMapping?.identificationAttributes = ["pk_i_id"]
        return TCarMakerMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
                    TCarMaker.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_models", toKeyPath: "models" , with: TCarModel.rKmapping))
    }

    public override var description: String{
        var description: String = "<TCarMaker: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    models = [TCarModel].count = \(models.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarMaker?{
        let obj = TCarMaker.mr_createEntity()
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_title = Randoms.randomFakeName()
        //Reletions
        obj?.models = NSSet(array: TCarModel.demoArray())
        return obj
    }
    static func demoArray()-> [TCarMaker]{
        var arr = [TCarMaker]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TCarMaker.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TCarMakerObject: NSObject {
   public class var entityName: String {
      return "TCarMakerObject"
   }

   @objc public var pk_i_id: NSNumber?
   @objc public var s_title: String?

   @objc public var models = [TCarModelObject]()

   static let rKmapping : RKObjectMapping = {
        var TCarMakerObjectMapping = RKObjectMapping(for: TCarMakerObject.classForCoder())
        TCarMakerObjectMapping?.addAttributeMappings(from: [
                "id":"pk_i_id",
                "title":"s_title",
            ])
        return TCarMakerObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
                    TCarMakerObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_models", toKeyPath: "models" , with: TCarModelObject.rKmapping))
    }

    public override var description: String{
        var description: String = "<TCarMakerObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    models = [TCarModelObject].count = \(models.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarMakerObject{
        let obj = TCarMakerObject()
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        obj.models = TCarModelObject.demoArray()
        return obj
    }
    static func demoArray()-> [TCarMakerObject]{
        var arr = [TCarMakerObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarMakerObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TCarMakerObject: NSObject,NSCoding,NSCopying {
   @objc public var pk_i_id: NSNumber?
   @objc public var s_title: String?

   @objc public var models = [TCarModelObject]()

   init(fromDictionary dictionary: [String:Any]){
        pk_i_id = dictionary["id"] as? NSNumber
        s_title = dictionary["title"] as? String

        if let arr = dictionary["car_models"] as? [[String:Any]]{
            for dic in arr{
                let value = TCarModelObject(fromDictionary: dic)
                models.append(value)
            }
        }
    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["id"] = pk_i_id
        dictionary["title"] = s_title

        do {
            var dictionaryElements = [[String:Any]]()
            for obj in models {
                dictionaryElements.append(obj.toDictionary())
            }
            dictionary["car_models"] = dictionaryElements
        }

		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_title = aDecoder.decodeObject(forKey:"title") as? String

        models = aDecoder.decodeObject(forKey:"car_models") as? [TCarModelObject] ?? [TCarModelObject]()
    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_title != nil{
            aCoder.encode(s_title, forKey: "title")
        }

        if models != nil{
            aCoder.encode(models, forKey: "car_models")
        }
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TCarMakerObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TCarMakerObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n    models = [TCarModelObject].count = \(models.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarMakerObject{
        let obj = TCarMakerObject(fromDictionary: ["":""])
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        obj.models = TCarModelObject.demoArray()
        return obj
    }
    static func demoArray()-> [TCarMakerObject]{
        var arr = [TCarMakerObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarMakerObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/