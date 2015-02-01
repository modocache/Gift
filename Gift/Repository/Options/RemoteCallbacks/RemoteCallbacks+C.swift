extension RemoteCallbacks {
  /**
    Returns a C struct initialized with this callbacks instance's values.
    Used by libgit2 functions.
  */
  internal var cCallbacks: git_remote_callbacks {
    return gift_remoteCallbacks(
      transportMessageCallback,
      transferProgressCallback
    )
  }
}
