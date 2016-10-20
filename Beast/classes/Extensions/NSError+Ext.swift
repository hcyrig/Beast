//
//  NSError+Ext.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import CFNetwork
import Foundation


extension NSError {
    
    func errorDomainRepresentation() -> ErrorProtocol? {
        
        switch domain {
        case NSCocoaErrorDomain:
            return CocoaDomainError(code: code)
        case NSPOSIXErrorDomain:
            return CocoaDomainError(code: code)
        case NSOSStatusErrorDomain:
            return CocoaDomainError(code: code)
        case NSMachErrorDomain:
            return CocoaDomainError(code: code)
        case NSURLErrorDomain:
            return URLDomainError(code: code)
        default:
            return nil
        }
    }
    
    func errorHTTPRepresentation(code:Int) -> ErrorProtocol? {
        return ResponseCodeError(code: code)
    }
    
    
    // MARK: - return int type for http code from a response represantation
    
    func errorCodeHTTPURLResponseObjectKey() -> Int? {
        
        if let response = self.userInfo[BError.HTTPURLResponseObjectKey.rawValue] {
            return (response as AnyObject).statusCode
        }
        return nil
    }
    
    func errorDescrioption() -> String? {
        
        if let errorStr = userInfo[NSLocalizedFailureReasonErrorKey] {
            return errorStr as? String
        }
        if let response = userInfo[BError.HTTPURLResponseObjectKey.rawValue] {
            return "\(errorCodeHTTPURLResponseObjectKey())" + " " + HTTPURLResponse.localizedString(forStatusCode:(response as AnyObject).statusCode)
        }
        return localizedDescription
    }
}

// MARK: - Parse error representation

extension NSError {
    
    func isPoorConectionError() -> Bool {
        
        let codes: Array = [ CFNetworkErrors.cfurlErrorCancelled.rawValue,
                             CFNetworkErrors.cfurlErrorTimedOut.rawValue,
                             CFNetworkErrors.cfurlErrorCancelled.rawValue,
                             CFNetworkErrors.cfurlErrorCannotFindHost.rawValue,
                             CFNetworkErrors.cfurlErrorCannotConnectToHost.rawValue,
                             CFNetworkErrors.cfurlErrorNetworkConnectionLost.rawValue,
                             CFNetworkErrors.cfurlErrorDNSLookupFailed.rawValue,
                             CFNetworkErrors.cfurlErrorResourceUnavailable.rawValue,
                             CFNetworkErrors.cfurlErrorNotConnectedToInternet.rawValue ]
        
        if codes.contains(Int32(self.code)) {
            return true
        }
        return false
    }
}


// MARK: - Parse error JSON representation

extension NSError {
    
    static func processResponseError(JSONObj:AnyObject) -> NSError? {
        
        var error:NSError?
        if let errorDict = JSONObj["error"] as? [String: AnyObject] {
            
            let errorCode = errorDict["code"] as! NSNumber
            let errorMessage = errorDict["message"] as! String
            let errorDescription = "\(errorCode) \(errorMessage)"
            error = NSError(domain: BError.Domain.rawValue,
                            code: -1,
                            userInfo: [NSLocalizedFailureReasonErrorKey: errorDescription])
        }
        else if let errorsDict = JSONObj["errors"] as? [String: AnyObject] {
            
            var errorMessage: String?
            if errorsDict["errors"] != nil &&
                (errorsDict["errors"] as? NSArray) != nil {
                errorMessage = errorsDict["errors"]?.firstObject as! String?
            }
            if errorMessage == nil {
                errorMessage = NSLocalizedString("Unexpected error", comment: "")
            }
            error = NSError(domain: BError.Domain.rawValue,
                            code: -1,
                            userInfo: [NSLocalizedFailureReasonErrorKey: errorMessage!])
        }
        else if let errorsArray = JSONObj["errors"] as? [AnyObject] {
            
            var errorMessage = ""
            for string in errorsArray {
                if let str = string as? NSString {
                    errorMessage += str as String
                }
            }
            if errorMessage.characters.count == 0 {
                errorMessage = NSLocalizedString("Unexpected error", comment: "")
            }
            error = NSError(domain: BError.Domain.rawValue,
                            code: -1,
                            userInfo: [NSLocalizedFailureReasonErrorKey: errorMessage])
        }
        else if let code = JSONObj["code"] as? NSNumber {
            
            if code.intValue > 400 {
                if let errorMessage = JSONObj["message"] {
                    error = NSError(domain: BError.Domain.rawValue,
                                    code: code.intValue,
                                    userInfo: [NSLocalizedFailureReasonErrorKey: "\(errorMessage)"])
                }
            }
            else if let errorMessage = JSONObj["message"] as? NSString {
                error = NSError(domain: BError.Domain.rawValue,
                                code: -1,
                                userInfo: [NSLocalizedFailureReasonErrorKey: errorMessage])
            }
        }
        return error
    }
}
