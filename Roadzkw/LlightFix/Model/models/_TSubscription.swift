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
public enum TSubscriptionAttributes: String {
   case b_suspended
   case d_coupon_discount_percentage
   case d_price
   case i_car_id
   case i_customer_id
   case i_package_id
   case pk_i_id
   case s_coupon
   case s_dt_subscription_end
   case s_dt_subscription_start
   case s_final_total
   case s_ref_id
   case s_status
    case b_payed
}

public enum TSubscriptionRelationships: String {
   case car
   case package
}


// swiftlint:disable type_name
public class _TSubscription: NSManagedObject {
   public class var entityName: String {
      return "TSubscription"
   }

   @objc @NSManaged public var b_suspended: NSNumber?
   @objc @NSManaged public var d_coupon_discount_percentage: NSNumber?
   @objc @NSManaged public var d_price: NSNumber?
   @objc @NSManaged public var i_car_id: NSNumber?
   @objc @NSManaged public var i_customer_id: NSNumber?
   @objc @NSManaged public var i_package_id: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_coupon: String?
    @objc @NSManaged public var b_payed: NSNumber?
   @objc @NSManaged public var s_dt_subscription_end: String?
   @objc @NSManaged public var s_dt_subscription_start: String?
   @objc @NSManaged public var s_final_total: String?
   @objc @NSManaged public var s_ref_id: String?
   @objc @NSManaged public var s_status: String?

   @objc @NSManaged public var car: TCar?
   @objc @NSManaged public var package: TPackage?

   static let rKmapping : RKEntityMapping = {
        var TSubscriptionMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TSubscription.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TSubscriptionMapping?.addAttributeMappings(from: [
                "b_suspended":"b_suspended",
                "coupon_discount_percentage":"d_coupon_discount_percentage",
                "price":"d_price",
                "car_id":"i_car_id",
                "customer_id":"i_customer_id",
                "package_id":"i_package_id",
                "id":"pk_i_id",
                "coupon":"s_coupon",
                "subscription_end":"s_dt_subscription_end",
                "subscription_start":"s_dt_subscription_start",
                "final_total":"s_final_total",
                "ref_id":"s_ref_id",
                "status":"s_status",
                "b_payed":"b_payed",
            ])
        TSubscriptionMapping?.identificationAttributes = ["pk_i_id"]
        return TSubscriptionMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////
                    TSubscription.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car", toKeyPath: "car" , with: TCar.rKmapping))
                    TSubscription.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"package", toKeyPath: "package" , with: TPackage.rKmapping))

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TSubscription: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"
 
//        description += "\n    \"b_payed\" : \(b_payed != nil ? "\"\(b_payed?.description ?? "nil")\"" : "\(b_payed?.description ?? "nil")");"
        description += "\n    \"b_payed\" : \(b_payed?.description ?? "nil");"



        description += "\n    \"b_suspended\" : \(b_suspended?.description ?? "nil");"
        description += "\n    \"d_coupon_discount_percentage\" : \(d_coupon_discount_percentage?.description ?? "nil");"
        description += "\n    \"d_price\" : \(d_price?.description ?? "nil");"
        description += "\n    \"i_car_id\" : \(i_car_id?.description ?? "nil");"
        description += "\n    \"i_customer_id\" : \(i_customer_id?.description ?? "nil");"
        description += "\n    \"i_package_id\" : \(i_package_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_coupon\" : \(s_coupon != nil ? "\"\(s_coupon?.description ?? "nil")\"" : "\(s_coupon?.description ?? "nil")");"
        description += "\n    \"s_dt_subscription_end\" : \(s_dt_subscription_end != nil ? "\"\(s_dt_subscription_end?.description ?? "nil")\"" : "\(s_dt_subscription_end?.description ?? "nil")");"
        description += "\n    \"s_dt_subscription_start\" : \(s_dt_subscription_start != nil ? "\"\(s_dt_subscription_start?.description ?? "nil")\"" : "\(s_dt_subscription_start?.description ?? "nil")");"
        description += "\n    \"s_final_total\" : \(s_final_total != nil ? "\"\(s_final_total?.description ?? "nil")\"" : "\(s_final_total?.description ?? "nil")");"
        description += "\n    \"s_ref_id\" : \(s_ref_id != nil ? "\"\(s_ref_id?.description ?? "nil")\"" : "\(s_ref_id?.description ?? "nil")");"
        description += "\n    \"s_status\" : \(s_status != nil ? "\"\(s_status?.description ?? "nil")\"" : "\(s_status?.description ?? "nil")");"
        description += "\n    car = \(car != nil ? "<\(type(of: car!)): \(Unmanaged.passUnretained(car!).toOpaque())>" : "nil");"
        description += "\n    package = \(package != nil ? "<\(type(of: package!)): \(Unmanaged.passUnretained(package!).toOpaque())>" : "nil");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSubscription?{
        let obj = TSubscription.mr_createEntity()
        obj?.b_suspended = NSNumber(value: Randoms.randomBool())
        obj?.d_coupon_discount_percentage = NSNumber(value: Randoms.randomDouble())
        obj?.d_price = NSNumber(value: Randoms.randomDouble())
        obj?.i_car_id = NSNumber(value: Randoms.randomInt32())
        obj?.i_customer_id = NSNumber(value: Randoms.randomInt32())
        obj?.i_package_id = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_coupon = Randoms.randomFakeName()
        obj?.s_dt_subscription_end = Randoms.randomFakeName()
        obj?.s_dt_subscription_start = Randoms.randomFakeName()
        obj?.s_final_total = Randoms.randomFakeName()
        obj?.s_ref_id = Randoms.randomFakeName()
        obj?.s_status = Randoms.randomFakeName()
        obj?.b_payed = NSNumber(value: Randoms.randomInt32())
        //Reletions
        return obj
    }
    static func demoArray()-> [TSubscription]{
        var arr = [TSubscription]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TSubscription.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TSubscriptionObject: NSObject {
   public class var entityName: String {
      return "TSubscriptionObject"
   }

   @objc public var b_suspended: NSNumber?
   @objc public var d_coupon_discount_percentage: NSNumber?
   @objc public var d_price: NSNumber?
   @objc public var i_car_id: NSNumber?
   @objc public var i_customer_id: NSNumber?
   @objc public var i_package_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_coupon: String?
   @objc public var s_dt_subscription_end: String?
   @objc public var s_dt_subscription_start: String?
   @objc public var s_final_total: String?
   @objc public var s_ref_id: String?
   @objc public var s_status: String?
    @objc public var b_payed: NSNumber?

   @objc public var car: TCarObject?
   @objc public var package: TPackageObject?

   static let rKmapping : RKObjectMapping = {
        var TSubscriptionObjectMapping = RKObjectMapping(for: TSubscriptionObject.classForCoder())
        TSubscriptionObjectMapping?.addAttributeMappings(from: [
                "b_suspended":"b_suspended",
                "coupon_discount_percentage":"d_coupon_discount_percentage",
                "price":"d_price",
                "car_id":"i_car_id",
                "customer_id":"i_customer_id",
                "package_id":"i_package_id",
                "id":"pk_i_id",
                "coupon":"s_coupon",
                "subscription_end":"s_dt_subscription_end",
                "subscription_start":"s_dt_subscription_start",
                "final_total":"s_final_total",
                "ref_id":"s_ref_id",
                "status":"s_status",
                "b_payed":"b_payed",
            ])
        return TSubscriptionObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////
                    TSubscriptionObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car", toKeyPath: "car" , with: TCarObject.rKmapping))
                    TSubscriptionObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"package", toKeyPath: "package" , with: TPackageObject.rKmapping))

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TSubscriptionObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"
//        description += "\n    \"b_payed\" : \(b_payed != nil ? "\"\(b_payed?.description ?? "nil")\"" : "\(b_payed?.description ?? "nil")");"
        description += "\n    \"b_payed\" : \(b_payed?.description ?? "nil");"


        description += "\n    \"b_suspended\" : \(b_suspended?.description ?? "nil");"
        description += "\n    \"d_coupon_discount_percentage\" : \(d_coupon_discount_percentage?.description ?? "nil");"
        description += "\n    \"d_price\" : \(d_price?.description ?? "nil");"
        description += "\n    \"i_car_id\" : \(i_car_id?.description ?? "nil");"
        description += "\n    \"i_customer_id\" : \(i_customer_id?.description ?? "nil");"
        description += "\n    \"i_package_id\" : \(i_package_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_coupon\" : \(s_coupon != nil ? "\"\(s_coupon?.description ?? "nil")\"" : "\(s_coupon?.description ?? "nil")");"
        description += "\n    \"s_dt_subscription_end\" : \(s_dt_subscription_end != nil ? "\"\(s_dt_subscription_end?.description ?? "nil")\"" : "\(s_dt_subscription_end?.description ?? "nil")");"
        description += "\n    \"s_dt_subscription_start\" : \(s_dt_subscription_start != nil ? "\"\(s_dt_subscription_start?.description ?? "nil")\"" : "\(s_dt_subscription_start?.description ?? "nil")");"
        description += "\n    \"s_final_total\" : \(s_final_total != nil ? "\"\(s_final_total?.description ?? "nil")\"" : "\(s_final_total?.description ?? "nil")");"
        description += "\n    \"s_ref_id\" : \(s_ref_id != nil ? "\"\(s_ref_id?.description ?? "nil")\"" : "\(s_ref_id?.description ?? "nil")");"
        description += "\n    \"s_status\" : \(s_status != nil ? "\"\(s_status?.description ?? "nil")\"" : "\(s_status?.description ?? "nil")");"
        description += "\n    car = \(car != nil ? "<\(type(of: car!)): \(Unmanaged.passUnretained(car!).toOpaque())>" : "nil");"
        description += "\n    package = \(package != nil ? "<\(type(of: package!)): \(Unmanaged.passUnretained(package!).toOpaque())>" : "nil");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSubscriptionObject{
        let obj = TSubscriptionObject()
        obj.b_suspended = NSNumber(value: Randoms.randomBool())
        obj.d_coupon_discount_percentage = NSNumber(value: Randoms.randomDouble())
        obj.d_price = NSNumber(value: Randoms.randomDouble())
        obj.i_car_id = NSNumber(value: Randoms.randomInt32())
        obj.i_customer_id = NSNumber(value: Randoms.randomInt32())
        obj.i_package_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_coupon = Randoms.randomFakeName()
        obj.s_dt_subscription_end = Randoms.randomFakeName()
        obj.s_dt_subscription_start = Randoms.randomFakeName()
        obj.s_final_total = Randoms.randomFakeName()
        obj.s_ref_id = Randoms.randomFakeName()
        obj.s_status = Randoms.randomFakeName()
        onj.b_payed = NSNumber(value: Randoms.randomInt32())
        //Reletions
        return obj
    }
    static func demoArray()-> [TSubscriptionObject]{
        var arr = [TSubscriptionObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TSubscriptionObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TSubscriptionObject: NSObject,NSCoding,NSCopying {
   @objc public var b_suspended: NSNumber?
   @objc public var d_coupon_discount_percentage: NSNumber?
   @objc public var d_price: NSNumber?
   @objc public var i_car_id: NSNumber?
   @objc public var i_customer_id: NSNumber?
   @objc public var i_package_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_coupon: String?
   @objc public var s_dt_subscription_end: String?
   @objc public var s_dt_subscription_start: String?
   @objc public var s_final_total: String?
   @objc public var s_ref_id: String?
   @objc public var s_status: String?
    @objc public var b_payed: NSNumber?

   @objc public var car: TCarObject?
   @objc public var package: TPackageObject?

   init(fromDictionary dictionary: [String:Any]){
        b_suspended = dictionary["b_suspended"] as? NSNumber
        d_coupon_discount_percentage = dictionary["coupon_discount_percentage"] as? NSNumber
        d_price = dictionary["price"] as? NSNumber
        i_car_id = dictionary["car_id"] as? NSNumber
        i_customer_id = dictionary["customer_id"] as? NSNumber
        i_package_id = dictionary["package_id"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_coupon = dictionary["coupon"] as? String
        s_dt_subscription_end = dictionary["subscription_end"] as? String
        s_dt_subscription_start = dictionary["subscription_start"] as? String
        s_final_total = dictionary["final_total"] as? String
        s_ref_id = dictionary["ref_id"] as? String
        s_status = dictionary["status"] as? String
        b_payed = dictionary["b_payed"] as? NSNumber

        if let data = dictionary["car"] as? [String:Any]{
            car = TCarObject(fromDictionary: data)
        }
        if let data = dictionary["package"] as? [String:Any]{
            package = TPackageObject(fromDictionary: data)
        }
    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["b_suspended"] = b_suspended
        dictionary["coupon_discount_percentage"] = d_coupon_discount_percentage
        dictionary["price"] = d_price
        dictionary["car_id"] = i_car_id
        dictionary["customer_id"] = i_customer_id
        dictionary["package_id"] = i_package_id
        dictionary["id"] = pk_i_id
        dictionary["coupon"] = s_coupon
        dictionary["subscription_end"] = s_dt_subscription_end
        dictionary["subscription_start"] = s_dt_subscription_start
        dictionary["final_total"] = s_final_total
        dictionary["ref_id"] = s_ref_id
        dictionary["status"] = s_status
        dictionary["b_payed"] = b_payed

        dictionary["car"] =  car?.toDictionary()
        dictionary["package"] =  package?.toDictionary()

		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        b_suspended = aDecoder.decodeObject(forKey:"b_suspended") as? NSNumber
        d_coupon_discount_percentage = aDecoder.decodeObject(forKey:"coupon_discount_percentage") as? NSNumber
        d_price = aDecoder.decodeObject(forKey:"price") as? NSNumber
        i_car_id = aDecoder.decodeObject(forKey:"car_id") as? NSNumber
        i_customer_id = aDecoder.decodeObject(forKey:"customer_id") as? NSNumber
        i_package_id = aDecoder.decodeObject(forKey:"package_id") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_coupon = aDecoder.decodeObject(forKey:"coupon") as? String
        s_dt_subscription_end = aDecoder.decodeObject(forKey:"subscription_end") as? String
        s_dt_subscription_start = aDecoder.decodeObject(forKey:"subscription_start") as? String
        s_final_total = aDecoder.decodeObject(forKey:"final_total") as? String
        s_ref_id = aDecoder.decodeObject(forKey:"ref_id") as? String
        s_status = aDecoder.decodeObject(forKey:"status") as? String

        car = aDecoder.decodeObject(forKey:"car") as? TCarObject
        package = aDecoder.decodeObject(forKey:"package") as? TPackageObject
        b_payed = aDecoder.decodeObject(forKey:"b_payed") as? NSNumber

    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if b_suspended != nil{
            aCoder.encode(b_suspended, forKey: "b_suspended")
        }
        if d_coupon_discount_percentage != nil{
            aCoder.encode(d_coupon_discount_percentage, forKey: "coupon_discount_percentage")
        }
        if d_price != nil{
            aCoder.encode(d_price, forKey: "price")
        }
        if i_car_id != nil{
            aCoder.encode(i_car_id, forKey: "car_id")
        }
        if i_customer_id != nil{
            aCoder.encode(i_customer_id, forKey: "customer_id")
        }
        if i_package_id != nil{
            aCoder.encode(i_package_id, forKey: "package_id")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_coupon != nil{
            aCoder.encode(s_coupon, forKey: "coupon")
        }
        if s_dt_subscription_end != nil{
            aCoder.encode(s_dt_subscription_end, forKey: "subscription_end")
        }
        if s_dt_subscription_start != nil{
            aCoder.encode(s_dt_subscription_start, forKey: "subscription_start")
        }
        if s_final_total != nil{
            aCoder.encode(s_final_total, forKey: "final_total")
        }
        if s_ref_id != nil{
            aCoder.encode(s_ref_id, forKey: "ref_id")
        }
        if s_status != nil{
            aCoder.encode(s_status, forKey: "status")
        }

        if car != nil{
            aCoder.encode(car, forKey: "car")
        }
        if package != nil{
            aCoder.encode(package, forKey: "package")
        }
        
        if b_payed != nil{
               aCoder.encode(b_payed, forKey: "b_payed")
           }
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TSubscriptionObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TSubscriptionObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"
        
//        description += "\n    \"b_payed\" : \(b_payed != nil ? "\"\(b_payed?.description ?? "nil")\"" : "\(b_payed?.description ?? "nil")");"
        description += "\n    \"b_payed\" : \(b_payed?.description ?? "nil");"


        description += "\n    \"b_suspended\" : \(b_suspended?.description ?? "nil");"
        description += "\n    \"d_coupon_discount_percentage\" : \(d_coupon_discount_percentage?.description ?? "nil");"
        description += "\n    \"d_price\" : \(d_price?.description ?? "nil");"
        description += "\n    \"i_car_id\" : \(i_car_id?.description ?? "nil");"
        description += "\n    \"i_customer_id\" : \(i_customer_id?.description ?? "nil");"
        description += "\n    \"i_package_id\" : \(i_package_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_coupon\" : \(s_coupon != nil ? "\"\(s_coupon?.description ?? "nil")\"" : "\(s_coupon?.description ?? "nil")");"
        description += "\n    \"s_dt_subscription_end\" : \(s_dt_subscription_end != nil ? "\"\(s_dt_subscription_end?.description ?? "nil")\"" : "\(s_dt_subscription_end?.description ?? "nil")");"
        description += "\n    \"s_dt_subscription_start\" : \(s_dt_subscription_start != nil ? "\"\(s_dt_subscription_start?.description ?? "nil")\"" : "\(s_dt_subscription_start?.description ?? "nil")");"
        description += "\n    \"s_final_total\" : \(s_final_total != nil ? "\"\(s_final_total?.description ?? "nil")\"" : "\(s_final_total?.description ?? "nil")");"
        description += "\n    \"s_ref_id\" : \(s_ref_id != nil ? "\"\(s_ref_id?.description ?? "nil")\"" : "\(s_ref_id?.description ?? "nil")");"
        description += "\n    \"s_status\" : \(s_status != nil ? "\"\(s_status?.description ?? "nil")\"" : "\(s_status?.description ?? "nil")");"
        description += "\n    car = \(car != nil ? "<TSubscriptionObject: \(Unmanaged.passUnretained(car!).toOpaque())>" : "nil");"
        description += "\n    package = \(package != nil ? "<TSubscriptionObject: \(Unmanaged.passUnretained(package!).toOpaque())>" : "nil");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TSubscriptionObject{
        let obj = TSubscriptionObject(fromDictionary: ["":""])
        obj.b_suspended = NSNumber(value: Randoms.randomBool())
        obj.d_coupon_discount_percentage = NSNumber(value: Randoms.randomDouble())
        obj.d_price = NSNumber(value: Randoms.randomDouble())
        obj.i_car_id = NSNumber(value: Randoms.randomInt32())
        obj.i_customer_id = NSNumber(value: Randoms.randomInt32())
        obj.i_package_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_coupon = Randoms.randomFakeName()
        obj.s_dt_subscription_end = Randoms.randomFakeName()
        obj.s_dt_subscription_start = Randoms.randomFakeName()
        obj.s_final_total = Randoms.randomFakeName()
        obj.s_ref_id = Randoms.randomFakeName()
        obj.s_status = Randoms.randomFakeName()
        obj.b_payed = NSNumber(value: Randoms.randomInt32())

        //Reletions
        return obj
    }
    static func demoArray()-> [TSubscriptionObject]{
        var arr = [TSubscriptionObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TSubscriptionObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/
