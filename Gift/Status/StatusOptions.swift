import git2

/**
  TODO: Documentation.
*/
public struct StatusOptions {
  /**
    TODO: Documentation.
  */
  public let showOptions: StatusShowOption

  /**
    TODO: Documentation.
    TODO: Convert to options set.
  */
  public let flags: UInt32

  /**
    TODO: Documentation.
  */
  public let path: [String]

  public init(showOptions: StatusShowOption = StatusShowOption.All, flags: UInt32 = GIT_STATUS_OPT_INCLUDE_IGNORED.value | GIT_STATUS_OPT_INCLUDE_UNTRACKED.value | GIT_STATUS_OPT_RECURSE_UNTRACKED_DIRS.value, path: [String] = []) {
    self.showOptions = showOptions
    self.flags = flags
    self.path = path
  }
}
