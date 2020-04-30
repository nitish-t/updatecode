/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TSubscription)
public class TSubscription: _TSubscription {
}

@objc(TSubscriptionObject)
public class TSubscriptionObject: _TSubscriptionObject {
}

#elseif canImport(Alamofire)

@objc(TSubscriptionObject)
public class TSubscriptionObject: _TSubscriptionObject {
    var isCellShowAllInfo = true
    var b_active:NSNumber{
        return NSNumber(value:self.s_status?.lowercased() == "active")
    }

}

#endif
/*************************  *************************/
