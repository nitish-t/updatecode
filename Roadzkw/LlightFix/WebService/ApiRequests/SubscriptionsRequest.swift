/*************************  *************************/
//
//  SubscriptionsRequest.swift
//  LlightFix
//
//  Created by  on 7/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class SubscriptionsRequest : BaseRequest {

    var car_id : NSNumber?
    var coupon : String?
    
    var package_id : NSNumber?
    var latitude : NSNumber?
    var longitude : NSNumber?
    var service_id : NSNumber?

    var order_id : String?

    public enum Route{
        case list
        case check_subscription
        case check_coupon
        case make
        case check_payment
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }

    override var url : String {
        switch self.route {
        case .list:
            return GlobalConstants.API_Subscriptions_List_Controller
        case .check_subscription:
            return GlobalConstants.API_Subscriptions_check_subscription_Controller
        case .check_coupon:
            return GlobalConstants.API_Subscriptions_check_coupon_Controller
        case .make:
            return GlobalConstants.API_Subscriptions_make_Controller
        case .check_payment:
            return GlobalConstants.API_Subscriptions_check_payment_Controller
        }
    }
    override var params : Dictionary<AnyHashable, Any> {
        var parmameters : Dictionary<AnyHashable, Any> = [:]
        switch self.route {
        case .list:
            parmameters[""] = ""
            break
        case .check_subscription:
            parmameters["car_id"] = car_id
            break
        case .check_coupon:
            parmameters["coupon"] = coupon
            break
        case .make:
            parmameters["car_id"]     = car_id
            parmameters["coupon"]     = coupon
            parmameters["package_id"] = package_id
            parmameters["latitude"]   = latitude
            parmameters["longitude"]  = longitude
            parmameters["service_id"] = service_id
            break
        case .check_payment:
            parmameters["order_id"] = order_id
            break
        }
        return parmameters
    }
//    override var requestObject : Any {
//        return nil
//    }
    override var type : BaseRequestHTTPMethod {
        switch self.route {
        case .list:
            return .get
        case .check_subscription,.check_coupon,.make,.check_payment:
            return .post
        }
    }
//    override var responseReplacing: Dictionary<String, String>?{
//        return ["data":"users"]
//    }
    override var multiPartFiles: [BaseRequestFile] {
        //        if let dataImage = UIImageJPEGRepresentation(#imageLiteral(resourceName: "img.png"),1) {
        //            return [BaseRequestFile(fileData: dataImage, parameterName: "a_file", fileName: "image")]
        //        }else{
        return []
        //        }
    }
}
