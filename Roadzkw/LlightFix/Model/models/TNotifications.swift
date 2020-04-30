/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TNotifications)
public class TNotifications: _TNotifications {
}

@objc(TNotificationsObject)
public class TNotificationsObject: _TNotificationsObject {
}

#elseif canImport(Alamofire)

@objc(TNotificationsObject)
public class TNotificationsObject: _TNotificationsObject {
    var dt_created:NSDate? {
        return self.s_dt_created?.toDate(dateFormat: "yyyy-MM-dd HH:mm:ss") as NSDate?
    }
}

#endif
/*************************  *************************/
