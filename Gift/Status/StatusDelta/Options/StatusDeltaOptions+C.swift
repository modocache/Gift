extension StatusDeltaOptions {
  /**
    Returns a C struct initialized with this options instance's values.
    Used by libgit2 functions.
  */
  internal var cOptions: git_status_options {
    return git_status_options(
      version: 1,
      show: git_status_show_t(between.rawValue),
      flags: UInt32(behavior.rawValue),
      pathspec: git_strarray(strings: nil, count: 0)
    )
  }
}
