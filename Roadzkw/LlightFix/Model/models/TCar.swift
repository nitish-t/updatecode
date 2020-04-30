/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TCar)
public class TCar: _TCar {
}

@objc(TCarObject)
public class TCarObject: _TCarObject {
}

#elseif canImport(Alamofire)

@objc(TCarObject)
public class TCarObject: _TCarObject {
    var isCellShowAllInfo = false
    
    var s_name : String {
        return "\(self.carMaker?.s_title ?? "") \(self.carModel?.s_title ?? "") \(self.carYear?.s_title ?? "")"
    }
}

#endif
/*************************  *************************/
