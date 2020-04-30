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
public enum TCarAttributes: String {
   case b_open_request
   case i_car_maker_id
   case i_car_model_id
   case i_car_year_id
   case i_customer_id
   case pk_i_id
   case s_color
    case s_status
   case s_plate_number

}

public enum TCarRelationships: String {
   case carMaker
   case carModel
   case carYear
   case subscription
}


// swiftlint:disable type_name
public class _TCar: NSManagedObject {
   public class var entityName: String {
      return "TCar"
   }

   @objc @NSManaged public var b_open_request: NSNumber?
   @objc @NSManaged public var i_car_maker_id: NSNumber?
   @objc @NSManaged public var i_car_model_id: NSNumber?
   @objc @NSManaged public var i_car_year_id: NSNumber?
   @objc @NSManaged public var i_customer_id: NSNumber?
   @objc @NSManaged public var pk_i_id: NSNumber?
   @objc @NSManaged public var s_color: String?
     @objc @NSManaged public var s_status: String?
   @objc @NSManaged public var s_plate_number: String?
   @objc @NSManaged public var carMaker: TCarMaker?
   @objc @NSManaged public var carModel: TCarModel?
   @objc @NSManaged public var carYear: TCarYear?
   @objc @NSManaged public var subscription: TSubscription?

   static let rKmapping : RKEntityMapping = {
        var TCarMapping = RKEntityMapping(forEntityForName: NSStringFromClass(TCar.classForCoder()), in: RKObjectManager.shared().managedObjectStore)
        TCarMapping?.addAttributeMappings(from: [
                "has_open_request":"b_open_request",
                "car_maker_id":"i_car_maker_id",
                "car_model_id":"i_car_model_id",
                "car_year_id":"i_car_year_id",
                "customer_id":"i_customer_id",
                "id":"pk_i_id",
                "color":"s_color",
                "status":"s_status",
                "plate_number":"s_plate_number",
            ])
        TCarMapping?.identificationAttributes = ["pk_i_id"]
        return TCarMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////
                    TCar.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_maker", toKeyPath: "carMaker" , with: TCarMaker.rKmapping))
                    TCar.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_model", toKeyPath: "carModel" , with: TCarModel.rKmapping))
                    TCar.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_year", toKeyPath: "carYear" , with: TCarYear.rKmapping))
                    TCar.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"subscription", toKeyPath: "subscription" , with: TSubscription.rKmapping))

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TCar: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_open_request\" : \(b_open_request?.description ?? "nil");"
        description += "\n    \"i_car_maker_id\" : \(i_car_maker_id?.description ?? "nil");"
        description += "\n    \"i_car_model_id\" : \(i_car_model_id?.description ?? "nil");"
        description += "\n    \"i_car_year_id\" : \(i_car_year_id?.description ?? "nil");"
        description += "\n    \"i_customer_id\" : \(i_customer_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_color\" : \(s_color != nil ? "\"\(s_color?.description ?? "nil")\"" : "\(s_color?.description ?? "nil")");"
        description += "\n    \"s_status\" : \(s_status != nil ? "\"\(s_status?.description ?? "nil")\"" : "\(s_status?.description ?? "nil")");"
        description += "\n    \"s_plate_number\" : \(s_plate_number != nil ? "\"\(s_plate_number?.description ?? "nil")\"" : "\(s_plate_number?.description ?? "nil")");"
        description += "\n    carMaker = \(carMaker != nil ? "<\(type(of: carMaker!)): \(Unmanaged.passUnretained(carMaker!).toOpaque())>" : "nil");"
        description += "\n    carModel = \(carModel != nil ? "<\(type(of: carModel!)): \(Unmanaged.passUnretained(carModel!).toOpaque())>" : "nil");"
        description += "\n    carYear = \(carYear != nil ? "<\(type(of: carYear!)): \(Unmanaged.passUnretained(carYear!).toOpaque())>" : "nil");"
        description += "\n    subscription = \(subscription != nil ? "<\(type(of: subscription!)): \(Unmanaged.passUnretained(subscription!).toOpaque())>" : "nil");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCar?{
        let obj = TCar.mr_createEntity()
        obj?.b_open_request = NSNumber(value: Randoms.randomBool())
        obj?.i_car_maker_id = NSNumber(value: Randoms.randomInt32())
        obj?.i_car_model_id = NSNumber(value: Randoms.randomInt32())
        obj?.i_car_year_id = NSNumber(value: Randoms.randomInt32())
        obj?.i_customer_id = NSNumber(value: Randoms.randomInt32())
        obj?.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj?.s_color = Randoms.randomFakeName()
        obj?.s_status = Randoms.randomFakeName()
        obj?.s_plate_number = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCar]{
        var arr = [TCar]()
        for _ in 1...GlobalConstants.API_PageSize {
            if let usr = TCar.demoObject() {
                arr.append(usr)
            }
        }
        return arr
    }
    #endif
}





// swiftlint:disable type_name
public class _TCarObject: NSObject {
   public class var entityName: String {
      return "TCarObject"
   }

   @objc public var b_open_request: NSNumber?
   @objc public var i_car_maker_id: NSNumber?
   @objc public var i_car_model_id: NSNumber?
   @objc public var i_car_year_id: NSNumber?
   @objc public var i_customer_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_color: String?
     @objc public var s_status: String?
   @objc public var s_plate_number: String?
   @objc public var carMaker: TCarMakerObject?
   @objc public var carModel: TCarModelObject?
   @objc public var carYear: TCarYearObject?
   @objc public var subscription: TSubscriptionObject?

   static let rKmapping : RKObjectMapping = {
        var TCarObjectMapping = RKObjectMapping(for: TCarObject.classForCoder())
        TCarObjectMapping?.addAttributeMappings(from: [
                "has_open_request":"b_open_request",
                "car_maker_id":"i_car_maker_id",
                "car_model_id":"i_car_model_id",
                "car_year_id":"i_car_year_id",
                "customer_id":"i_customer_id",
                "id":"pk_i_id",
                "color":"s_color",
                "status":"s_status",
                "plate_number":"s_plate_number",
            ])
        return TCarObjectMapping!
    }()

    static func addReletions(){
        ///// One To Many Relationships /////
                    TCarObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_maker", toKeyPath: "carMaker" , with: TCarMakerObject.rKmapping))
                    TCarObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_model", toKeyPath: "carModel" , with: TCarModelObject.rKmapping))
                    TCarObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"car_year", toKeyPath: "carYear" , with: TCarYearObject.rKmapping))
                    TCarObject.rKmapping.addPropertyMapping(RKRelationshipMapping(fromKeyPath:"subscription", toKeyPath: "subscription" , with: TSubscriptionObject.rKmapping))

        ///// Many To One Or Many Relationships /////
    }

    public override var description: String{
        var description: String = "<TCarObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_open_request\" : \(b_open_request?.description ?? "nil");"
        description += "\n    \"i_car_maker_id\" : \(i_car_maker_id?.description ?? "nil");"
        description += "\n    \"i_car_model_id\" : \(i_car_model_id?.description ?? "nil");"
       
        description += "\n    \"i_car_year_id\" : \(i_car_year_id?.description ?? "nil");"
        description += "\n    \"i_customer_id\" : \(i_customer_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_color\" : \(s_color != nil ? "\"\(s_color?.description ?? "nil")\"" : "\(s_color?.description ?? "nil")");"
         description += "\n    \"s_status\" : \(s_status != nil ? "\"\(s_status?.description ?? "nil")\"" : "\(s_status?.description ?? "nil")");"
        description += "\n    \"s_plate_number\" : \(s_plate_number != nil ? "\"\(s_plate_number?.description ?? "nil")\"" : "\(s_plate_number?.description ?? "nil")");"
        description += "\n    carMaker = \(carMaker != nil ? "<\(type(of: carMaker!)): \(Unmanaged.passUnretained(carMaker!).toOpaque())>" : "nil");"
        description += "\n    carModel = \(carModel != nil ? "<\(type(of: carModel!)): \(Unmanaged.passUnretained(carModel!).toOpaque())>" : "nil");"
        description += "\n    carYear = \(carYear != nil ? "<\(type(of: carYear!)): \(Unmanaged.passUnretained(carYear!).toOpaque())>" : "nil");"
        description += "\n    subscription = \(subscription != nil ? "<\(type(of: subscription!)): \(Unmanaged.passUnretained(subscription!).toOpaque())>" : "nil");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarObject{
        let obj = TCarObject()
        obj.b_open_request = NSNumber(value: Randoms.randomBool())
        obj.i_car_maker_id = NSNumber(value: Randoms.randomInt32())
        obj.i_car_model_id = NSNumber(value: Randoms.randomInt32())
        obj.i_car_year_id = NSNumber(value: Randoms.randomInt32())
        obj.i_customer_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_color = Randoms.randomFakeName()
        obj.s_status = Randoms.randomFakeName()
        obj.s_plate_number = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCarObject]{
        var arr = [TCarObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarObject.demoObject())
        }
        return arr
    }
    #endif
}


#elseif canImport(Alamofire)

public class _TCarObject: NSObject,NSCoding,NSCopying {
    
   @objc public var b_open_request: NSNumber?
   @objc public var i_car_maker_id: NSNumber?
   @objc public var i_car_model_id: NSNumber?
   @objc public var i_car_year_id: NSNumber?
   @objc public var i_customer_id: NSNumber?
   @objc public var pk_i_id: NSNumber?
   @objc public var s_color: String?
    @objc public var s_status: String?
   @objc public var s_plate_number: String?

   @objc public var carMaker: TCarMakerObject?
   @objc public var carModel: TCarModelObject?
   @objc public var carYear: TCarYearObject?
   @objc public var subscription: TSubscriptionObject?

   init(fromDictionary dictionary: [String:Any]){
        b_open_request = dictionary["has_open_request"] as? NSNumber
        i_car_maker_id = dictionary["car_maker_id"] as? NSNumber
        i_car_model_id = dictionary["car_model_id"] as? NSNumber
        i_car_year_id = dictionary["car_year_id"] as? NSNumber
        i_customer_id = dictionary["customer_id"] as? NSNumber
        pk_i_id = dictionary["id"] as? NSNumber
        s_color = dictionary["color"] as? String
        s_status = dictionary["status"] as? String
        s_plate_number = dictionary["plate_number"] as? String


        if let data = dictionary["car_maker"] as? [String:Any]{
            carMaker = TCarMakerObject(fromDictionary: data)
        }
        if let data = dictionary["car_model"] as? [String:Any]{
            carModel = TCarModelObject(fromDictionary: data)
        }
        if let data = dictionary["car_year"] as? [String:Any]{
            carYear = TCarYearObject(fromDictionary: data)
        }
        if let data = dictionary["subscription"] as? [String:Any]{
            subscription = TSubscriptionObject(fromDictionary: data)
        }
    }

    func toDictionary() -> [String:Any]
	{
        var dictionary = [String:Any]()

        dictionary["has_open_request"] = b_open_request
        dictionary["car_maker_id"] = i_car_maker_id
        dictionary["car_model_id"] = i_car_model_id
        dictionary["car_year_id"] = i_car_year_id
        dictionary["customer_id"] = i_customer_id
        dictionary["id"] = pk_i_id
        dictionary["color"] = s_color
        dictionary["status"] = s_status
        dictionary["plate_number"] = s_plate_number

        dictionary["car_maker"] =  carMaker?.toDictionary()
        dictionary["car_model"] =  carModel?.toDictionary()
        dictionary["car_year"] =  carYear?.toDictionary()
        dictionary["subscription"] =  subscription?.toDictionary()

		return dictionary
    }

    @objc required public init(coder aDecoder: NSCoder)
	{
        b_open_request = aDecoder.decodeObject(forKey:"has_open_request") as? NSNumber
        i_car_maker_id = aDecoder.decodeObject(forKey:"car_maker_id") as? NSNumber
        i_car_model_id = aDecoder.decodeObject(forKey:"car_model_id") as? NSNumber
        i_car_year_id = aDecoder.decodeObject(forKey:"car_year_id") as? NSNumber
        i_customer_id = aDecoder.decodeObject(forKey:"customer_id") as? NSNumber
        pk_i_id = aDecoder.decodeObject(forKey:"id") as? NSNumber
        s_color = aDecoder.decodeObject(forKey:"color") as? String
        s_status = aDecoder.decodeObject(forKey:"status") as? String
        s_plate_number = aDecoder.decodeObject(forKey:"plate_number") as? String
        carMaker = aDecoder.decodeObject(forKey:"car_maker") as? TCarMakerObject
        carModel = aDecoder.decodeObject(forKey:"car_model") as? TCarModelObject
        carYear = aDecoder.decodeObject(forKey:"car_year") as? TCarYearObject
        subscription = aDecoder.decodeObject(forKey:"subscription") as? TSubscriptionObject
    }

    @objc public func encode(with aCoder: NSCoder)
	{
        if b_open_request != nil{
            aCoder.encode(b_open_request, forKey: "has_open_request")
        }
        if i_car_maker_id != nil{
            aCoder.encode(i_car_maker_id, forKey: "car_maker_id")
        }
        if i_car_model_id != nil{
            aCoder.encode(i_car_model_id, forKey: "car_model_id")
        }
        if i_car_year_id != nil{
            aCoder.encode(i_car_year_id, forKey: "car_year_id")
        }
        if i_customer_id != nil{
            aCoder.encode(i_customer_id, forKey: "customer_id")
        }
        if pk_i_id != nil{
            aCoder.encode(pk_i_id, forKey: "id")
        }
        if s_color != nil{
            aCoder.encode(s_color, forKey: "color")
        }
        if s_status != nil{
            aCoder.encode(s_status, forKey: "status")
        }
        if s_plate_number != nil{
            aCoder.encode(s_plate_number, forKey: "plate_number")
        }

        if carMaker != nil{
            aCoder.encode(carMaker, forKey: "car_maker")
        }
        if carModel != nil{
            aCoder.encode(carModel, forKey: "car_model")
        }
        if carYear != nil{
            aCoder.encode(carYear, forKey: "car_year")
        }
        
        if subscription != nil{
            aCoder.encode(subscription, forKey: "subscription")
        }
    }
    public func copy(with zone: NSZone? = nil) -> Any {
        return TCarObject(fromDictionary: self.toDictionary())
    }

    public override var description: String{
        var description: String = "<TCarObject: \(Unmanaged.passUnretained(self as AnyObject).toOpaque())> {"

        description += "\n    \"b_open_request\" : \(b_open_request?.description ?? "nil");"
        description += "\n    \"i_car_maker_id\" : \(i_car_maker_id?.description ?? "nil");"
        description += "\n    \"i_car_model_id\" : \(i_car_model_id?.description ?? "nil");"
        description += "\n    \"i_car_year_id\" : \(i_car_year_id?.description ?? "nil");"
        description += "\n    \"i_customer_id\" : \(i_customer_id?.description ?? "nil");"
        description += "\n    \"pk_i_id\" : \(pk_i_id?.description ?? "nil");"
        description += "\n    \"s_color\" : \(s_color != nil ? "\"\(s_color?.description ?? "nil")\"" : "\(s_color?.description ?? "nil")");"
         description += "\n    \"s_status\" : \(s_status != nil ? "\"\(s_status?.description ?? "nil")\"" : "\(s_status?.description ?? "nil")");"
        description += "\n    \"s_plate_number\" : \(s_plate_number != nil ? "\"\(s_plate_number?.description ?? "nil")\"" : "\(s_plate_number?.description ?? "nil")");"
        description += "\n    carMaker = \(carMaker != nil ? "<TCarObject: \(Unmanaged.passUnretained(carMaker!).toOpaque())>" : "nil");"
        description += "\n    carModel = \(carModel != nil ? "<TCarObject: \(Unmanaged.passUnretained(carModel!).toOpaque())>" : "nil");"
        description += "\n    carYear = \(carYear != nil ? "<TCarObject: \(Unmanaged.passUnretained(carYear!).toOpaque())>" : "nil");"
        description += "\n    subscription = \(subscription != nil ? "<TCarObject: \(Unmanaged.passUnretained(subscription!).toOpaque())>" : "nil");"
        description += "\n  }"

        return description
    }

    #if canImport(SwiftRandom)
    static func demoObject()-> TCarObject{
        let obj = TCarObject(fromDictionary: ["":""])
        obj.b_open_request = NSNumber(value: Randoms.randomBool())
        obj.i_car_maker_id = NSNumber(value: Randoms.randomInt32())
        obj.i_car_model_id = NSNumber(value: Randoms.randomInt32())
        obj.i_car_year_id = NSNumber(value: Randoms.randomInt32())
        obj.i_customer_id = NSNumber(value: Randoms.randomInt32())
        obj.pk_i_id = NSNumber(value: Randoms.randomInt32())
        obj.s_color = Randoms.randomFakeName()
        obj.s_status = Randoms.randomFakeName()
        obj.s_plate_number = Randoms.randomFakeName()
        //Reletions
        return obj
    }
    static func demoArray()-> [TCarObject]{
        var arr = [TCarObject]()
        for _ in 1...GlobalConstants.API_PageSize {
            arr.append(TCarObject.demoObject())
        }
        return arr
    }
    #endif
}

#endif


/*************************  *************************/
