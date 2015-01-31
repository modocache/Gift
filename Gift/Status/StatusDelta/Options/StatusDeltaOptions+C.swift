extension StatusDeltaOptions {
  /**
    Returns a C struct initialized with this options instance's values.
    Used by libgit2 functions.

    TODO: `paths` are not included in this struct, ignoring any paths specified
          given by the user. This is because, were this function to allocate 
          unsafe pointers to those paths, to be used by git_strarray below,
          those pointers would have to be freed after they are no longer needed.
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
