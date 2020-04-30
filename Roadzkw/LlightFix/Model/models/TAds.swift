/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TAds)
public class TAds: _TAds {
}

@objc(TAdsObject)
public class TAdsObject: _TAdsObject {
}

#elseif canImport(Alamofire)

@objc(TAdsObject)
public class TAdsObject: _TAdsObject {
}

#endif
/*************************  *************************/