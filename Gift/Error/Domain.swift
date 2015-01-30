/**
  Reserved for errors that occurred from within libgit2 function calls.
*/
public let libGit2ErrorDomain = "com.libgit2"

/**
  Reserved for errors that occurred from within Gift function calls,
  either because of an unexpected code path, or because of user error.
*/
public let giftErrorDomain = "com.libgit2.gift"

/**
  Error codes for errors that occurred from within Gift function calls.
*/
public enum GiftErrorCode: Int {
  /**
    An error occurred when attempting to parse an NSURL object.
  */
  case InvalidURI = 1

  /**
    An error occurred when attempting to convert a C string to a Swift String.
  */
  case StringConversionFailure = 2

  /**
    An error occurred when attempting to convert a libgit2 enum raw value to
    a Gift enum value.
  */
  case EnumConversionFailure = 3

  /**
    An error occurred when attempting to pass a Swift closure through to a
    C callback function used by libgit2.
  */
  case CFunctionCallbackConversionFailure = 4
}
