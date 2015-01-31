/**
  A set of descriptors for a status object, used to indicate whether
  it is binary, text, has a valid ID, and so on.
*/
public struct StatusDescriptorSet : RawOptionSetType, BooleanType {
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

  public static var allZeros: StatusDescriptorSet {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  /** The entry is treated as binary data. */
  public static var Binary: StatusDescriptorSet { return self(rawValue: 0b1) }

  /** The entry is treated as text data. */
  public static var NotBinary: StatusDescriptorSet { return self(rawValue: 0b10) }

  /** The ID value of the entry is known to be valid. */
  public static var ValidID: StatusDescriptorSet { return self(rawValue: 0b100) }
}
