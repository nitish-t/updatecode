/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TCarMaker)
public class TCarMaker: _TCarMaker {
}

@objc(TCarMakerObject)
public class TCarMakerObject: _TCarMakerObject {
}

#elseif canImport(Alamofire)

@objc(TCarMakerObject)
public class TCarMakerObject: _TCarMakerObject {
}

#endif
/*************************  *************************/