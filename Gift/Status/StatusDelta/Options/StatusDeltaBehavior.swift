/** A set of options to customize the behavior of status delta enumeration. */
public struct StatusDeltaBehavior : RawOptionSetType, BooleanType {
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

  public static var allZeros: StatusDeltaBehavior {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  /**
    Include untracked files in the enumeration, provided the paths to
    those files are included in the first place.
  */
  public static var IncludeUntracked: StatusDeltaBehavior { return self(rawValue: 0b1) }

  /**
    Include ignored files in the enumeration, provided the paths to
    those files are included in the first place.
  */
  public static var IncludeIgnored: StatusDeltaBehavior { return self(rawValue: 0b10) }

  /**
    Include unmodified files in the enumeration, provided the paths to
    those files are included in the first place.
  */
  public static var IncludeUnmodified: StatusDeltaBehavior { return self(rawValue: 0b100) }

  /** Exclude submodules in the enumeration. */
  public static var ExcludeSubmodules: StatusDeltaBehavior { return self(rawValue: 0b1000) }

  /**
    Include all files in untracked directories in the enumeration.
    In the absence of this flag, if an entire directory is new, then just the
    top-level directory is included in the enumeration, along with a trailing slash
    on the entry name. This flag overrides that default behavior, to instead
    include every single file in the enumeration.
  */
  public static var RecurseUntrackedDirectories: StatusDeltaBehavior { return self(rawValue: 0b10000) }

  /**
    Treat pathspec as a simple list of exact match file paths. In the absence of this
    flag, partial matching is used.
  */
  public static var DisablePathspecMatch: StatusDeltaBehavior { return self(rawValue: 0b100000) }

  /** Include the contents of ignored directories in the enumeration. */
  public static var RecurseIgnoredDirectories: StatusDeltaBehavior { return self(rawValue: 0b1000000) }

  /**
    Detect when a file has been renamed between HEAD and the index.
    This requires additional computation, but in return files may be marked as having
    type `StatusDeltaType.Renamed` when compared between HEAD and index.
  */
  public static var DetectRenamesBetweenHeadAndIndex: StatusDeltaBehavior { return self(rawValue: 0b10000000) }

  /**
    Detect when a file has been renamed between the index and the working directory.
    This requires additional computation, but in return files may be marked as having
    type `StatusDeltaType.Renamed` when compared between the index and the working directory.
  */
  public static var DetectRenamesBetweenIndexAndWorkingDirectory: StatusDeltaBehavior { return self(rawValue: 0b100000000) }

  /**
    Overrides the native case-sensitivity for the platform, and enumerates files
    in case-sensitive, alphabetical order.
  */
  public static var SortCaseSensitively: StatusDeltaBehavior { return self(rawValue: 0b1000000000) }

  /**
    Overrides the native case-sensitivity for the platform, and enumerates files
    in case-insensitive, alphabetical order.
  */
  public static var SortCaseInsensitively: StatusDeltaBehavior { return self(rawValue: 0b10000000000) }

  /** Detect when a file has been renamed, even among rewritten files. */
  public static var DetectRenamesAmongRewrittenFiles: StatusDeltaBehavior { return self(rawValue: 0b100000000000) }

  /**
    Normally, a status delta enumeration reloads the index, picking up any changes that may
    have been made outside of Gift itself. This flag disables that default behavior, so that
    status delta enumeration does not refresh the index.
  */
  public static var NoRefresh: StatusDeltaBehavior { return self(rawValue: 0b1000000000000) }

  /**
    Cache statistics on the status delta that were gathered during the status delta
    enumeration. This will result in less work being done on subsequent enumerations.
    This is mutually exclusive with the .NoRefresh option.
  */
  public static var CacheStatistics: StatusDeltaBehavior { return self(rawValue: 0b1000000000000) }

  /**
    Include unreadable files in the enumeration, provided the paths to
    those files are included in the first place.
  */
  public static var IncludeUnreadable: StatusDeltaBehavior { return self(rawValue: 0b10000000000000) }

  /**
    Include untracked files as untracked files in the enumeration.
  */
  public static var IncludeUnreadableAsUntracked: StatusDeltaBehavior { return self(rawValue: 0b100000000000000) }
}
