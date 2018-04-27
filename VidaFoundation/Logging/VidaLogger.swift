//
//  VidaLogger.swift
//  Vida
//
//  Created by Brice Pollock on 3/8/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

// Inspired by TinyLogger
// https://medium.com/@sauvik_dolui/developing-a-tiny-logger-in-swift-7221751628e6

enum LogEvent: String {
    case verbose = "[ℹ️]"
    case debug = "[💬]"
    case warning = "[⚠️]"
    case error = "[‼️]"
    case fatal = "[🔥]"

    func level() -> Int {
        switch self {
        case .verbose: return 0
        case .debug: return 1
        case .warning: return 2
        case .error: return 3
        case .fatal: return 4
        }
    }
}

// TODO: some way at runtime to change this (dev settings? in profile)
struct VidaLogger {
    public static let shared = VidaLogger()
    private let currentLogLevel = LogEvent.debug
    fileprivate let logDateFormat = "MM/dd hh:mm:ssSS"
    internal var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = self.logDateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    internal func sourceFileName(filePath: String) -> String {
        return filePath.components(separatedBy: "/").last ?? ""
    }

    internal func composeLog(usingMessage message: String,
                             event: LogEvent,
                             date: Date = Date(),
                             fileName: String = #file,
                             line: Int = #line,
                             funcName: String = #function) -> String {
        return "\(formatter.string(from: date)) \(event.rawValue)[\(sourceFileName(filePath: fileName)):\(line) \(funcName)]: \(message)"
    }

    internal func log(message: String,
                      event: LogEvent,
                      fileName: String = #file,
                      line: Int = #line,
                      funcName: String = #function) {
        #if DEBUG
            guard event.level() >= self.currentLogLevel.level() else { return }
            print(composeLog(usingMessage: message,
                             event: event,
                             fileName: fileName,
                             line: line,
                             funcName: funcName))
        #endif
    }
}

// MARK - public API
// Writing Objective-C code?
// Use 'DebugLog(@"some typical string %@", error.localizedDescription)'
public func verboseLog(_ message: String,
                       fileName: String = #file,
                       line: Int = #line,
                       funcName: String = #function) {
    VidaLogger.shared.log(message: message,
                   event: .verbose,
                   fileName: fileName,
                   line: line,
                   funcName: funcName)
}
public func debugLog(_ message: String,
                     fileName: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
    VidaLogger.shared.log(message: message,
                   event: .debug,
                   fileName: fileName,
                   line: line,
                   funcName: funcName)

}
public func warningLog(_ message: String,
                       fileName: String = #file,
                       line: Int = #line,
                       funcName: String = #function) {
    VidaLogger.shared.log(message: message,
                   event: .warning,
                   fileName: fileName,
                   line: line,
                   funcName: funcName)
}
public func errorLog(_ message: String,
                     fileName: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
    VidaLogger.shared.log(message: message,
                   event: .error,
                   fileName: fileName,
                   line: line,
                   funcName: funcName)
}
public func errorLog(_ error: Error,
                     fileName: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
    VidaLogger.shared.log(message: error.localizedDescription,
                   event: .error,
                   fileName: fileName,
                   line: line,
                   funcName: funcName)

}
// This is the only log that will auto-submit an issue to crashlytics.
public func fatalLog(_ error: Error,
                     fileName: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
    VidaLogger.shared.log(message: error.localizedDescription,
                   event: .fatal,
                   fileName: fileName,
                   line: line,
                   funcName: funcName)
}
public func fatalLog(_ message: String,
                     fileName: String = #file,
                     line: Int = #line,
                     funcName: String = #function) {
    let error = NSError(domain: "com.vida", code: 999, userInfo: [
        "error": message,
        "file": fileName,
        "line": line,
        "function": funcName
        ]
    )
    fatalLog(error)
}
