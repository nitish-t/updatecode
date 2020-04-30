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
public enum TPackageAttributes: String {
   case pk_i_id
   case s_dt_created
   case s_price
   case s_type
}

public enum TPackageRelationships: String {
   case services
}


// swiftlint:disable type_name
public class _TPackage: NSManagedObject {
   public class var entityName: String {
      return "TPackage"
   }

   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_dt_created: String?
   @objc @NSManaged public var s_price: String?
   @objc @NSManaged public var s_type: String?

   @objc @NSManaged public var services: NSSet

   static let rKmapping : RKEntityMapping = {
        var TPackageMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TPackage.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TPackageMapping?.addAttributeMappings(from: [
                "id":"pk_i_id",
                "created_at":"s_dt_created",
                "price":"s_price",
                "type":"s_type",
            ])
        TPackageMapping?.identificationAttributes = ["pk_i_id"]
        return TPackageMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
                    TPackage.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"services", toKeyPath: "services" , with: TService.rKmapping))
    }

    public override var description: String{
        var description: String = "<TPackage: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_dt_created\" : \(s_dt_created != nil ? "\"\(s_dt_created?.description ?? "nil")\"" : "\(s_dt_created?.description ?? "nil")");"
        description += "\n    \"s_price\" : \(s_price != nil ? "\"\(s_price?.description ?? "nil")\"" : "\(s_price?.description ?? "nil")");"
        description += "\n    \"s_type\" : \(s_type != nil ? "\"\(s_type?.description ?? "nil")\"" : "\(s_type?.description ?? "nil")");"
        description += "\n    services = [TService].count = \(services.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TPackage?{
        let obj = TPackage.mr_createEntity()
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_dt_created = Randoms.randomFakeName()
        obj?.s_price = Randoms.randomFakeName()
        obj?.s_type = Randoms.randomFakeName()
        //Reletions
        obj?.services = NSSet(array: TService.demoArray())
        return obj
    }
    static func demoArray()-> [TPackage]{
        var arr = [TPackage]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TPackage.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TPackageObject: NSObject {
   public class var entityName: String {
      return "TPackageObject"
   }

   @objc public var pk_i_id: NSNumber?
   @objc public var s_dt_created: String?
   @objc public var s_price: String?
   @objc public var s_type: String?

   @objc public var services = [TServiceObject]()

   static let rKmapping : RKObjectMapping = {
        var TPackageObjectMapping = RKObjectMapping(for: TPackageObject.classForCoder())
        TPackageObjectMapping?.addAttributeMappings(from: [
                "id":"pk_i_id",
                "created_at":"s_dt_created",
                "price":"s_price",
                "type":"s_type",
            ])
        return TPackageObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
                    TPackageObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"services", toKeyPath: "services" , with: TServiceObject.rKmapping))
    }

    public override var description: String{
        var description: String = "<TPackageObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_dt_created\" : \(s_dt_created != nil ? "\"\(s_dt_created?.description ?? "nil")\"" : "\(s_dt_created?.description ?? "nil")");"
        description += "\n    \"s_price\" : \(s_price != nil ? "\"\(s_price?.description ?? "nil")\"" : "\(s_price?.description ?? "nil")");"
        description += "\n    \"s_type\" : \(s_type != nil ? "\"\(s_type?.description ?? "nil")\"" : "\(s_type?.description ?? "nil")");"
        description += "\n    services = [TServiceObject].count = \(services.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TPackageObject{
        let obj = TPackageObject()
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_dt_created = Randoms.randomFakeName()
        obj.s_price = Randoms.randomFakeName()
        obj.s_type = Randoms.randomFakeName()
        //Reletions
        obj.services = TServiceObject.demoArray()
        return obj
    }
    static func demoArray()-> [TPackageObject]{
        var arr = [TPackageObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TPackageObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TPackageObject: NSObject,NSCoding,NSCopying {
   @objc public var pk_i_id: NSNumber?
   @objc public var s_dt_created: String?
   @objc public var s_price: String?
   @objc public var s_type: String?

   @objc public var services = [TServiceObject]()

   init(fromDictionary dictionary: [String:Any]){
        pk_i_id = dictionary["id"] as? NSNumber
        s_dt_created = dictionary["created_at"] as? String
        s_price = dictionary["price"] as? String
        s_type = dictionary["type"] as? String
    
    if s_type == "emergency" {
            
            let tempTotalValue = Float(String(s_price!))
            let newPrice = NSNumber(value: tempTotalValue!).formatedZeroNumber
            UserDefaults.standard.set(newPrice, forKey: "currentPrice")
            UserDefaults.standard.synchronize()
    }

        if let arr = dictionary["services"] as? [[String:Any]]{
            for dic in arr{
                let value = TServiceObject(fromDictionary: dic)
                services.append(value)
            }
        }
    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["id"] = pk_i_id
        dictionary["created_at"] = s_dt_created
        dictionary["price"] = s_price
        dictionary["type"] = s_type

        do {
            var dictionaryElements = [[String:Any]]()
            for obj in services {
                dictionaryElements.append(obj.toDictionary())
            }
            dictionary["services"] = dictionaryElements
        }

		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_dt_created = aDecoder.decodeObject(forKey:"created_at") as? String
        s_price = aDecoder.decodeObject(forKey:"price") as? String
        s_type = aDecoder.decodeObject(forKey:"type") as? String

        services = aDecoder.decodeObject(forKey:"services") as? [TServiceObject] ?? [TServiceObject]()
    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_dt_created != nil{
            aCoder.encode(s_dt_created, forKey: "created_at")
        }
        if s_price != nil{
            aCoder.encode(s_price, forKey: "price")
        }
        if s_type != nil{
            aCoder.encode(s_type, forKey: "type")
        }

        if services != nil{
            aCoder.encode(services, forKey: "services")
        }
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TPackageObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TPackageObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_dt_created\" : \(s_dt_created != nil ? "\"\(s_dt_created?.description ?? "nil")\"" : "\(s_dt_created?.description ?? "nil")");"
        description += "\n    \"s_price\" : \(s_price != nil ? "\"\(s_price?.description ?? "nil")\"" : "\(s_price?.description ?? "nil")");"
        description += "\n    \"s_type\" : \(s_type != nil ? "\"\(s_type?.description ?? "nil")\"" : "\(s_type?.description ?? "nil")");"
        description += "\n    services = [TServiceObject].count = \(services.count);"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TPackageObject{
        let obj = TPackageObject(fromDictionary: ["":""])
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_dt_created = Randoms.randomFakeName()
        obj.s_price = Randoms.randomFakeName()
        obj.s_type = Randoms.randomFakeName()
        //Reletions
        obj.services = TServiceObject.demoArray()
        return obj
    }
    static func demoArray()-> [TPackageObject]{
        var arr = [TPackageObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TPackageObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/
