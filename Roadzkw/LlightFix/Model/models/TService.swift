/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TService)
public class TService: _TService {
}

@objc(TServiceObject)
public class TServiceObject: _TServiceObject {
}

#elseif canImport(Alamofire)

@objc(TServiceObject)
public class TServiceObject: _TServiceObject {
}

#endif
/*************************  *************************/