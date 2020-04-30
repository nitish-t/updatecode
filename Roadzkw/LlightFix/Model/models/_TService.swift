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
public enum TServiceAttributes: String {
   case i_package_id
   case pk_i_id
   case s_image
   case s_title
}



// swiftlint:disable type_name
public class _TService: NSManagedObject {
   public class var entityName: String {
      return "TService"
   }

   @objc @NSManaged public var i_package_id: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_image: String?
   @objc @NSManaged public var s_title: String?


   static let rKmapping : RKEntityMapping = {
        var TServiceMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TService.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TServiceMapping?.addAttributeMappings(from: [
                "package_id":"i_package_id",
                "id":"pk_i_id",
                "image":"s_image",
                "title":"s_title",
            ])
        TServiceMapping?.identificationAttributes = ["pk_i_id"]
        return TServiceMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TService: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_package_id\" : \(i_package_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TService?{
        let obj = TService.mr_createEntity()
        obj?.i_package_id = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_image = Randoms.randomFakeName()
        obj?.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TService]{
        var arr = [TService]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TService.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TServiceObject: NSObject {
   public class var entityName: String {
      return "TServiceObject"
   }

   @objc public var i_package_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_image: String?
   @objc public var s_title: String?


   static let rKmapping : RKObjectMapping = {
        var TServiceObjectMapping = RKObjectMapping(for: TServiceObject.classForCoder())
        TServiceObjectMapping?.addAttributeMappings(from: [
                "package_id":"i_package_id",
                "id":"pk_i_id",
                "image":"s_image",
                "title":"s_title",
            ])
        return TServiceObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TServiceObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_package_id\" : \(i_package_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TServiceObject{
        let obj = TServiceObject()
        obj.i_package_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_image = Randoms.randomFakeName()
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TServiceObject]{
        var arr = [TServiceObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TServiceObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TServiceObject: NSObject,NSCoding,NSCopying {
   @objc public var i_package_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_image: String?
   @objc public var s_title: String?


   init(fromDictionary dictionary: [String:Any]){
        i_package_id = dictionary["package_id"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_image = dictionary["image"] as? String
        s_title = dictionary["title"] as? String

    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["package_id"] = i_package_id
        dictionary["id"] = pk_i_id
        dictionary["image"] = s_image
        dictionary["title"] = s_title


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        i_package_id = aDecoder.decodeObject(forKey:"package_id") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_image = aDecoder.decodeObject(forKey:"image") as? String
        s_title = aDecoder.decodeObject(forKey:"title") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if i_package_id != nil{
            aCoder.encode(i_package_id, forKey: "package_id")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_image != nil{
            aCoder.encode(s_image, forKey: "image")
        }
        if s_title != nil{
            aCoder.encode(s_title, forKey: "title")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TServiceObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TServiceObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"i_package_id\" : \(i_package_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n    \"s_title\" : \(s_title != nil ? "\"\(s_title?.description ?? "nil")\"" : "\(s_title?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TServiceObject{
        let obj = TServiceObject(fromDictionary: ["":""])
        obj.i_package_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_image = Randoms.randomFakeName()
        obj.s_title = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TServiceObject]{
        var arr = [TServiceObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TServiceObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/