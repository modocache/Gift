import Foundation

public let libGit2ErrorDomain = "com.libgit2"
public let giftErrorDomain = "com.libgit2.gift"

public enum GiftErrorCode: Int {
  case InvalidURI = 1
  case StringConversionFailure = 2
}

internal extension NSError {
  internal class func libGit2Error(errorCode: Int32, libGit2PointOfFailure: String? = nil) -> NSError {
    let code = Int(errorCode)
    var userInfo: [String: String] = [:]

    if let message = errorMessage(errorCode) {
      userInfo[NSLocalizedDescriptionKey] = message
    } else {
      userInfo[NSLocalizedDescriptionKey] = "Unknown libgit2 error."
    }

    if let pointOfFailure = libGit2PointOfFailure {
      userInfo[NSLocalizedFailureReasonErrorKey] = "\(pointOfFailure) failed."
    }

    return NSError(domain: libGit2ErrorDomain, code: code, userInfo: userInfo)
  }

  internal class func giftError(code: GiftErrorCode, description: String) -> NSError {
    return NSError(domain: giftErrorDomain, code: code.rawValue, userInfo: [NSLocalizedDescriptionKey: description])
  }
}
