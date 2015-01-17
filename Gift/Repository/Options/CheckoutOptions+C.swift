import git2

extension CheckoutOptions {
  /**
    Returns a C struct initialized with this options instance's values.
    Used by libgit2 functions.
  */
  internal var cOptions: git_checkout_options {
    return git_checkout_options(
      version: 1,
      checkout_strategy: UInt32(strategy.rawValue),
      disable_filters: 0,
      dir_mode: 0,
      file_mode: 0,
      file_open_flags: 0,
      notify_flags: 0,
      notify_cb: nil,
      notify_payload: nil,
      progress_cb: nil,
      progress_payload: nil,
      paths: git_strarray(strings: nil, count: 0),
      baseline: nil,
      target_directory: nil,
      ancestor_label: nil,
      our_label: nil,
      their_label: nil
    )
  }
}
