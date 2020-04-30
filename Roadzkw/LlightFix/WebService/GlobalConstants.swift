/*************************  *************************/
//
//  GlobalConstants.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import Foundation

public let KDefaultImageName = "DefaultImage"

struct GlobalConstants {
    static let DataBaseName: String = "AppCoreData"
 //   static let APIUrl: String = "http://light-fix.linekwdemo2.com"  //
    //static let APIUrl: String = "http://sample.jploft.com/sagar/public"
    static let APIUrl: String = "https://www.roadzco.com"

    
    static let API_Base_Controller: String = "/api/"

    //General
    static let API_General_Controller: String            = API_Base_Controller + ""
    static let API_General_home_Controller: String       = API_General_Controller + "getHomeData"
    static let API_General_contact_us_Controller: String = API_General_Controller + "ContactUs"
    static let API_General_packages_Controller: String   = API_General_Controller + "packages"
    static let API_General_services_Controller: String   = "services"

    //Uesr
    static let API_Uesr_Controller: String                            = API_Base_Controller + "user"
    static let API_User_Login_Controller: String                      = API_Uesr_Controller + "/login"
    static let API_User_forgetPassword_Controller: String             = API_Base_Controller + "password/email"
    static let API_User_registration_Controller: String               = API_Uesr_Controller + ""
    static let API_User_notifications_Controller: String              = API_Uesr_Controller + "/notification"
    static let API_User_update_Controller: String                     = API_Uesr_Controller + "/update"
    static let API_User_logout_Controller: String                     = API_Uesr_Controller + "/logout"
    static let API_User_update_password_Controller: String            = API_Uesr_Controller + "/password"
    static let API_User_update_token_Controller: String               = API_Uesr_Controller + "/token"
    static let API_User_check_register_data_Controller: String        = API_Uesr_Controller + "/check_register_data"
    static let API_User_notifications_read_Controller: String         = API_Uesr_Controller + "/notification/read"
    static let API_User_notifications_unread_count_Controller: String = API_Uesr_Controller + "/notification/not_read_count"
    static let API_User_porfile_Controller: String                    = API_Uesr_Controller + ""
    static let API_User_resend_email_Controller: String               = API_Uesr_Controller + "/resend_verify_email"
    
    
    //Subscriptions
    static let API_Subscriptions_Controller: String                    = API_Base_Controller + "subscriptions"
    static let API_Subscriptions_List_Controller: String               = API_Subscriptions_Controller + ""
    static let API_Subscriptions_check_subscription_Controller: String = API_Base_Controller + "check_subscription"
    static let API_Subscriptions_check_coupon_Controller: String       = API_Base_Controller + "check_coupon"
    static let API_Subscriptions_make_Controller: String               = API_Base_Controller + "subscription"
    static let API_Subscriptions_check_payment_Controller: String      = API_Base_Controller + "payment/check"
    

    
    
    //Cars
    static let API_Cars_Controller: String        = API_Base_Controller + "cars"
    static let API_Cars_List_Controller: String   = API_Cars_Controller + ""
    static let API_Cars_delete_Controller: String = API_Cars_Controller + ""
    static let API_Cars_add_Controller: String    = API_Cars_Controller + ""
    
    //Notification
    static let API_Cars_Get_Notification_Status_Controller: String = API_Base_Controller + "user/usernotification"
    static let API_Cars_Update_Notification_Status_Controller: String = API_Base_Controller + "user/notificationsetting"
    //Updateplat
     static let UpdatePlate_number: String = API_Base_Controller + "UpdatePlate"

    
    
    static let API_Param_PageNumber = "page"
    static let API_Param_pagesize = "PageSize"
    static let API_PageSize: Int = 30
}
