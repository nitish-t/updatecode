/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TUser)
public class TUser: _TUser {
}

@objc(TUserObject)
public class TUserObject: _TUserObject {
}

#elseif canImport(Alamofire)

@objc(TUserObject)
public class TUserObject: _TUserObject {
}

#endif
/*************************  *************************/