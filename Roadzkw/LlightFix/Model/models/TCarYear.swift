/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TCarYear)
public class TCarYear: _TCarYear {
}

@objc(TCarYearObject)
public class TCarYearObject: _TCarYearObject {
}

#elseif canImport(Alamofire)

@objc(TCarYearObject)
public class TCarYearObject: _TCarYearObject {
}

#endif
/*************************  *************************/