/*************************  *************************/
//
//  URLEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import MobileCoreServices

extension URL {
    func MIMEType() -> String? {
        if !(self.pathExtension.isEmpty) {
            let UTIRef = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.pathExtension as CFString, nil)
            let UTI = UTIRef?.takeUnretainedValue()
            UTIRef?.release()
            
            let MIMETypeRef = UTTypeCopyPreferredTagWithClass(UTI!, kUTTagClassMIMEType)
            if MIMETypeRef != nil
            {
                let MIMEType = MIMETypeRef?.takeUnretainedValue()
                MIMETypeRef?.release()
                return MIMEType! as String
            }
        }
        return nil
    }
}

extension NSURL {
    func MIMEType() -> String? {
        if !((self.pathExtension?.isEmpty)!) {
            let UTIRef = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.pathExtension! as CFString, nil)
            let UTI = UTIRef?.takeUnretainedValue()
            UTIRef?.release()
            
            let MIMETypeRef = UTTypeCopyPreferredTagWithClass(UTI!, kUTTagClassMIMEType)
            if MIMETypeRef != nil
            {
                let MIMEType = MIMETypeRef?.takeUnretainedValue()
                MIMETypeRef?.release()
                return MIMEType! as String
            }
        }
        return nil
    }
}
