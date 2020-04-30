/*************************  *************************/
//
//  UserRequest.swift
//  LlightFix
//
//  Created by  on 6/29/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

class UserRequest : BaseRequest {

    var email : String?
    var password : String?
    
    var full_name : String?
    var mobile : String?
    var car_maker_id : NSNumber?
    var car_model_id : NSNumber?
    var car_year_id : NSNumber?
    var plate_number : String?
    var carid : NSNumber?
    var color : String?

    var NewPassword : String?
    
    var fcm_token:String?

    var notification_id : NSNumber?
    var deviceId: String?
    var setting: String?
    var discription: String?

    public enum Route{
        case login
        case forgetPassword
        case registration
        case notifications
        case update
        case logout
        case update_password
        case update_token
        case check_register_data
        case notifications_read
        case notifications_unread_count
        case porfile
        case resend_email
        case update_notification_status
        case get_notification_status_update
        case UpdatePlate

    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }

    override var url : String {
        switch self.route {
        case .login:
            return GlobalConstants.API_User_Login_Controller
        case .forgetPassword:
            return GlobalConstants.API_User_forgetPassword_Controller
        case .registration:
            return GlobalConstants.API_User_registration_Controller
        case .notifications:
            return GlobalConstants.API_User_notifications_Controller
        case .update:
            return GlobalConstants.API_User_update_Controller
        case .logout:
            return GlobalConstants.API_User_logout_Controller
        case .update_password:
            return GlobalConstants.API_User_update_password_Controller
        case .update_token:
            return GlobalConstants.API_User_update_token_Controller
        case .check_register_data:
            return GlobalConstants.API_User_check_register_data_Controller
        case .notifications_read:
            return GlobalConstants.API_User_notifications_read_Controller
        case .notifications_unread_count:
            return GlobalConstants.API_User_notifications_unread_count_Controller
        case .porfile:
            return GlobalConstants.API_User_porfile_Controller
        case .resend_email:
            return GlobalConstants.API_User_resend_email_Controller
        case .update_notification_status:
            return GlobalConstants.API_Cars_Update_Notification_Status_Controller
        case .get_notification_status_update:
            return GlobalConstants.API_Cars_Get_Notification_Status_Controller
        case .UpdatePlate:
         return GlobalConstants.UpdatePlate_number
        
        }
        
    }
    override var params : Dictionary<AnyHashable, Any> {
        var parmameters : Dictionary<AnyHashable, Any> = [:]
        switch self.route {
        case .login:
            parmameters["email"]    = email
            parmameters["password"] = password
            break
        case .forgetPassword:
            parmameters["email"] = email
            break
        case .registration:
            parmameters["email"]        = email
            parmameters["password"]     = password
            parmameters["full_name"]    = full_name
            parmameters["mobile"]       = mobile
            parmameters["car_maker_id"] = car_maker_id
            parmameters["car_model_id"] = car_model_id
            parmameters["car_year_id"]  = car_year_id
            parmameters["plate_number"] = plate_number
            parmameters["color"]        = color
            parmameters["device_type"]  = "ios"
            break
        case .notifications,.logout,.notifications_unread_count,.porfile,.resend_email:
            break
        case .update:
            parmameters["email"]        = email
            parmameters["full_name"]    = full_name
            parmameters["mobile"]       = mobile
            parmameters["device_type"]  = "ios"
            break
        case .update_password:
            parmameters["old_password"]          = password
            parmameters["password"]              = NewPassword
            parmameters["password_confirmation"] = NewPassword
            break
        case .update_token:
            parmameters["token"] = UserProfile.sharedInstance.currentUserFireBaseToken
            parmameters["type"]  = "1"
            break
        case .check_register_data:
            parmameters["email"]        = email
            parmameters["mobile"]       = mobile
            break
        case .notifications_read:
            parmameters["id"] = notification_id
            break
        case .update_notification_status:
            parmameters["deviceId"]          = deviceId
            parmameters["setting"]              = setting
            parmameters["description"] = discription
            break
        case .get_notification_status_update:
            parmameters["deviceId"]          = deviceId

            break
            case .UpdatePlate:
                parmameters["plate_number"]  = plate_number
                parmameters["carId"]  = carid
            
                       break
                       
            
            
        }
        return parmameters
    }
//    override var requestObject : Any {
//        return nil
//    }
    override var type : BaseRequestHTTPMethod {
        switch self.route {
        case .login,.forgetPassword,.registration,.update,.logout,.update_password,.update_token,.check_register_data,.notifications_read,.resend_email,.update_notification_status,.get_notification_status_update,.UpdatePlate:
            return .post
        case .notifications,.notifications_unread_count,.porfile:
            return .get
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
