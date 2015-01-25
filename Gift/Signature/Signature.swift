import Foundation

/**
  A signature represents information about the creator of
  an object. For example, tags and commits have signatures
  that contain information about who created the tag or commit,
  and when they did so.
*/
public struct Signature {
  /** The name of the person associated with this signature. */
  public let name: String
  /** The email of the person associated with this signature. */
  public let email: String
  /** The date this signature was made. */
  public let date: NSDate
  /** The time zone in which this signature was made. */
  public let timeZone: NSTimeZone

  public init(name: String, email: String, date: NSDate = NSDate(timeIntervalSinceNow: 0), timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()) {
    self.name = name
    self.email = email
    self.date = date
    self.timeZone = timeZone
  }
}
