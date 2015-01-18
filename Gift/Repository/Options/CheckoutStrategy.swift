/**
  A set of flags indicating how a checkout should be performed.

  These values map directly to those enumerated in the libgit2 enum git_checkout_strategy_t.
*/
public struct CheckoutStrategy : RawOptionSetType, BooleanType {
  private let value: UInt = 0

  internal init(cCheckoutStrategy: git_checkout_strategy_t) {
    self.init(rawValue: UInt(cCheckoutStrategy.value))
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

  public static var allZeros: CheckoutStrategy {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  /**
    The default strategy is none--a dry run that does not actually perform a checkout.
  */
  public static var None: CheckoutStrategy { return self(rawValue: 0b0) }
  /**
    Allow safe updates that cannot overwrite any uncommitted data.
    Emulates `git checkout` without any additional option flags specified.
  */
  public static var Safe: CheckoutStrategy { return self(rawValue: 0b1) }
  /**
    Allow safe updates, as well as the creation of missing files.
    Emulates `git clone` without any additional option flags specified.
  */
  public static var SafeCreate: CheckoutStrategy { return self(rawValue: 0b10) }
  /**
    Allow all updates to force the working directory to mirror the index.
    Emulates `git checkout --force`.
  */
  public static var Force: CheckoutStrategy { return self(rawValue: 0b100) }

  /** Allow the checkout to make safe updates, even if conflicts are found. */
  public static var AllowConflicts: CheckoutStrategy { return self(rawValue: 0b1000) }
  /** Remove untracked files (that are not ignored) that are not in the index. */
  public static var RemoveUntracked: CheckoutStrategy { return self(rawValue: 0b10000) }
  /** Remove ignored files not in the index. */
  public static var RemoveIgnored: CheckoutStrategy { return self(rawValue: 0b00000000100000) }
  /** Only update existing files, don't create any new ones. */
  public static var UpdateOnly: CheckoutStrategy { return self(rawValue: 0b00000001000000) }

  /** In the absence of this flag, a checkout updates the index. */
  public static var DoNotUpdateIndex: CheckoutStrategy { return self(rawValue: 0b00000010000000) }
  /** In the absence of this flag, a checkout refreshes the index, config, and other metadata before it begins. */
  public static var NoRefresh: CheckoutStrategy { return self(rawValue: 0b00000100000000) }

  /** Skip unmerged files. */
  public static var SkipUnmerged: CheckoutStrategy { return self(rawValue: 0b00001000000000) }
  /** For unmerged files, use the local version. */
  public static var UseOurs: CheckoutStrategy { return self(rawValue: 0b00010000000000) }
  /** For unmerged files, use the checkout target version. */
  public static var UseTheirs: CheckoutStrategy { return self(rawValue: 0b00100000000000) }

  /**
    Treat pathspec as a simple list of exact match file paths.
    In the absence of this flag, partial matching is used.
  */
  public static var DisablePathspecMatch: CheckoutStrategy { return self(rawValue: 0b1000000000000) }
  /** Ignore directories in use or locked by another Git process. These will be left empty. */
  public static var SkipLockedDirectories: CheckoutStrategy { return self(rawValue: 0b100000000000000000) }
  /** In the absence of this flag, ignored files that exist in the checkout target are overwritten. */
  public static var DoNotOverwriteIgnored: CheckoutStrategy { return self(rawValue: 0b1000000000000000000) }
  /** Write standard merge files in the case of a conflict. */
  public static var ConflictStyleMerge: CheckoutStrategy { return self(rawValue: 0b10000000000000000000) }
  /** Include common ancestor data in diff3 format in the case of a conflict. */
  public static var ConflictStyleDiff3: CheckoutStrategy { return self(rawValue: 0b100000000000000000000) }
}
