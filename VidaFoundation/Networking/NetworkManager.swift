//
//  NetworkManager.swift
//  VidaFoundation
//
//  Created by Brice Pollock on 4/18/18.
//  Copyright © 2018 Vida Health. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

fileprivate struct AlamofireRequest: URLRequestConvertible {
    let request: NSMutableURLRequest
    func asURLRequest() throws -> URLRequest {
        return request as URLRequest
    }
}

// Naming as defined by standard URL definition:
// https://www.ibm.com/support/knowledgecenter/en/SSGMCP_5.1.0/com.ibm.cics.ts.internet.doc/topics/dfhtl_uricomp.html
struct NetworkManager {
    public static let scheme = "https"
    public static let host = "vida-todo-sample.herokuapp.com"

    internal func jsonFromData(_ data: Data) -> [AnyHashable: Any]? {
        // there are many valid cases where empty data is acceptable in a 200 such as POST or DELETE requests.
        // We return empty here since a data object does exist, but it just isn't seriailzable because its empty
        guard data.count > 0 else {
            return [:]
        }

        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let json = json as? Array<Any> {
                return ["objects": json]
            } else if let json = json as? [AnyHashable: Any] {
                return json
            } else {
                // I tried hard to make this fail here, I don't think its possible that JSONSerialization will ever return a non-collection.
                return nil
            }
        } catch {
            errorLog("Error Thrown while unpacking json: \(error.localizedDescription)")
            return nil
        }
    }

    internal func checkJSONForErrors(json: [AnyHashable: Any]) -> NetworkError? {
        let errorKeys = ["error", "error_message"]
        for key in errorKeys {
            if let dictError = json[key] {
                guard let errorMessage = dictError as? String else {
                    let message = "Request returned error in dictionary not as string: \(dictError)"
                    errorLog(message)
                    return NetworkError(type: .unexpectedResponse, message: message)
                }
                return NetworkError(type: .unexpectedResponse, message: errorMessage)
            }
        }
        return nil
    }

    func request(_ request: NSMutableURLRequest) -> Observable<Result<[AnyHashable: Any]>> {
        return Observable.create { observer in
            SessionManager.default.request(AlamofireRequest(request: request)).responseData { response in
                let responseCode = response.response?.statusCode ?? NetworkErrorType.unknown.rawValue
                if let error = response.result.error {
                    observer.onNext(Result.error(error))
                    return
                }

                guard response.result.isSuccess, let data = response.result.value else {
                    observer.onNext(Result.error(NetworkError(type: .server, message: "failed response", userInfo: ["responseCode": responseCode])))
                    return
                }

                // check for statusCode errors
                if let error = NetworkError(responseCode: responseCode, message: "response code error") {
                    errorLog("Server reports issue (\(responseCode)) for: \(String(describing: response.response?.url))\n result:\n\(String(describing: response.result))")
                    observer.onNext(Result.error(error))
                    return
                }

                guard let json = self.jsonFromData(data) else {
                    let message = "Unable to unpack json object for \(String(describing: response.response?.url))"
                    errorLog(message)
                    observer.onNext(Result.error(NetworkError(type: .hydration, message:  message)))
                    return
                }

                if let error = self.checkJSONForErrors(json: json) {
                    observer.onNext(Result.error(error))
                    return
                }

                // TODO: Do an auto-serialization
                observer.onNext(Result.value(json))
                return 
            }
            return Disposables.create()
        }
    }
}
