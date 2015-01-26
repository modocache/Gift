/**
  A set of options to specify how commits should be sorted when
  being enumerated.
*/
public struct CommitSorting : RawOptionSetType, BooleanType {
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

  public static var allZeros: CommitSorting {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  /**
    Sort the repository commits in no particular order.
    This sorting is arbitrary, implementation-specific, and subject to
    change at any time. This is the default sorting.
  */
  public static var None: CommitSorting { return self(rawValue: 0b0) }

  /**
    Sort the repository commits in topological order, with parents before
    their children. This sorting mode can be combined with time sorting.
  */
  public static var Topological: CommitSorting { return self(rawValue: 0b1) }

  /**
    Sort the repository commits by the time they were committed.
    This sorting mode can be combined with topological sorting.
  */
  public static var Time: CommitSorting { return self(rawValue: 0b10) }

  /**
    Iterate over the repository commits in reverse order.
    This sorting mode can be combined with any of the other sorting options.
  */
  public static var Reverse: CommitSorting { return self(rawValue: 0b100) }
}
