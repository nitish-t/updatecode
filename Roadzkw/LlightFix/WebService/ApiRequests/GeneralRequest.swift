/*************************  *************************/
//
//  GeneralRequest.swift
//  LlightFix
//
//  Created by  on 6/27/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class GeneralRequest : BaseRequest {

    var name :String?
    var email :String?
    var phone :String?
    var message :String?

    var package_id : NSNumber?

    public enum Route{
        case home
        case contact_us
        case packages
        case services
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }

    override var url : String {
        switch self.route {
        case .home:
            return GlobalConstants.API_General_home_Controller
        case .contact_us:
            return GlobalConstants.API_General_contact_us_Controller
        case .packages:
            return GlobalConstants.API_General_packages_Controller
        case .services:
            return "\(GlobalConstants.API_General_packages_Controller)/\(self.package_id?.stringValue ?? "1")/\(GlobalConstants.API_General_services_Controller)"
        }
    }
    override var params : Dictionary<AnyHashable, Any> {
        var parmameters : Dictionary<AnyHashable, Any> = [:]
        switch self.route {
        case .home,.packages,.services:
            break
        case .contact_us:
            parmameters["name"] = name
            parmameters["email"] = email
            parmameters["phone"] = phone
            parmameters["message"] = message
            break
        }
        return parmameters

    }
//    override var requestObject : Any {
//        return nil
//    }
    override var type : BaseRequestHTTPMethod {
        switch self.route {
        case .home,.packages,.services:
            return .get
        case .contact_us:
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
