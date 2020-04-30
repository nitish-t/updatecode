/*************************  *************************/
import Foundation
#if canImport(RestKit)
@objc(TSlider)
public class TSlider: _TSlider {
}

@objc(TSliderObject)
public class TSliderObject: _TSliderObject {
}

#elseif canImport(Alamofire)

@objc(TSliderObject)
public class TSliderObject: _TSliderObject {
}

#endif
/*************************  *************************/