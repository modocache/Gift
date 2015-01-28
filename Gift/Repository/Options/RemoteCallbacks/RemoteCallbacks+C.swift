extension RemoteCallbacks {
  /**
    Returns a C struct initialized with this callbacks instance's values.
    Used by libgit2 functions.
  */
  internal var cCallbacks: git_remote_callbacks {
    return git_remote_callbacks(
      version: 1,
      sideband_progress: nil,
      completion: nil,
      credentials: nil,
      certificate_check: nil,
      transfer_progress: nil,
      update_tips: nil,
      pack_progress: nil,
      push_transfer_progress: nil,
      push_update_reference: nil,
      payload: nil
    )
  }
}
