/**
  A set of flags indicating the status of an entry.

  In the absence of any changes, the entry is considered "current".
  Otherwise, it may have changed in the index, working directory,
  or both. It may also be ignored.
*/
public struct EntryStatus : RawOptionSetType, BooleanType {
  private let value: UInt = 0

  // MARK: NilLiteralConvertible Protocol Methods

  public init(nilLiteral: ()) { }

  // MARK: _RawOptionSetType Protocol Methods

  public init(rawValue value: UInt) {
    self.value = value
  }

  // MARK: RawRepresentable Protocol Methods

  public var rawValue: UInt {
    return value
  }

  // MARK: BitwiseOperationsType Protocol Methods

  public static var allZeros: EntryStatus {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  /** No changes have been made to the entry. */
  public static var Current: EntryStatus { return self(rawValue: 0b0) }

  /** The entry has been newly added since HEAD, and has been staged in the index. */
  public static var IndexNew: EntryStatus { return self(rawValue: 0b1) }
  /** The entry has been modified since HEAD, and has been staged in the index. */
  public static var IndexModified: EntryStatus { return self(rawValue: 0b10) }
  /** The entry has been deleted since HEAD, and has been staged in the index. */
  public static var IndexDeleted: EntryStatus { return self(rawValue: 0b100) }
  /** The entry has been renamed since HEAD, and has been staged in the index. */
  public static var IndexRenamed: EntryStatus { return self(rawValue: 0b1000) }
  /** The entry has had its type changed since HEAD, and has been staged in the index. */
  public static var IndexTypeChanged: EntryStatus { return self(rawValue: 0b10000) }

  /** The entry has been newly added when compared to the index and HEAD. */
  public static var WorkingDirectoryNew: EntryStatus { return self(rawValue: 0b10000000) }
  /** The entry has been modified when compared to the index and HEAD. */
  public static var WorkingDirectoryModified: EntryStatus { return self(rawValue: 0b100000000) }
  /** The entry has been newly deleted when compared to the index and HEAD. */
  public static var WorkingDirectoryDeleted: EntryStatus { return self(rawValue: 0b1000000000) }
  /** The entry has had its type changed when compared to the index and HEAD. */
  public static var WorkingDirectoryTypeChanged: EntryStatus { return self(rawValue: 0b10000000000) }
  /** The entry has been renamed when compared to the index and HEAD. */
  public static var WorkingDirectoryRenamed: EntryStatus { return self(rawValue: 0b100000000000) }

  /** The entry is ignored. */
  public static var Ignored: EntryStatus { return self(rawValue: 0b10000000000000) }
}