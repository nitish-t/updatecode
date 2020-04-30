/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TCopon)
public class TCopon: _TCopon {
}

@objc(TCoponObject)
public class TCoponObject: _TCoponObject {
}

#elseif canImport(Alamofire)

@objc(TCoponObject)
public class TCoponObject: _TCoponObject {
}

#endif
/*************************  *************************/