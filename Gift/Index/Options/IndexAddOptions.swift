/** A set of options to configure how entries are added to an index. */
public struct IndexAddOptions : RawOptionSetType, BooleanType {
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

  public static var allZeros: IndexAddOptions {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  /**
    Use the default behavior when adding files to the index.
    By default, pathspecs are used to match file paths, and ignored entries
    that are not already in the index will not be newly added to the index.
  */
  public static var Default: IndexAddOptions { return self(rawValue: 0b0) }

  /**
    Normally, entries that are ignored and do not already exist in the index are ignored.
    This flag disables that behavior, forcing even ignored files to be added to the index.
  */
  public static var Force: IndexAddOptions { return self(rawValue: 0b1) }

  /**
    Treat pathspec as a simple list of exact match file paths. In the absence of this
    flag, partial matching is used.
  */
  public static var DisablePathspecMatch: IndexAddOptions { return self(rawValue: 0b10) }

  /**
    Check to ensure pathspecs does not include any ignored entries. If option is set,
    the pathspecs reference ignored entries, and IndexAddOptions.Force is not specified,
    the add operation fails with an error.
  */
  public static var CheckPathspec: IndexAddOptions { return self(rawValue: 0b100) }
}
