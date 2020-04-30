/*************************  *************************/
//
//  NSDateEx.swift
//  LlightFix
//
//  Created by  on 6/26/19.
//  Copyright © 2019 LightFix iCode. All rights reserved.
//

import UIKit

extension NSDate {
    static let appTimeZone = TimeZone(abbreviation:"GMT") // "Asia/Riyadh"
    
    func dateStringWithDateOnly() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en-us") as Locale
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
        dateFormatter.timeZone = NSDate.appTimeZone
        return dateFormatter.string(from: self as Date)
    }
    func dateStringWithDateOnlyForApi() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en-us") as Locale
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
        dateFormatter.timeZone = NSDate.appTimeZone
        return dateFormatter.string(from: self as Date)
    }
    func dateStringWithDateTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm:ss a"
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en-us") as Locale
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
        dateFormatter.timeZone = NSDate.appTimeZone
        return dateFormatter.string(from: self as Date)
    }
    func dateString(customFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = customFormat
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en-us") as Locale
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
        dateFormatter.timeZone = NSDate.appTimeZone
        return dateFormatter.string(from: self as Date)
    }
    static var commonDateFormatter : DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en-us") as Locale
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
        dateFormatter.timeZone = NSDate.appTimeZone
        return dateFormatter
    }
    func lastDayOfMonth() -> NSDate {
        let calendar = NSCalendar.current
        let dayRange = calendar.range(of: .day, in: .month, for: self as Date)
        let dayCount = dayRange?.count
        var comp = calendar.dateComponents([.year, .month, .day], from: self as Date)
        comp.day = dayCount
        return calendar.date(from: comp)! as NSDate
    }
    func firstDayOfMonth() -> NSDate {
        let calendar = NSCalendar.current
        var comp = calendar.dateComponents([.year, .month, .day], from: self as Date)
        comp.day = 1
        return calendar.date(from: comp)! as NSDate
    }
    
    static var mapperDateFormatter : DateFormatter{
        //"Dont Change or remove this function"
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.init(localeIdentifier: "en-us") as Locale
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
        dateFormatter.timeZone = NSDate.appTimeZone
        return dateFormatter
    }
}
