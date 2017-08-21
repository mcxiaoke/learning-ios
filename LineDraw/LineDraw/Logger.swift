//
//  Logger.swift
//  LineDraw
//
//  Created by Xiaoke Zhang on 2017/8/21.
//  Copyright © 2017年 Xiaoke Zhang. All rights reserved.
//
//
//  Logger.swift
//  SwiftLogger
//
//  https://medium.com/@sauvik_dolui/developing-a-tiny-logger-in-swift-7221751628e6
//
//  Created by Sauvik Dolui on 03/05/2017.
//  Copyright © 2016 Innofied Solutions Pvt. Ltd. All rights reserved.
//

import Foundation

// Enum for showing the type of Log Types
enum LogEvent: String {
    case e = "[‼️]" // error
    case w = "[⚠️]" // warning
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case s = "[🔥]" // severe
}

class Logger {
    
    static var level = LogEvent.e
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ss.SSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    class func log(_ message: String,
                   event: LogEvent = .v,
                   fileName: String = #file,
                   line: Int = #line,
                   column: Int = #column,
                   funcName: String = #function) {
        #if DEBUG
            print("\(Date().toString()) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(line)#\(column) \(funcName) -> \(message)")
        #endif
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self)
    }
}
