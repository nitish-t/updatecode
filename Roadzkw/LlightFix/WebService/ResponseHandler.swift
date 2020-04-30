/*************************  *************************/
//
//  ResponseHandler.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import Foundation
import UIKit
public class ResponseHandler{
    
    fileprivate static let errorMSGTitle = "Error".localize_
    fileprivate static let errorMSGDetails = "An error occurred".localize_
    
    fileprivate static func showPopup(_ str:String){
        UIApplication.topViewController_()?.showPopAlert(title : ResponseHandler.errorMSGTitle, message : str)
    }
    
    public static func checkResponse(result:BaseResult,showMsg:Bool=true,handel:((BaseResponse)->Swift.Void)? = nil){
        switch result {
        case .responseSuccess(let response):
            handel!(response)
            break
        case .responseError(let response): do {
            if showMsg == true {
                if let errorMessage = response.status?.message {
                    if errorMessage == "قيد الاستخدام  plate numberبالفعل" {
                        self.showPopup("رقم اللوحة مستخدم مسبقا")
                    }
                    else if errorMessage == "Not Found" {
                        self.showPopup("There is no data for this email")
                    }
                    else if errorMessage == "العنصر غير موجود" {
                        self.showPopup("لا يوجد اي بيانات للبريد الالكتروني المستخدم")
                    }
                    else if errorMessage == "The package id field is required." {
                        self.showPopup("Your request has been submitted to follow up please call")
                    }
                    else if errorMessage == "الحقل package id مطلوب." {
                        self.showPopup("تم إرسال طلبك للمتابعة ، يرجى الاتصال")
                    }
                    else {
                        if response.status?.codeNumber?.intValue == 203 {
                            if UserProfile.sharedInstance.isRTL() == true {
                                self.showPopup("رقم اللوحة مستخدم مسبقا")
                            }
                            else {
                                self.showPopup("The plate number is already exist")
                            }
                        }
                        else {
                            self.showPopup(errorMessage)
                        }
                    }
                }else{
                    self.showPopup(ResponseHandler.errorMSGDetails)
                }
            }
            break
            }
        case .failure(let opareation,let error): do {
            if error.localizedDescription.count > 0 {
                self.showPopup(error.localizedDescription)
            }else{
                self.showPopup(ResponseHandler.errorMSGDetails)
            }
            break
            }
        case .emptyResponse(): do {
            if showMsg == true {
                self.showPopup(ResponseHandler.errorMSGDetails)
            }
            break
            }
        }
    }
}
