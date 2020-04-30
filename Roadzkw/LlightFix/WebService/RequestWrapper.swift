/*************************  *************************/
//
//  RequestWrapper.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//


import UIKit
#if canImport(Alamofire)
import Alamofire
#elseif canImport(RestKit)
import RestKit
#endif

class NLRequestWrapper {
    static let sharedInstance = NLRequestWrapper()
    let pagnationInURL = false
    
    func makeRequest(request:BaseRequest) -> RequestOperationBuilder {
        return NLRequestWrapper.builder()
            .url(request.url)
            .params(request.params)
            .method(self.getMethodOfRequest(request))
            .object(request.requestObject)
            .responseReplacing(request.responseReplacing)
            .multiPartFilesSet(request.multiPartFiles)
            .build()
    }
    
    func pagnationRequest(request:BaseRequest,page:Int = 1) -> RequestOperationBuilder {
        let urlWithPagnation = pagnationInURL ? request.url + "/\(GlobalConstants.API_PageSize)" + "/" + "\(page)" : request.url
        var parametars = request.params ?? [:]
        if pagnationInURL == false {
            parametars[GlobalConstants.API_Param_PageNumber] = page
            parametars[GlobalConstants.API_Param_pagesize] = NSNumber(value:GlobalConstants.API_PageSize)
        }
        return NLRequestWrapper.builder()
            .url(urlWithPagnation)
            .params(parametars)
            .method(self.getMethodOfRequest(request))
            .object(request.requestObject)
            .responseReplacing(request.responseReplacing)
            .multiPartFilesSet(request.multiPartFiles)
            .build()
    }
    
    class func builder() -> RequestOperationBuilder {
        return RequestOperationBuilder()
    }
    #if canImport(Alamofire)
    func getMethodOfRequest(_ reqest:BaseRequest) -> HTTPMethod{
        switch reqest.type {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
    #elseif canImport(RestKit)
    func getMethodOfRequest(_ reqest:BaseRequest) -> RKRequestMethod{
        switch reqest.type {
        case .get:
            return .GET
        case .post:
            return .POST
        case .put:
            return .PUT
        case .delete:
            return .DELETE
        }
    }
    #endif
}
