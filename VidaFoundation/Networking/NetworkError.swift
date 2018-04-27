//
//  NetworkError.swift
//  Vida
//
//  Created by Brice Pollock on 3/16/18.
//  Copyright © 2018 Vida. All rights reserved.
//

import Foundation

// BRICE: Do we like these types?
public enum NetworkErrorType: Int {
    case error = 800 // general network catchall
    case connection
    case server
    case hydration
    case unexpectedResponse
    case authentication
    case invalidUrl
    case cacheError
    case unknown = 899
}

public class NetworkError: NSError {
    static let messageKey = "networkErrorMessage"
    static let errorDomain = "VAErrorDomain"
    static let responseCodeKey = "HTTPResponseCode"

    let vidaErrorType: NetworkErrorType
    public required init(type: NetworkErrorType, message: String, userInfo: [String: Any] = [:]) {
        vidaErrorType = type
        var infoDict = userInfo
        infoDict[NetworkError.messageKey] = message
        super.init(domain: NetworkError.errorDomain, code: type.rawValue, userInfo: infoDict)
    }

    public convenience init?(responseCode: Int, message: String?, userInfo: [AnyHashable: Any] = [:]) {
        guard responseCode >= 300 else {
            return nil
        }
        self.init(type: .server, message: message ?? "Unknown error.", userInfo: [NetworkError.responseCodeKey: responseCode])
    }

    public convenience init(error: Error) {
        if let networkError = error as? NetworkError {
            self.init(type: networkError.vidaErrorType, message: networkError.failureReason ?? "Unkonwn error", userInfo: networkError.userInfo)
            return
        }
        let nsError = error as NSError
        self.init(type: .connection, message: nsError.userInfo["error"] as? String ?? nsError.localizedDescription, userInfo: nsError.userInfo)
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NetworkError : LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("Network Error", comment: "Error category displayed as title in alert")
    }

    public var failureReason: String? {
        switch vidaErrorType {
        case .invalidUrl: return "Invalid URL."
        case .error, .connection, .server, .hydration, .unexpectedResponse, .authentication, .unknown, .cacheError:
            guard let message = userInfo[NetworkError.messageKey] as? String else {
                return NSLocalizedString("We had some trouble reaching our server.", comment: "Generic error message displayed in alert")
            }
            return message
        }
    }
}
