extension StatusOptions {
  /**
    TODO: Documentation.
  */
  internal var cOptions: git_status_options {
    return git_status_options(
      version: 1,
      show: git_status_show_t(showOptions.rawValue),
      flags: flags,
      pathspec: git_strarray(strings: nil, count: 0)
    )
  }
}
