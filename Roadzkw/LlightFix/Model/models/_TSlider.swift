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
public enum TSliderAttributes: String {
   case pk_i_id
   case s_image
}



// swiftlint:disable type_name
public class _TSlider: NSManagedObject {
   public class var entityName: String {
      return "TSlider"
   }

   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_image: String?


   static let rKmapping : RKEntityMapping = {
        var TSliderMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TSlider.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TSliderMapping?.addAttributeMappings(from: [
                "id":"pk_i_id",
                "image":"s_image",
            ])
        TSliderMapping?.identificationAttributes = ["pk_i_id"]
        return TSliderMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TSlider: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSlider?{
        let obj = TSlider.mr_createEntity()
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_image = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TSlider]{
        var arr = [TSlider]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TSlider.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TSliderObject: NSObject {
   public class var entityName: String {
      return "TSliderObject"
   }

   @objc public var pk_i_id: NSNumber?
   @objc public var s_image: String?


   static let rKmapping : RKObjectMapping = {
        var TSliderObjectMapping = RKObjectMapping(for: TSliderObject.classForCoder())
        TSliderObjectMapping?.addAttributeMappings(from: [
                "id":"pk_i_id",
                "image":"s_image",
            ])
        return TSliderObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TSliderObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSliderObject{
        let obj = TSliderObject()
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_image = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TSliderObject]{
        var arr = [TSliderObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TSliderObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TSliderObject: NSObject,NSCoding,NSCopying {
   @objc public var pk_i_id: NSNumber?
   @objc public var s_image: String?


   init(fromDictionary dictionary: [String:Any]){
        pk_i_id = dictionary["id"] as? NSNumber
        s_image = dictionary["image"] as? String

    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["id"] = pk_i_id
        dictionary["image"] = s_image


		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_image = aDecoder.decodeObject(forKey:"image") as? String

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_image != nil{
            aCoder.encode(s_image, forKey: "image")
        }

    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TSliderObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TSliderObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_image\" : \(s_image != nil ? "\"\(s_image?.description ?? "nil")\"" : "\(s_image?.description ?? "nil")");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSliderObject{
        let obj = TSliderObject(fromDictionary: ["":""])
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_image = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TSliderObject]{
        var arr = [TSliderObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TSliderObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/