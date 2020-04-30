/*************************  *************************/
//
//  RequestBuilder.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import Foundation
import MBProgressHUD

#if canImport(Alamofire)
import Alamofire
#elseif canImport(RestKit)
import RestKit
#endif

public enum BaseResult{
    case responseSuccess(response:BaseResponse)
    case responseError(response:BaseResponse)
    case emptyResponse()
    #if canImport(Alamofire)
    case failure(operation:DataResponse<Any>?,error:Error)
    #elseif canImport(RestKit)
    case failure(operation:RKObjectRequestOperation,error:Error)
    #endif
}
public class RequestOperationBuilder{
    
    #if canImport(Alamofire)
    var operation: DataRequest?
    var method = HTTPMethod.get;
    var didComplete: ((DataResponse<Any>?, Error?) -> Swift.Void)?
    #elseif canImport(RestKit)
    var operation: RKObjectRequestOperation?
    var method = RKRequestMethod.GET;
    var didComplete: ((RKObjectRequestOperation?, RKMappingResult?, Error?) -> Swift.Void)?
    #endif
    var responseReplacing: Dictionary<String, String>? = nil
    var url: String? = nil
    var params : Dictionary<AnyHashable, Any>!
    var object : Any? = nil
    var beforeSave: ((Any?) -> Any?)?
    var onCompletion: ((BaseResult) -> Swift.Void)?
    var multiPartFiles = [BaseRequestFile]()
    var uploadProgressBlock: ((_ bytesWritten:Int,_ totalBytesWritten:Double,_ totalBytesExpectedToWrite:Double) -> Swift.Void)?

    
    func url(_ url: String) -> RequestOperationBuilder {
        self.url = url.removeWhiteSpaceAndArabicNumbers
        return self
    }
    
    func responseReplacing(_ responseReplacing: Dictionary<String, String>?) -> RequestOperationBuilder {
        self.responseReplacing = responseReplacing
        #if canImport(RestKit)
        self.beforeSaveDeserializedResponse()
        #endif
        return self
    }
    
    func object(_ obj: Any?) -> RequestOperationBuilder {
        self.object = obj
        return self
    }
    #if canImport(Alamofire)
    func method(_ method: HTTPMethod) -> RequestOperationBuilder {
        self.method = method
        return self
    }
    #elseif canImport(RestKit)
    func method(_ method: RKRequestMethod) -> RequestOperationBuilder {
        self.method = method
        return self
    }
    #endif
    
    func params(_ params: Dictionary<AnyHashable, Any>!) -> RequestOperationBuilder {
        #if canImport(Alamofire)
        var parameters : Parameters = [:]
        for dic in params.keys {
            if params[dic] is String {
                parameters[(dic as! String).removeWhiteSpaceAndArabicNumbers] = (params[dic] as! String).removeArabicNumbers
            }else{
                parameters[(dic as! String).removeWhiteSpaceAndArabicNumbers] = params[dic]
            }
        }
        self.params = parameters
        return self
        #elseif canImport(RestKit)
        var parameters : Dictionary<AnyHashable, Any> = [:]
        for dic in params.keys {
            if params[dic] is String {
                parameters[(dic as! String).removeWhiteSpaceAndArabicNumbers] = (params[dic] as! String).removeArabicNumbers
            }else{
                parameters[(dic as! String).removeWhiteSpaceAndArabicNumbers] = params[dic]
            }
        }
        self.params = parameters
        return self
        #endif
    }
    
    
    func param(_ key: String, _ value: Any) -> RequestOperationBuilder {
        if value is String {
            self.params[key.removeWhiteSpaceAndArabicNumbers] = (value as! String).removeArabicNumbers
        }else{
            self.params[key.removeWhiteSpaceAndArabicNumbers] = value
        }
        return self
    }
    func multiPartFilesSet(_ multiPartFiles: [BaseRequestFile]) -> RequestOperationBuilder {
        self.multiPartFiles = multiPartFiles
        return self
    }
    func beforeSave(_ block: ((Any?) -> Any?)!) -> RequestOperationBuilder {
        beforeSave = block
        #if canImport(RestKit)
        self.beforeSaveDeserializedResponse()
        #endif
        return self
    }
    #if canImport(Alamofire)
    func didComplete(_ block: ((DataResponse<Any>?, Error?) -> Swift.Void)!) -> RequestOperationBuilder {
        didComplete = block
        return self
    }
    #elseif canImport(RestKit)
    func didComplete(_ block: ((RKObjectRequestOperation?, RKMappingResult?, Error?) -> Swift.Void)!) -> RequestOperationBuilder {
        didComplete = block
        return self
    }
    #endif
    func uploadProgressBlockFunc(_ block: ((_ bytesWritten:Int,_ totalBytesWritten:Double,_ totalBytesExpectedToWrite:Double) -> Swift.Void)?) -> RequestOperationBuilder {
        uploadProgressBlock = block
        return self
    }
    #if canImport(Alamofire)
    func alamofireResponseData(_ response:DataResponse<Any>){
        self.showHideLoaderView(showLoader: false)
        switch response.result {
        case .success(let data):
            if data is NSDictionary {
                let responseJson = BaseResponse(data as! NSDictionary)
                if (responseJson.status?.codeNumber?.intValue != 206 && (response.request?.url?.absoluteString.contains(GlobalConstants.API_Subscriptions_check_subscription_Controller) == true || response.request?.url?.absoluteString.contains(GlobalConstants.API_Subscriptions_check_payment_Controller) == true ||
                    response.request?.url?.absoluteString.contains(GlobalConstants.API_User_check_register_data_Controller) == true || responseJson.status?.success?.boolValue == true)) {
                    self.onCompletion!(BaseResult.responseSuccess(response: responseJson))
                }else{
                    self.onCompletion!(BaseResult.responseError(response: responseJson))
                }
            }else {
                self.onCompletion!(BaseResult.emptyResponse())
            }
            break
        case .failure(_):
            self.onCompletion!(BaseResult.failure(operation: response, error: response.error!))
            break
        }
        self.didComplete?(response,response.error)
        debugPrint(response)
    }
    #endif
    public func build() -> RequestOperationBuilder {
        #if canImport(Alamofire)
        if self.multiPartFiles.count > 0 {
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    for file in self.multiPartFiles {
                        multipartFormData.append(file.fileData, withName: file.parameterName, fileName: file.fileName, mimeType: file.mimeType)
                    }
                    for (key, value) in self.params {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key as! String)
                    }
            },
                to: GlobalConstants.APIUrl + url!,
                method:method,
                headers:BaseModel.sharedInstance.requestsHeadrs(),
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        self.operation = upload
                        upload.uploadProgress(queue: DispatchQueue.main, closure: { (progress) in
                            print("Upload Progress: \(progress.fractionCompleted)")
                        })
                        upload.responseJSON { response in
                            self.alamofireResponseData(response)
                            }.uploadProgress { progress in // main queue by default
                                print("Upload Progress: \(progress.fractionCompleted)")
                            }.downloadProgress { progress in
                                print("Download progress: \(progress.fractionCompleted)")
                            }.uploadProgress(closure: { (progress) in
                                print("Upload Progress: \(progress.fractionCompleted)")
                            }).validate(contentType: ["application/json"])
                    case .failure(let encodingError):
                        print(encodingError)
                        self.onCompletion!(BaseResult.failure(operation: nil, error: encodingError))
                    }
            })
            
        }else{
            operation = Alamofire.request(GlobalConstants.APIUrl + url!, method: method, parameters: (params as! Parameters), headers:BaseModel.sharedInstance.requestsHeadrs()).validate(contentType: ["application/json"])
            operation?.responseJSON(completionHandler: { (response) in
                self.alamofireResponseData(response)
            })
        }
        return self
        #elseif canImport(RestKit)
        if self.multiPartFiles.count > 0 {
            let request = RKObjectManager.shared()?.multipartFormRequest(with: object, method: method, path: url, parameters: params, constructingBodyWith: {(_ formData: AFRKMultipartFormData!) -> Void in
                for file in self.multiPartFiles {
                    formData.appendPart(withFileData: file.fileData, name: file.parameterName, fileName: file.fileName, mimeType: file.mimeType)
                }
            })
            operation = RKObjectManager.shared().managedObjectRequestOperation(with: request! as URLRequest, managedObjectContext: NSManagedObjectContext.mr_default(), success: nil, failure: nil)
        }else{
            operation = RKObjectManager
                .shared()
                .appropriateObjectRequestOperation(with: object,
                                                   method: method,
                                                   path: url,
                                                   parameters: params)
                as? RKObjectRequestOperation
        }        
        
        operation?.setCompletionBlockWithSuccess({ (op, mp) in
            self.showHideLoaderView(showLoader: false)
            let response = mp?.array().first as? BaseResponse
            
            self.didComplete?(op,mp,nil)
            if(response==nil){
                self.onCompletion!(BaseResult.emptyResponse())
                return
            }
            
            if (response?.status?.success?.boolValue == true) {
                self.onCompletion!(BaseResult.responseSuccess(response: response!))
                return
            } else {
                self.onCompletion!(BaseResult.responseError(response: response!))
                return
            }
        }, failure: { (op, er) in
            self.showHideLoaderView(showLoader: false)
            self.onCompletion!(BaseResult.failure(operation: op!,error: er!))
            self.didComplete?(op,nil,er)
        })
        
        operation?.httpRequestOperation?.setUploadProgressBlock({ (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
            self.uploadProgressBlock?(Int(bytesWritten), Double(totalBytesWritten), Double(totalBytesExpectedToWrite))
        })
        
        return self
        #endif
    }
    
    #if canImport(RestKit)
    func beforeSaveDeserializedResponse() {
        if self.responseReplacing != nil {
            operation?.setWillMapDeserializedResponseBlock({ (json) -> Any? in
                var jsonNew : NSMutableDictionary = [:]
                if json is NSDictionary {
                    for keySTR in (json as! NSDictionary).allKeys{
                        for keyResponseSTR in (self.responseReplacing! as NSDictionary).allKeys{
                            if (keySTR as! String) == (keyResponseSTR as! String) {
                                jsonNew[self.responseReplacing![(keyResponseSTR as! String)]!] = (json as! NSDictionary)[(keySTR as! String)]
                            }else{
                                jsonNew[(keySTR as! String)] = (json as! NSDictionary)[(keySTR as! String)]
                            }
                        }
                    }
                }
                if (self.beforeSave != nil) {
                    jsonNew = self.beforeSave!(json) as! NSMutableDictionary
                }
                return jsonNew
            })
        }else if beforeSave != nil{
            operation?.setWillMapDeserializedResponseBlock(beforeSave)
        }
    }
    #endif
    
    #if canImport(Alamofire)
    func execute(showLodaer:Bool, _ block: ((BaseResult) ->Swift.Void)?={r in }) ->DataRequest?  {
        onCompletion = block
        if showLodaer == true {
            self.showHideLoaderView(showLoader: showLodaer)
        }
        return operation
    }
    func executeWithCheckResponse(showLodaer:Bool,showMsg: Bool, _ block: ((BaseResponse) ->Swift.Void)?={r in }) ->DataRequest?  {
        return self.execute(showLodaer: showLodaer) { (result) in
            ResponseHandler.checkResponse(result: result, showMsg: showMsg, handel: { (response) in
                block!(response)
            })
        }
    }
    #elseif canImport(RestKit)
    func execute(showLodaer:Bool, _ block: ((BaseResult) ->Swift.Void)?={r in }) ->RKObjectRequestOperation?  {
        onCompletion = block
        if showLodaer == true {
            self.showHideLoaderView(showLoader: showLodaer)
        }
        RKObjectManager.shared().enqueue(operation)
        return operation
    }
    func executeWithCheckResponse(showLodaer:Bool,showMsg: Bool, _ block: ((BaseResponse) ->Swift.Void)?={r in }) ->RKObjectRequestOperation?  {
        return self.execute(showLodaer: showLodaer) { (result) in
            ResponseHandler.checkResponse(result: result, showMsg: showMsg, handel: { (response) in
                block!(response)
            })
        }
    }
    #endif
    
    func showHideLoaderView(showLoader:Bool) {
        if showLoader {
            MBProgressHUD.showAdded(to: UIApplication.topViewController_()?.view, animated: true)
        }else{
            MBProgressHUD.hide(for: UIApplication.topViewController_()?.view, animated: true)
        }
    }
}
