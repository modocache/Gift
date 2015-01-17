import git2

extension CloneOptions {
  /**
    Returns a C struct initialized with this options instance's values.
    Used by libgit2 functions.
  */
  internal var cOptions: git_clone_options {
    return git_clone_options(
      version: 1,
      checkout_opts: checkoutOptions.cOptions,
      remote_callbacks: remoteCallbacks.cCallbacks,
      bare: 0,
      local: GIT_CLONE_LOCAL_AUTO,
      checkout_branch: nil,
      signature: nil,
      repository_cb: nil,
      repository_cb_payload: nil,
      remote_cb: nil,
      remote_cb_payload: nil
    )
  }
}
