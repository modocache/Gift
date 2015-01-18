/**
  A set of options indicating how a repository should be initialized.

  These values map directly to those enumerated in the libgit2 enum git_repository_init_flag_t.
*/
public struct RepositoryInitializationOptionSet : RawOptionSetType, BooleanType {
  private let value: UInt = 0

  internal init(cRepositoryInitializationOptionSet: git_repository_init_flag_t) {
    self.init(rawValue: UInt(cRepositoryInitializationOptionSet.value))
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

  public static var allZeros: RepositoryInitializationOptionSet {
    return self(rawValue: 0)
  }

  // MARK: BooleanType Protocol Methods

  public var boolValue: Bool {
    return value != 0
  }

  // MARK: Enum Values

  /** Create a bare repository with no working directory. */
  public static var Bare: RepositoryInitializationOptionSet { return self(rawValue: 0b0) }

  /** Raise an error (GIT_EEXISTS) if there already appears to be a repository at the given location. */
  public static var DoNotReinitialize: RepositoryInitializationOptionSet { return self(rawValue: 0b1) }

  /**
    In the absence of this flag, and in the case that the repository being created is not bare,
    a '.git' directory will be created at the root of the repository path, provided that one
    does not already exist at that location.
  */
  public static var NoDotGitDirectory: RepositoryInitializationOptionSet { return self(rawValue: 0b10) }

  /** Create the repository and working directory as needed. */
  public static var MakeDirectory: RepositoryInitializationOptionSet { return self(rawValue: 0b100) }

  /** Recursively create all components of the repository and working directory path as needed. */
  public static var MakePath: RepositoryInitializationOptionSet { return self(rawValue: 0b1000) }

  /**
    Normally, internal templates are used when creating a new repository.
    This flag, in combination with a template path that is provided to `RepositoryInitializationOptions`,
    or the `init.templatedir` global config value, will use an external template at the given location.
  */
  public static var ExternalTemplate: RepositoryInitializationOptionSet { return self(rawValue: 0b10000) }

  /**
    If an alternate working directory path is provided to `RepositoryInitializationOptions`,
    use relative paths for the .git directory and working directory.
  */
  public static var RelativeGitLink: RepositoryInitializationOptionSet { return self(rawValue: 0b100000) }
}
