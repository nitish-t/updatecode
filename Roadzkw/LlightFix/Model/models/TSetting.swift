/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TSetting)
public class TSetting: _TSetting {
}

@objc(TSettingObject)
public class TSettingObject: _TSettingObject {
}

#elseif canImport(Alamofire)

@objc(TSettingObject)
public class TSettingObject: _TSettingObject {
}

#endif
/*************************  *************************/