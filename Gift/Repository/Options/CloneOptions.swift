/**
  A set of options used to clone a repository.

  These are made up of options used to checkout a repository, combined with
  a set of callbacks updated with cloning progress.

  TODO: These options are incomplete; they do not yet cover the full
        range of options made possible by git_clone_options.
*/
public struct CloneOptions {
  internal let checkoutOptions: CheckoutOptions
  internal let remoteCallbacks: RemoteCallbacks

  public init(
    checkoutOptions: CheckoutOptions = CheckoutOptions(strategy: CheckoutStrategy.SafeCreate),
    remoteCallbacks: RemoteCallbacks = RemoteCallbacks()
  ) {
    self.checkoutOptions = checkoutOptions
    self.remoteCallbacks = remoteCallbacks
  }
}
