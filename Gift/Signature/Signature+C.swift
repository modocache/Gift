import Foundation
import LlamaKit

internal extension Signature {
  /**
    Returns a C struct initialized with this signature instance's values.
    Used by libgit2 functions.
  */
  internal var cSignature: git_signature {
    let utf8Name = (name as NSString).UTF8String
    var cName: UnsafeMutablePointer<Int8> = UnsafeMutablePointer(utf8Name)

    let utf8Email = (email as NSString).UTF8String
    var cEmail: UnsafeMutablePointer<Int8> = UnsafeMutablePointer(utf8Email)

    return git_signature(
      name: cName as UnsafeMutablePointer,
      email: cEmail as UnsafeMutablePointer,
      when: git_time(
        time: git_time_t(date.timeIntervalSince1970),
        offset: Int32(timeZone.secondsFromGMT / 60)
      )
    )
  }

  /**
    Creates a Signature object based on a git_signature C struct, or a failure
    indicating what went wrong when attempting to create the object.
  */
  internal static func fromCSignature(cSignature: git_signature) -> Result<Signature, NSError> {
    if let signatureName = String.fromCString(cSignature.name) {
      if let signatureEmail = String.fromCString(cSignature.email) {
        return success(Signature(
          name: signatureName,
          email: signatureEmail,
          date: NSDate(timeIntervalSince1970: NSTimeInterval(cSignature.when.time)),
          timeZone: NSTimeZone(forSecondsFromGMT: Int(cSignature.when.offset) * 60)
        ))
      }
    }

    let description = "An error occurred when attempting to convert signature "
                      + "name '\(cSignature.name)' and email '\(cSignature.email)' "
                      + "to strings."
    return failure(NSError.giftError(.StringConversionFailure, description: description))
  }
}
