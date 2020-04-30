/*************************  *************************/
//
//  BaseRequest.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

public enum BaseRequestHTTPMethod: String {
    case get
    case post
    case put
    case delete
}

class BaseRequest: NSObject {
    public var url : String {
        return ""
    }
    public var params : Dictionary<AnyHashable, Any>!{
        return nil
    }
    public var requestObject : Any! {
        return nil
    }
    public var type : BaseRequestHTTPMethod {
        return .get
    }
    public var responseReplacing : Dictionary<String, String>?{
        return nil
    }
    public var multiPartFiles : [BaseRequestFile] {
        return [BaseRequestFile]()
    }
}


class BaseRequestFile: NSObject {
    var fileData: Data
    var parameterName: String
    var fileName: String
    var mimeType: String
    init(fileData: Data, parameterName: String, fileName: String, mimeType: String? = nil) {
        self.fileData = fileData
        self.parameterName = parameterName
        self.fileName = fileName
        self.mimeType = mimeType ?? fileData.mimeType
        super.init()
    }
}
