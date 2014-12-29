import git2

/**
  A set of options used to clone a repository.
  The designated initializer provides a set of reasonable defaults.

  TODO: These options are incomplete; they do not yet cover the full
        range of options made possible by git_clone_options.
*/
public struct CloneOptions {
  internal let checkoutOptions: CheckoutOptions
  internal let remoteCallbacks: RemoteCallbacks

  public init(checkoutOptions: CheckoutOptions = CheckoutOptions(), remoteCallbacks: RemoteCallbacks = RemoteCallbacks()) {
    self.checkoutOptions = checkoutOptions
    self.remoteCallbacks = remoteCallbacks
  }
}
