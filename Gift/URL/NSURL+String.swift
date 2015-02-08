import Foundation

internal extension NSURL {
  /**
    Returns a string based on the type of URL.
    For remote URLs, this returns the absolute string for that URL.
    For file reference URLs, this returns the absolute path of that URL.
    Used internally by Gift.
  */
  internal var string: String? {
    if isFileReferenceURL() {
      return path
    } else {
      return absoluteString
    }
  }
}
