/*************************  *************************/
//
//  CarsRequest.swift
//  LlightFix
//
//  Created by  on 7/1/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class CarsRequest : BaseRequest {

    var pk_i_id : NSNumber?
    
    var car_maker_id : NSNumber?
    var car_model_id : NSNumber?
    var car_year_id : NSNumber?
    var plate_number : String?
    var color : String?
   

    public enum Route{
        case list
        case delete
        case add
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }

    override var url : String {
        switch self.route {
        case .list:
            return GlobalConstants.API_Cars_List_Controller
        case .delete:
            return "\(GlobalConstants.API_Cars_delete_Controller)/\(self.pk_i_id?.stringValue ?? "")"
        case .add:
            return GlobalConstants.API_Cars_add_Controller
        }
    }
    override var params : Dictionary<AnyHashable, Any> {
        var parmameters : Dictionary<AnyHashable, Any> = [:]
        switch self.route {
        case .list,.delete:
            parmameters[""] = ""
            break
        case .add:
            parmameters["car_maker_id"] = car_maker_id
            parmameters["car_model_id"] = car_model_id
            parmameters["car_year_id"]  = car_year_id
            parmameters["plate_number"] = plate_number
            parmameters["color"]        = color
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
        case .add:
            return .post
        case .delete:
            return .delete
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
