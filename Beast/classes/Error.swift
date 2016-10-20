//
//  Error.swift
//  Beast
//
//  Created by Kostiantyn Girych on 10/20/16.
//  Copyright © 2016 hcyrig. All rights reserved.
//

import Foundation


enum BError:String {
    case Domain = "com.beast.domain"
    case HTTPURLResponseObjectKey =  "HTTPURLResponseObjectKey"
}


// MARK: - There is error protocol for any codes representation enums

protocol ErrorProtocol {
    
    
    // MARK: -  the error code identificator
    
    func code() -> Int
    
    
    // MARK: -  the key associated with code identificator
    
    func key() -> String
    
    
    // MARK: -  a custom user information about identificator (may be like a message for additional debug information)
    
    func info() -> String?
}


// MARK: - NSCocoaDomainError codes representation keys

enum CocoaDomainError:ErrorProtocol {
    
    case error(Int, String, String?)
    
    func code() -> Int {
        
        switch self {
        case let .error(code, _, _):
            return code
        }
    }
    
    func key() -> String {
        
        switch self {
        case let .error(_, key, _):
            return key
        }
    }
    
    func info() -> String? {
        
        switch self {
        case let .error(_, _, info):
            return info
        }
    }
    
    init(code:Int, info:String? = nil) {
        
        var errorKey = "Unknown key"
        switch code {
        case NSFileNoSuchFileError: errorKey = "NSFileNoSuchFileError"
        case NSFileLockingError: errorKey = "NSFileLockingError"
        case NSFileReadUnknownError: errorKey = "NSFileReadUnknownError"
        case NSFileReadNoPermissionError: errorKey = "NSFileReadNoPermissionError"
        case NSFileReadInvalidFileNameError: errorKey = "NSFileReadInvalidFileNameError"
        case NSFileReadCorruptFileError: errorKey = "NSFileReadCorruptFileError"
        case NSFileReadNoSuchFileError: errorKey = "NSFileReadNoSuchFileError"
        case NSFileReadInapplicableStringEncodingError: errorKey = "NSFileReadInapplicableStringEncodingError"
        case NSFileReadUnsupportedSchemeError: errorKey = "NSFileReadUnsupportedSchemeError"
        case NSFileReadTooLargeError: errorKey = "NSFileReadTooLargeError"
        case NSFileReadUnknownStringEncodingError: errorKey = "NSFileReadUnknownStringEncodingError"
        case NSFileWriteUnknownError: errorKey = "NSFileWriteUnknownError"
        case NSFileWriteNoPermissionError: errorKey = "NSFileWriteNoPermissionError"
        case NSFileWriteInvalidFileNameError: errorKey = "NSFileWriteInvalidFileNameError"
        case NSFileWriteFileExistsError: errorKey = "NSFileWriteFileExistsError"
        case NSFileWriteInapplicableStringEncodingError: errorKey = "NSFileWriteInapplicableStringEncodingError"
        case NSFileWriteUnsupportedSchemeError: errorKey = "NSFileWriteUnsupportedSchemeError"
        case NSFileWriteOutOfSpaceError: errorKey = "NSFileWriteOutOfSpaceError"
        case NSFileWriteVolumeReadOnlyError: errorKey = "NSFileWriteVolumeReadOnlyError"
        case NSKeyValueValidationError: errorKey = "NSKeyValueValidationError"
        case NSFormattingError: errorKey = "NSFormattingError"
        case NSUserCancelledError: errorKey = "NSUserCancelledError"
        case NSFeatureUnsupportedError: errorKey = "NSFeatureUnsupportedError"
        case NSExecutableNotLoadableError: errorKey = "NSExecutableNotLoadableError"
        case NSExecutableArchitectureMismatchError: errorKey = "NSExecutableArchitectureMismatchError"
        case NSExecutableRuntimeMismatchError: errorKey = "NSExecutableRuntimeMismatchError"
        case NSExecutableLoadError: errorKey = "NSExecutableLoadError"
        case NSExecutableLinkError: errorKey = "NSExecutableLinkError"
        case NSFileErrorMinimum: errorKey = "NSFileErrorMinimum"
        case NSFileErrorMaximum: errorKey = "NSFileErrorMaximum"
        case NSValidationErrorMinimum: errorKey = "NSValidationErrorMinimum"
        case NSValidationErrorMaximum: errorKey = "NSValidationErrorMaximum"
        case NSExecutableErrorMinimum: errorKey = "NSExecutableErrorMinimum"
        case NSExecutableErrorMaximum: errorKey = "NSExecutableErrorMaximum"
        case NSFormattingErrorMinimum: errorKey = "NSFormattingErrorMinimum"
        case NSFormattingErrorMaximum: errorKey = "NSFormattingErrorMaximum"
        case NSPropertyListReadCorruptError: errorKey = "NSPropertyListReadCorruptError"
        case NSPropertyListReadUnknownVersionError: errorKey = "NSPropertyListReadUnknownVersionError"
        case NSPropertyListReadStreamError: errorKey = "NSPropertyListReadStreamError"
        case NSPropertyListWriteStreamError: errorKey = "NSPropertyListWriteStreamError"
        case NSPropertyListWriteInvalidError: errorKey = "NSPropertyListWriteInvalidError"
        case NSPropertyListErrorMinimum: errorKey = "NSPropertyListErrorMinimum"
        case NSPropertyListErrorMaximum: errorKey = "NSPropertyListErrorMaximum"
        case NSXPCConnectionInterrupted: errorKey = "NSXPCConnectionInterrupted"
        case NSXPCConnectionInvalid: errorKey = "NSXPCConnectionInvalid"
        case NSXPCConnectionReplyInvalid: errorKey = "NSXPCConnectionReplyInvalid"
        case NSXPCConnectionErrorMinimum: errorKey = "NSXPCConnectionErrorMinimum"
        case NSXPCConnectionErrorMaximum: errorKey = "NSXPCConnectionErrorMaximum"
        case NSUbiquitousFileUnavailableError: errorKey = "NSUbiquitousFileUnavailableError"
        case NSUbiquitousFileNotUploadedDueToQuotaError: errorKey = "NSUbiquitousFileNotUploadedDueToQuotaError"
        case NSUbiquitousFileUbiquityServerNotAvailable: errorKey = "NSUbiquitousFileUbiquityServerNotAvailable"
        case NSUbiquitousFileErrorMinimum: errorKey = "NSUbiquitousFileErrorMinimum"
        case NSUbiquitousFileErrorMaximum: errorKey = "NSUbiquitousFileErrorMaximum"
        case NSUserActivityHandoffFailedError: errorKey = "NSUserActivityHandoffFailedError"
        case NSUserActivityConnectionUnavailableError: errorKey = "NSUserActivityConnectionUnavailableError"
        case NSUserActivityRemoteApplicationTimedOutError: errorKey = "NSUserActivityRemoteApplicationTimedOutError"
        case NSUserActivityHandoffUserInfoTooLargeError: errorKey = "NSUserActivityHandoffUserInfoTooLargeError"
        case NSUserActivityErrorMinimum: errorKey = "NSUserActivityErrorMinimum"
        case NSUserActivityErrorMaximum: errorKey = "NSUserActivityErrorMaximum"
        default:
            if #available(iOS 9, *) {
                
                switch code {
                case NSCoderReadCorruptError: errorKey = "NSCoderReadCorruptError"
                case NSCoderValueNotFoundError: errorKey = "NSCoderValueNotFoundError"
                case NSCoderErrorMinimum: errorKey = "NSCoderErrorMinimum"
                case NSCoderErrorMaximum: errorKey = "NSCoderErrorMaximum"
                case NSBundleErrorMinimum: errorKey = "NSBundleErrorMinimum"
                case NSBundleErrorMaximum: errorKey = "NSBundleErrorMaximum"
                case NSBundleOnDemandResourceOutOfSpaceError: errorKey = "NSBundleOnDemandResourceOutOfSpaceError"
                case NSBundleOnDemandResourceExceededMaximumSizeError: errorKey = "NSBundleOnDemandResourceExceededMaximumSizeError"
                case NSBundleOnDemandResourceInvalidTagError: errorKey = "NSBundleOnDemandResourceInvalidTagError"
                default: break
                }
            }
        }
        self = CocoaDomainError.error(code, errorKey, info)
    }
}


// MARK: - NSURLDomainError codes representation keys

enum URLDomainError:ErrorProtocol {
    
    case error(code:Int, key:String, info:String?)
    
    func code() -> Int {
        
        switch self{
        case let .error(code, _, _):
            return code
        }
    }
    
    func key() -> String {
        
        switch self{
        case let .error(_, key, _):
            return key
        }
    }
    
    func info() -> String? {
        
        switch self {
        case let .error(_, _, info):
            return info
        }
    }
    
    init(code:Int, info:String? = nil) {
        
        var errorKey = "Unknown key"
        switch code {
        case NSURLErrorUnknown: errorKey = "NSURLErrorUnknown"
        case NSURLErrorCancelled: errorKey = "NSURLErrorCancelled"
        case NSURLErrorBadURL: errorKey = "NSURLErrorBadURL"
        case NSURLErrorTimedOut: errorKey = "NSURLErrorTimedOut"
        case NSURLErrorUnsupportedURL: errorKey = "NSURLErrorUnsupportedURL"
        case NSURLErrorCannotFindHost: errorKey = "NSURLErrorCannotFindHost"
        case NSURLErrorCannotConnectToHost: errorKey = "NSURLErrorCannotConnectToHost"
        case NSURLErrorNetworkConnectionLost: errorKey = "NSURLErrorNetworkConnectionLost"
        case NSURLErrorDNSLookupFailed: errorKey = "NSURLErrorDNSLookupFailed"
        case NSURLErrorHTTPTooManyRedirects: errorKey = "NSURLErrorHTTPTooManyRedirects"
        case NSURLErrorResourceUnavailable: errorKey = "NSURLErrorResourceUnavailable"
        case NSURLErrorNotConnectedToInternet: errorKey = "NSURLErrorNotConnectedToInternet"
        case NSURLErrorRedirectToNonExistentLocation: errorKey = "NSURLErrorRedirectToNonExistentLocation"
        case NSURLErrorBadServerResponse: errorKey = "NSURLErrorBadServerResponse"
        case NSURLErrorUserCancelledAuthentication: errorKey = "NSURLErrorUserCancelledAuthentication"
        case NSURLErrorUserAuthenticationRequired: errorKey = "NSURLErrorUserAuthenticationRequired"
        case NSURLErrorZeroByteResource: errorKey = "NSURLErrorZeroByteResource"
        case NSURLErrorCannotDecodeRawData: errorKey = "NSURLErrorCannotDecodeRawData"
        case NSURLErrorCannotDecodeContentData: errorKey = "NSURLErrorCannotDecodeContentData"
        case NSURLErrorCannotParseResponse: errorKey = "NSURLErrorCannotParseResponse"
        case NSURLErrorFileDoesNotExist: errorKey = "NSURLErrorFileDoesNotExist"
        case NSURLErrorFileIsDirectory: errorKey = "NSURLErrorFileIsDirectory"
        case NSURLErrorNoPermissionsToReadFile: errorKey = "NSURLErrorNoPermissionsToReadFile"
        case NSURLErrorDataLengthExceedsMaximum: errorKey = "NSURLErrorDataLengthExceedsMaximum"
        case NSURLErrorSecureConnectionFailed: errorKey = "NSURLErrorSecureConnectionFailed"
        case NSURLErrorServerCertificateHasBadDate: errorKey = "NSURLErrorServerCertificateHasBadDate"
        case NSURLErrorServerCertificateUntrusted: errorKey = "NSURLErrorServerCertificateUntrusted"
        case NSURLErrorServerCertificateHasUnknownRoot: errorKey = "NSURLErrorServerCertificateHasUnknownRoot"
        case NSURLErrorServerCertificateNotYetValid: errorKey = "NSURLErrorServerCertificateNotYetValid"
        case NSURLErrorClientCertificateRejected: errorKey = "NSURLErrorClientCertificateRejected"
        case NSURLErrorClientCertificateRequired: errorKey = "NSURLErrorClientCertificateRequired"
        case NSURLErrorCannotLoadFromNetwork: errorKey = "NSURLErrorCannotLoadFromNetwork"
        case NSURLErrorCannotCreateFile: errorKey = "NSURLErrorCannotCreateFile"
        case NSURLErrorCannotOpenFile: errorKey = "NSURLErrorCannotOpenFile"
        case NSURLErrorCannotCloseFile: errorKey = "NSURLErrorCannotCloseFile"
        case NSURLErrorCannotWriteToFile: errorKey = "NSURLErrorCannotWriteToFile"
        case NSURLErrorCannotRemoveFile: errorKey = "NSURLErrorCannotRemoveFile"
        case NSURLErrorCannotMoveFile: errorKey = "NSURLErrorCannotMoveFile"
        case NSURLErrorDownloadDecodingFailedMidStream: errorKey = "NSURLErrorDownloadDecodingFailedMidStream"
        case NSURLErrorDownloadDecodingFailedToComplete: errorKey = "NSURLErrorDownloadDecodingFailedToComplete"
        case NSURLErrorInternationalRoamingOff: errorKey = "NSURLErrorInternationalRoamingOff"
        case NSURLErrorCallIsActive: errorKey = "NSURLErrorCallIsActive"
        case NSURLErrorDataNotAllowed: errorKey = "NSURLErrorDataNotAllowed"
        case NSURLErrorRequestBodyStreamExhausted: errorKey = "NSURLErrorRequestBodyStreamExhausted"
        case NSURLErrorBackgroundSessionRequiresSharedContainer: errorKey = "NSURLErrorBackgroundSessionRequiresSharedContainer"
        case NSURLErrorBackgroundSessionInUseByAnotherProcess: errorKey = "NSURLErrorBackgroundSessionInUseByAnotherProcess"
        case NSURLErrorBackgroundSessionWasDisconnected: errorKey = "NSURLErrorBackgroundSessionWasDisconnected"
        default:
            if #available(iOS 9, *) {
                switch code {
                case NSURLErrorAppTransportSecurityRequiresSecureConnection:
                    errorKey = "NSURLErrorAppTransportSecurityRequiresSecureConnection"
                default: break
                }
            }
        }
        self = URLDomainError.error(code: code, key: errorKey, info: info)
    }
}


// MARK: - http protocol response codes

enum ResponseCodeError:ErrorProtocol {
    
    enum ResponseCode:Int {
        
        /// Continue: 100
        ///
        /// - seealso: [RFC7231, Section 6.2.1](http://www.iana.org/go/rfc7231#section-6.2.1)
        case Continue = 100
        
        /// Switching Protocols: 101
        ///
        /// - seealso: [RFC7231, Section 6.2.2](http://www.iana.org/go/rfc7231#section-6.2.2)
        case SwitchingProtocols = 101
        
        /// Processing: 102
        ///
        /// - seealso: [RFC2518](http://www.iana.org/go/rfc2518)
        case Processing = 102
        
        /// Checkpoint: 103
        ///
        /// Used in the resumable requests proposal to resume aborted PUT or POST requests.
        case Checkpoint = 103
        
        /// OK: 200
        ///
        /// - seealso: [RFC7231, Section 6.3.1](http://www.iana.org/go/rfc7231#section-6.3.1)
        case OK = 200
        
        /// Created: 201
        ///
        /// - seealso: [RFC7231, Section 6.3.2](http://www.iana.org/go/rfc7231#section-6.3.2)
        case Created = 201
        
        /// Accepted: 202
        ///
        /// - seealso: [RFC7231, Section 6.3.3](http://www.iana.org/go/rfc7231#section-6.3.3)
        case Accepted = 202
        
        /// Non-Authoritative Information: 203
        ///
        /// - seealso: [RFC7231, Section 6.3.4](http://www.iana.org/go/rfc7231#section-6.3.4)
        case NonAuthoritativeInformation = 203
        
        /// No Content: 204
        ///
        /// - seealso: [RFC7231, Section 6.3.5](http://www.iana.org/go/rfc7231#section-6.3.5)
        case NoContent = 204
        
        /// Reset Content: 205
        ///
        /// - seealso: [RFC7231, Section 6.3.6](http://www.iana.org/go/rfc7231#section-6.3.6)
        case ResetContent = 205
        
        /// Partial Content: 206
        ///
        /// - seealso: [RFC7233, Section 4.1](http://www.iana.org/go/rfc7233#section-4.1)
        case PartialContent = 206
        
        /// Multi-Status: 207
        ///
        /// - seealso: [RFC4918](http://www.iana.org/go/rfc4918)
        case MultiStatus = 207
        
        /// Already Reported: 208
        ///
        /// - seealso: [RFC5842](http://www.iana.org/go/rfc5842)
        case AlreadyReported = 208
        
        /// IM Used: 226
        ///
        /// - seealso: [RFC3229](http://www.iana.org/go/rfc3229)
        case IMUsed = 226
        
        /// Multiple Choices: 300
        ///
        /// - seealso: [RFC7231, Section 6.4.1](http://www.iana.org/go/rfc7231#section-6.4.1)
        case MultipleChoices = 300
        
        /// Moved Permanently: 301
        ///
        /// - seealso: [RFC7231, Section 6.4.2](http://www.iana.org/go/rfc7231#section-6.4.2)
        case MovedPermanently = 301
        
        /// Found: 302
        ///
        /// - seealso: [RFC7231, Section 6.4.3](http://www.iana.org/go/rfc7231#section-6.4.3)
        case Found = 302
        
        /// See Other: 303
        ///
        /// - seealso: [RFC7231, Section 6.4.4](http://www.iana.org/go/rfc7231#section-6.4.4)
        case SeeOther = 303
        
        /// Not Modified: 304
        ///
        /// - seealso: [RFC7232, Section 4.1](http://www.iana.org/go/rfc7232#section-4.1)
        case NotModified = 304
        
        /// Use Proxy: 305
        ///
        /// - seealso: [RFC7231, Section 6.4.5](http://www.iana.org/go/rfc7231#section-6.4.5)
        case UseProxy = 305
        
        /// Temporary Redirect: 307
        ///
        /// - seealso: [RFC7231, Section 6.4.7](http://www.iana.org/go/rfc7231#section-6.4.7)
        case TemporaryRedirect = 307
        
        /// Permanent Redirect: 308
        ///
        /// - seealso: [RFC7538](http://www.iana.org/go/rfc7538)
        case PermanentRedirect = 308
        
        /// Bad Request: 400
        ///
        /// - seealso: [RFC7231, Section 6.5.1](http://www.iana.org/go/rfc7231#section-6.5.1)
        case BadRequest = 400
        
        /// Unauthorized: 401
        ///
        /// - seealso: [RFC7235, Section 3.1](http://www.iana.org/go/rfc7235#section-3.1)
        case Unauthorized = 401
        
        /// Payment Required: 402
        ///
        /// - seealso: [RFC7231, Section 6.5.2](http://www.iana.org/go/rfc7231#section-6.5.2)
        case PaymentRequired = 402
        
        /// Forbidden: 403
        ///
        /// - seealso: [RFC7231, Section 6.5.3](http://www.iana.org/go/rfc7231#section-6.5.3)
        case Forbidden = 403
        
        /// Not Found: 404
        ///
        /// - seealso: [RFC7231, Section 6.5.4](http://www.iana.org/go/rfc7231#section-6.5.4)
        case NotFound = 404
        
        /// Method Not Allowed: 405
        ///
        /// - seealso: [RFC7231, Section 6.5.5](http://www.iana.org/go/rfc7231#section-6.5.5)
        case MethodNotAllowed = 405
        
        /// Not Acceptable: 406
        ///
        /// - seealso: [RFC7231, Section 6.5.6](http://www.iana.org/go/rfc7231#section-6.5.6)
        case NotAcceptable = 406
        
        /// Proxy Authentication Required: 407
        ///
        /// - seealso: [RFC7235, Section 3.2](http://www.iana.org/go/rfc7235#section-3.2)
        case ProxyAuthenticationRequired = 407
        
        /// Request Timeout: 408
        ///
        /// - seealso: [RFC7231, Section 6.5.7](http://www.iana.org/go/rfc7231#section-6.5.7)
        case RequestTimeout = 408
        
        /// Conflict: 409
        ///
        /// - seealso: [RFC7231, Section 6.5.8](http://www.iana.org/go/rfc7231#section-6.5.8)
        case Conflict = 409
        
        /// Gone: 410
        ///
        /// - seealso: [RFC7231, Section 6.5.9](http://www.iana.org/go/rfc7231#section-6.5.9)
        case Gone = 410
        
        /// Length Required: 411
        ///
        /// - seealso: [RFC7231, Section 6.5.10](http://www.iana.org/go/rfc7231#section-6.5.10)
        case LengthRequired = 411
        
        /// Precondition Failed: 412
        ///
        /// - seealso: [RFC7232, Section 4.2](http://www.iana.org/go/rfc7232#section-4.2)
        case PreconditionFailed = 412
        
        /// Payload Too Large: 413
        ///
        /// - seealso: [RFC7231, Section 6.5.11](http://www.iana.org/go/rfc7231#section-6.5.11)
        case PayloadTooLarge = 413
        
        /// URI Too Long: 414
        ///
        /// - seealso: [RFC7231, Section 6.5.12](http://www.iana.org/go/rfc7231#section-6.5.12)
        case URITooLong = 414
        
        /// Unsupported Media Type: 415
        ///
        /// - seealso: [RFC7231, Section 6.5.13](http://www.iana.org/go/rfc7231#section-6.5.13)
        /// - seealso: [RFC7694, Section 3](http://www.iana.org/go/rfc7694#section-3)
        case UnsupportedMediaType = 415
        
        /// Range Not Satisfiable: 416
        ///
        /// - seealso: [RFC7233, Section 4.4](http://www.iana.org/go/rfc7233#section-4.4)
        case RangeNotSatisfiable = 416
        
        /// Expectation Failed: 417
        ///
        /// - seealso: [RFC7231, Section 6.5.14](http://www.iana.org/go/rfc7231#section-6.5.14)
        case ExpectationFailed = 417
        
        /// ImATeapot: 418
        ///
        /// Returned by tea pots requested to brew coffee
        ///
        /// - seealso: [RFC 2324](http://www.iana.org/go/rfc2324)
        case ImATeapot = 418
        
        /// Misdirected Request: 421
        ///
        /// - seealso: [RFC7540, Section 9.1.2](http://www.iana.org/go/rfc7540#section-9.1.2)
        case MisdirectedRequest = 421
        
        /// Unprocessable Entity: 422
        ///
        /// - seealso: [RFC4918](http://www.iana.org/go/rfc4918)
        case UnprocessableEntity = 422
        
        /// Locked: 423
        ///
        /// - seealso: [RFC4918](http://www.iana.org/go/rfc4918)
        case Locked = 423
        
        /// Failed Dependency: 424
        ///
        /// - seealso: [RFC4918](http://www.iana.org/go/rfc4918)
        case FailedDependency = 424
        
        /// Upgrade Required: 426
        ///
        /// - seealso: [RFC7231, Section 6.5.15](http://www.iana.org/go/rfc7231#section-6.5.15)
        case UpgradeRequired = 426
        
        /// Precondition Required: 428
        ///
        /// - seealso: [RFC6585](http://www.iana.org/go/rfc6585)
        case PreconditionRequired = 428
        
        /// Too Many Requests: 429
        ///
        /// - seealso: [RFC6585](http://www.iana.org/go/rfc6585)
        case TooManyRequests = 429
        
        /// Request Header Fields Too Large: 431
        ///
        /// - seealso: [RFC6585](http://www.iana.org/go/rfc6585)
        case RequestHeaderFieldsTooLarge = 431
        
        /// IIS Login Timeout: 440
        ///
        /// The client's session has expired and must log in again.
        ///
        /// **Category**: Internet Information Services
        ///
        /// - seealso: [Error message when you try to log on to Exchange 2007 by using Outlook Web Access: "440 Login Timeout"](http://support.microsoft.com/kb/941201/en-us)
        case IISLoginTimeout = 440
        
        /// nginx No Response: 444
        ///
        /// Used to indicate that the server has returned no information to the client and closed the connection.
        ///
        /// **Category**: nginx
        case NginxNoResponse = 444
        
        /// IIS Retry With: 449
        ///
        /// The server cannot honour the request because the user has not provided the required information.
        ///
        /// **Category**: Internet Information Services
        ///
        /// - seealso: [2.2.6 449 Retry With Status Code](https://msdn.microsoft.com/en-us/library/dd891478.aspx)
        case IISRetryWith = 449
        
        /// Blocked by Windows Parental Controls: 450
        ///
        /// A Microsoft extension. This error is given when Windows Parental Controls are turned on and are blocking access to the given webpage.
        case BlockedByWindowsParentalControls = 450
        
        /// Unavailable For Legal Reasons: 451
        ///
        /// - seealso: [RFC7725](http://www.iana.org/go/rfc7725)
        case UnavailableForLegalReasons = 451
        
        /// nginx SSL Certificate Error: 495
        ///
        /// An expansion of the 400 Bad Request response code, used when the client has provided an invalid client certificate.
        ///
        /// **Category**: nginx
        case NginxSSLCertificateError = 495
        
        /// nginx SSLCertificate Required: 496
        ///
        /// An expansion of the 400 Bad Request response code, used when a client certificate is required but not provided.
        ///
        /// **Category**: nginx
        case NginxSSLCertificateRequired = 496
        
        /// nginx HTTP To HTTPS: 497
        ///
        /// An expansion of the 400 Bad Request response code, used when the client has made a HTTP request to a port listening for HTTPS requests.
        ///
        /// **Category**: nginx
        case NginxHTTPToHTTPS = 497
        
        /// Token Expired: 498
        ///
        /// Returned by [ArcGIS for Server](https://en.wikipedia.org/wiki/ArcGIS_Server). A code of 498 indicates an expired or otherwise invalid token.
        ///
        /// - seealso: [Using token-based authentication](http://help.arcgis.com/en/arcgisserver/10.0/apis/soap/index.htm#Using_token_authentication.htm)
        case TokenExpired = 498
        
        /// nginx Client Closed Request: 499
        ///
        /// Used when the client has closed the request before the server could send a response.
        ///
        /// **Category**: nginx
        case NginxClientClosedRequest = 499
        
        /// Internal Server Error: 500
        ///
        /// - seealso: [RFC7231, Section 6.6.1](http://www.iana.org/go/rfc7231#section-6.6.1)
        case InternalServerError = 500
        
        /// Not Implemented: 501
        ///
        /// - seealso: [RFC7231, Section 6.6.2](http://www.iana.org/go/rfc7231#section-6.6.2)
        case NotImplemented = 501
        
        /// Bad Gateway: 502
        ///
        /// - seealso: [RFC7231, Section 6.6.3](http://www.iana.org/go/rfc7231#section-6.6.3)
        case BadGateway = 502
        
        /// Service Unavailable: 503
        ///
        /// - seealso: [RFC7231, Section 6.6.4](http://www.iana.org/go/rfc7231#section-6.6.4)
        case ServiceUnavailable = 503
        
        /// Gateway Timeout: 504
        ///
        /// - seealso: [RFC7231, Section 6.6.5](http://www.iana.org/go/rfc7231#section-6.6.5)
        case GatewayTimeout = 504
        
        /// HTTP Version Not Supported: 505
        ///
        /// - seealso: [RFC7231, Section 6.6.6](http://www.iana.org/go/rfc7231#section-6.6.6)
        case HTTPVersionNotSupported = 505
        
        /// Variant Also Negotiates: 506
        ///
        /// - seealso: [RFC2295](http://www.iana.org/go/rfc2295)
        case VariantAlsoNegotiates = 506
        
        /// Insufficient Storage: 507
        ///
        /// - seealso: [RFC4918](http://www.iana.org/go/rfc4918)
        case InsufficientStorage = 507
        
        /// Loop Detected: 508
        ///
        /// - seealso: [RFC5842](http://www.iana.org/go/rfc5842)
        case LoopDetected = 508
        
        /// Bandwidth Limit Exceeded: 509
        ///
        /// The server has exceeded the bandwidth specified by the server administrator; this is often used by shared hosting providers to limit the bandwidth of customers.
        ///
        /// - seealso: <https://documentation.cpanel.net/display/CKB/HTTP+Error+Codes+and+Quick+Fixes#HTTPErrorCodesandQuickFixes-509BandwidthLimitExceeded>
        case BandwidthLimitExceeded = 509
        
        /// Not Extended: 510
        ///
        /// - seealso: [RFC2774](http://www.iana.org/go/rfc2774)
        case NotExtended = 510
        
        /// Network Authentication Required: 511
        ///
        /// - seealso: [RFC6585](http://www.iana.org/go/rfc6585)
        case NetworkAuthenticationRequired = 511
        
        /// Site is frozen: 530
        ///
        /// Used by the [Pantheon](https://en.wikipedia.org/wiki/Pantheon_(software)) web platform to indicate a site that has been frozen due to inactivity.
        case SiteIsFrozen = 530
    }
    
    case error(code:Int, key:String, info:String?)
    
    func code() -> Int {
        
        switch self{
        case let .error(code, _, _):
            return code
        }
    }
    
    func key() -> String {
        
        switch self{
        case let .error(_, key, _):
            return key
        }
    }
    
    func info() -> String? {
        
        switch self {
        case let .error(_, _, info):
            return info
        }
    }
    
    init(code:Int, info:String? = nil) {
        
        var errorKey = "Unknown key"
        switch code {
        case ResponseCode.Continue.rawValue: errorKey = "Continue"
        case ResponseCode.SwitchingProtocols.rawValue: errorKey = "SwitchingProtocols"
        case ResponseCode.Processing.rawValue: errorKey = "Processing"
        case ResponseCode.Checkpoint.rawValue: errorKey = "Checkpoint"
        case ResponseCode.OK.rawValue: errorKey = "OK"
        case ResponseCode.Created.rawValue: errorKey = "Created"
        case ResponseCode.Accepted.rawValue: errorKey = "Accepted"
        case ResponseCode.NonAuthoritativeInformation.rawValue: errorKey = "NonAuthoritativeInformation"
        case ResponseCode.NoContent.rawValue: errorKey = "NoContent"
        case ResponseCode.ResetContent.rawValue: errorKey = "ResetContent"
        case ResponseCode.PartialContent.rawValue: errorKey = "PartialContent"
        case ResponseCode.MultiStatus.rawValue: errorKey = "MultiStatus"
        case ResponseCode.AlreadyReported.rawValue: errorKey = "AlreadyReported"
        case ResponseCode.IMUsed.rawValue: errorKey = "IMUsed"
        case ResponseCode.MultipleChoices.rawValue: errorKey = "MultipleChoices"
        case ResponseCode.MovedPermanently.rawValue: errorKey = "MovedPermanently"
        case ResponseCode.Found.rawValue: errorKey = "Found"
        case ResponseCode.SeeOther.rawValue: errorKey = "SeeOther"
        case ResponseCode.NotModified.rawValue: errorKey = "NotModified"
        case ResponseCode.UseProxy.rawValue: errorKey = "UseProxy"
        case ResponseCode.TemporaryRedirect.rawValue: errorKey = "TemporaryRedirect"
        case ResponseCode.PermanentRedirect.rawValue: errorKey = "PermanentRedirect"
        case ResponseCode.BadRequest.rawValue: errorKey = "BadRequest"
        case ResponseCode.Unauthorized.rawValue: errorKey = "Unauthorized"
        case ResponseCode.PaymentRequired.rawValue: errorKey = "PaymentRequired"
        case ResponseCode.Forbidden.rawValue: errorKey = "Forbidden"
        case ResponseCode.NotFound.rawValue: errorKey = "NotFound"
        case ResponseCode.MethodNotAllowed.rawValue: errorKey = "MethodNotAllowed"
        case ResponseCode.NotAcceptable.rawValue: errorKey = "NotAcceptable"
        case ResponseCode.ProxyAuthenticationRequired.rawValue: errorKey = "ProxyAuthenticationRequired"
        case ResponseCode.RequestTimeout.rawValue: errorKey = "RequestTimeout"
        case ResponseCode.Conflict.rawValue: errorKey = "Conflict"
        case ResponseCode.Gone.rawValue: errorKey = "Gone"
        case ResponseCode.LengthRequired.rawValue: errorKey = "LengthRequired"
        case ResponseCode.PreconditionFailed.rawValue: errorKey = "PreconditionFailed"
        case ResponseCode.PayloadTooLarge.rawValue: errorKey = "PayloadTooLarge"
        case ResponseCode.URITooLong.rawValue: errorKey = "URITooLong"
        case ResponseCode.UnsupportedMediaType.rawValue: errorKey = "UnsupportedMediaType"
        case ResponseCode.RangeNotSatisfiable.rawValue: errorKey = "RangeNotSatisfiable"
        case ResponseCode.ExpectationFailed.rawValue: errorKey = "ExpectationFailed"
        case ResponseCode.ImATeapot.rawValue: errorKey = "ImATeapot"
        case ResponseCode.MisdirectedRequest.rawValue: errorKey = "MisdirectedRequest"
        case ResponseCode.UnprocessableEntity.rawValue: errorKey = "UnprocessableEntity"
        case ResponseCode.Locked.rawValue: errorKey = "Locked"
        case ResponseCode.FailedDependency.rawValue: errorKey = "FailedDependency"
        case ResponseCode.UpgradeRequired.rawValue: errorKey = "UpgradeRequired"
        case ResponseCode.PreconditionRequired.rawValue: errorKey = "PreconditionRequired"
        case ResponseCode.TooManyRequests.rawValue: errorKey = "TooManyRequests"
        case ResponseCode.RequestHeaderFieldsTooLarge.rawValue: errorKey = "RequestHeaderFieldsTooLarge"
        case ResponseCode.IISLoginTimeout.rawValue: errorKey = "IISLoginTimeout"
        case ResponseCode.NginxNoResponse.rawValue: errorKey = "NginxNoResponse"
        case ResponseCode.IISRetryWith.rawValue: errorKey = "IISRetryWith"
        case ResponseCode.BlockedByWindowsParentalControls.rawValue: errorKey = "BlockedByWindowsParentalControls"
        case ResponseCode.UnavailableForLegalReasons.rawValue: errorKey = "UnavailableForLegalReasons"
        case ResponseCode.NginxSSLCertificateError.rawValue: errorKey = "NginxSSLCertificateError"
        case ResponseCode.NginxSSLCertificateRequired.rawValue: errorKey = "NginxSSLCertificateRequired"
        case ResponseCode.NginxHTTPToHTTPS.rawValue: errorKey = "NginxHTTPToHTTPS"
        case ResponseCode.TokenExpired.rawValue: errorKey = "TokenExpired"
        case ResponseCode.NginxClientClosedRequest.rawValue: errorKey = "NginxClientClosedRequest"
        case ResponseCode.InternalServerError.rawValue: errorKey = "InternalServerError"
        case ResponseCode.NotImplemented.rawValue: errorKey = "NotImplemented"
        case ResponseCode.BadGateway.rawValue: errorKey = "BadGateway"
        case ResponseCode.ServiceUnavailable.rawValue: errorKey = "ServiceUnavailable"
        case ResponseCode.GatewayTimeout.rawValue: errorKey = "GatewayTimeout"
        case ResponseCode.HTTPVersionNotSupported.rawValue: errorKey = "HTTPVersionNotSupported"
        case ResponseCode.VariantAlsoNegotiates.rawValue: errorKey = "VariantAlsoNegotiates"
        case ResponseCode.InsufficientStorage.rawValue: errorKey = "InsufficientStorage"
        case ResponseCode.LoopDetected.rawValue: errorKey = "LoopDetected"
        case ResponseCode.BandwidthLimitExceeded.rawValue: errorKey = "BandwidthLimitExceeded"
        case ResponseCode.NotExtended.rawValue: errorKey = "NotExtended"
        case ResponseCode.NetworkAuthenticationRequired.rawValue: errorKey = "NetworkAuthenticationRequired"
        case ResponseCode.SiteIsFrozen.rawValue: errorKey = "SiteIsFrozen"
        default: break
        }
        self = ResponseCodeError.error(code: code, key: errorKey, info: info)
    }
}
