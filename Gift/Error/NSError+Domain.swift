import Foundation

internal extension NSError {
  /**
    Returns an NSError with an error domain and message for libgit2 errors.

    :param: errorCode An error code returned by a libgit2 function.
    :param: libGit2PointOfFailure The name of the libgit2 function that produced the
                                  error code.
    :returns: An NSError with a libgit2 error domain, code, and message.
  */
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

  /**
    Returns an NSError with an error domain and message for Gift errors.

    :param: errorCode An error code corresponding to the type of failure that occurred.
    :param: description A localized description for the error.
    :returns: An NSError with a Gift error domain, plus the given error code and description.
  */
  internal class func giftError(errorCode: GiftErrorCode, description: String) -> NSError {
    return NSError(domain: giftErrorDomain, code: errorCode.rawValue, userInfo: [NSLocalizedDescriptionKey: description])
  }
}
