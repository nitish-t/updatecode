/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TCarModel)
public class TCarModel: _TCarModel {
}

@objc(TCarModelObject)
public class TCarModelObject: _TCarModelObject {
}

#elseif canImport(Alamofire)

@objc(TCarModelObject)
public class TCarModelObject: _TCarModelObject {
}

#endif
/*************************  *************************/