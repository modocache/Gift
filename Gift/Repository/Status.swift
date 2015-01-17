import git2

public struct Status : RawOptionSetType, BooleanType {
  private let value: UInt = 0

  public init(cStatus: git_status_t) {
    self.init(rawValue: UInt(cStatus.value))
  }

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

  public static var allZeros: Status {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  public static var Current: Status { return self(rawValue: 0b00000000000000) }

  public static var IndexNew: Status { return self(rawValue: 0b00000000000001) }
  public static var IndexModified: Status { return self(rawValue: 0b00000000000010) }
  public static var IndexDeleted: Status { return self(rawValue: 0b00000000000100) }
  public static var IndexRenamed: Status { return self(rawValue: 0b00000000001000) }
  public static var IndexTypeChanged: Status { return self(rawValue: 0b00000000010000) }

  public static var WorkingTreeNew: Status { return self(rawValue: 0b00000010000000) }
  public static var WorkingTreeModified: Status { return self(rawValue: 0b00000100000000) }
  public static var WorkingTreeDeleted: Status { return self(rawValue: 0b00001000000000) }
  public static var WorkingTreeTypeChanged: Status { return self(rawValue: 0b00010000000000) }
  public static var WorkingTreeRenamed: Status { return self(rawValue: 0b00100000000000) }

  public static var Ignored: Status { return self(rawValue: 0b10000000000000) }
}