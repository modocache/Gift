import Foundation

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
}
