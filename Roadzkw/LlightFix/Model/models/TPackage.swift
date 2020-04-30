/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TPackage)
public class TPackage: _TPackage {
}

@objc(TPackageObject)
public class TPackageObject: _TPackageObject {
}

#elseif canImport(Alamofire)

@objc(TPackageObject)
public class TPackageObject: _TPackageObject {
    var s_price_ : String {
//        var price = self.s_price ?? "0"
//        if price.contains(".") == false {
//            price = "\(price).0"
//        }
        

        return self.s_price ?? UserProfile.sharedInstance.price// NSNumber(value:Double(price) ?? 0.0).formatedNumber
    }
}

#endif
/*************************  *************************/
