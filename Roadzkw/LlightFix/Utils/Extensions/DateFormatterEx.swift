//
//  DateFormatterEx.swift
//  LlightFix
//
//  Created by  on 7/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

extension DateFormatter {
    enum DateFormatStyle: String {
        
        case dayMonthYear = "dd MMM yyyy"
        case hourMinAMPM = "hh:mm a"
        case hourMinSec = "hh:mm:ss"
        
        case meridiem = "a"
        
        case isoTimeZone = "ZZZZZ"//-06:00 /ISO 8601 time zone format
        case timeZone = "zzz"//CST /The 3 letter name of the time zone. Falls back to GMT-08:00 (hour offset) if the name is not known.
        
        case shordDayName = "E"
        case fullDayName = "EEEE"
        
        case dayWithZeroPading = "d"
        case day = "dd"
        
        case monthDigitWithoutZeroPading = "M"
        case monthDigitWithZeroPading = "MM"
        case shortMonthName = "MMM"
        case fullMonthName = "MMMM"
        case monthInitial = "MMMMM"
        
        case yearWithZeroPading = "y"
        case year = "yy"
        case fourDigitYear = "yyyy"
        
        case hour12WithoutZeroPading = "h"
        case hour12 = "hh"
        case hour24WithoutZeroPading = "H"
        case hour24 = "HH"
        
        case minsWithoutZeroPading = "m"
        case mins = "mm"
        
        case secondsWithZeroPading = "ss"
        case seconds = "s"
        
        case milliseconds = "SSS"
        
        static func unified(by saperator:String, OfStyles styles: DateFormatStyle...) -> String {
            return styles.map{$0.rawValue}.joined(separator: saperator)
        }
        static func unified(by saperator:String) -> [String] {
            if let arr = UserDefaults.standard.value(forKey: "DateFormatter.DateFormatStyle.AllFormats") {
                return arr as! [String]
            }
            var final = [String]()
            let times = [
                DateFormatStyle.unified(by: ":", OfStyles: .hour12,.mins,.seconds),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24,.mins,.seconds),
                DateFormatStyle.unified(by: ":", OfStyles: .hour12WithoutZeroPading,.mins,.seconds),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24WithoutZeroPading,.mins,.seconds),
                
                DateFormatStyle.unified(by: ":", OfStyles: .hour12,.minsWithoutZeroPading,.seconds),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24,.minsWithoutZeroPading,.seconds),
                DateFormatStyle.unified(by: ":", OfStyles: .hour12WithoutZeroPading,.minsWithoutZeroPading,.seconds),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24WithoutZeroPading,.minsWithoutZeroPading,.seconds),
                
                DateFormatStyle.unified(by: ":", OfStyles: .hour12,.mins,.secondsWithZeroPading),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24,.mins,.secondsWithZeroPading),
                DateFormatStyle.unified(by: ":", OfStyles: .hour12WithoutZeroPading,.mins,.secondsWithZeroPading),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24WithoutZeroPading,.mins,.secondsWithZeroPading),
                
                DateFormatStyle.unified(by: ":", OfStyles: .hour12,.minsWithoutZeroPading,.secondsWithZeroPading),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24,.minsWithoutZeroPading,.secondsWithZeroPading),
                DateFormatStyle.unified(by: ":", OfStyles: .hour12WithoutZeroPading,.minsWithoutZeroPading,.secondsWithZeroPading),
                DateFormatStyle.unified(by: ":", OfStyles: .hour24WithoutZeroPading,.minsWithoutZeroPading,.secondsWithZeroPading),
            ]
            let dates = [
                DateFormatStyle.unified(by: saperator, OfStyles: .fourDigitYear,.monthDigitWithZeroPading,.day),
                DateFormatStyle.unified(by: saperator, OfStyles: .fourDigitYear,.day,.monthDigitWithZeroPading),
                
                DateFormatStyle.unified(by: saperator, OfStyles: .monthDigitWithZeroPading,.day,.fourDigitYear),
                DateFormatStyle.unified(by: saperator, OfStyles: .monthDigitWithZeroPading,.fourDigitYear,.day),
                
                DateFormatStyle.unified(by: saperator, OfStyles: .day,.fourDigitYear,.monthDigitWithZeroPading),
                DateFormatStyle.unified(by: saperator, OfStyles: .day,.monthDigitWithZeroPading,.fourDigitYear),
            ]
            final.append(contentsOf: times)
            final.append(contentsOf: dates)
            
            for dt in dates {
                for tm in times {
                    final.append("\(dt) \(tm)")
                    final.append("\(dt)'T'\(tm)")
                    final.append("\(dt) \(tm).\(DateFormatStyle.milliseconds.rawValue)")
                    final.append("\(dt)'T'\(tm).\(DateFormatStyle.milliseconds.rawValue)")
                    
                    final.append("\(dt) \(tm) \(DateFormatStyle.timeZone.rawValue)")
                    final.append("\(dt)'T'\(tm) \(DateFormatStyle.timeZone.rawValue)")
                    final.append("\(dt) \(tm).\(DateFormatStyle.milliseconds.rawValue) \(DateFormatStyle.timeZone.rawValue)")
                    final.append("\(dt)'T'\(tm).\(DateFormatStyle.milliseconds.rawValue) \(DateFormatStyle.timeZone.rawValue)")
                    
                    final.append("\(dt) \(tm) '\(DateFormatStyle.timeZone.rawValue)'")
                    final.append("\(dt)'T'\(tm) '\(DateFormatStyle.timeZone.rawValue)'")
                    final.append("\(dt) \(tm).\(DateFormatStyle.milliseconds.rawValue) '\(DateFormatStyle.timeZone.rawValue)'")
                    final.append("\(dt)'T'\(tm).\(DateFormatStyle.milliseconds.rawValue) '\(DateFormatStyle.timeZone.rawValue)'")
                    
                    final.append("\(dt) \(tm) \(DateFormatStyle.meridiem.rawValue)")
                    final.append("\(dt)'T'\(tm) \(DateFormatStyle.meridiem.rawValue)")
                    final.append("\(dt) \(tm).\(DateFormatStyle.milliseconds.rawValue) \(DateFormatStyle.meridiem)")
                    final.append("\(dt)'T'\(tm).\(DateFormatStyle.milliseconds.rawValue) \(DateFormatStyle.meridiem.rawValue)")
                    
                    final.append("\(dt) \(tm) \(DateFormatStyle.meridiem.rawValue) \(DateFormatStyle.timeZone.rawValue)")
                    final.append("\(dt)'T'\(tm) \(DateFormatStyle.meridiem) \(DateFormatStyle.timeZone.rawValue)")
                    final.append("\(dt) \(tm).\(DateFormatStyle.milliseconds.rawValue) \(DateFormatStyle.meridiem.rawValue) \(DateFormatStyle.timeZone.rawValue)")
                    final.append("\(dt)'T'\(tm).\(DateFormatStyle.milliseconds.rawValue) \(DateFormatStyle.meridiem.rawValue) \(DateFormatStyle.timeZone.rawValue)")
                }
            }
            
            UserDefaults.standard.setValue(final, forKey: "DateFormatter.DateFormatStyle.AllFormats")
            UserDefaults.standard.synchronize()
            
            return final
        }
    }
    
    func formats(fromString dateString: String?) -> NSDate? {
        var formats: [String] = [
            //Custom Format
            //"",
        ]
        formats.append(contentsOf: DateFormatStyle.unified(by: "-"))
        formats.append(contentsOf: DateFormatStyle.unified(by: "/"))
        formats.append(contentsOf: DateFormatStyle.unified(by: " "))
        formats.append(contentsOf: DateFormatStyle.unified(by: ""))
        if let str = dateString {
            for format in formats {
                self.dateFormat = format
                if let date = self.date(from: str) {
                    return date as NSDate
                }
            }
        }
        return nil
    }
}
