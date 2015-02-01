/**
  A set of options used to clone a repository.

  These are made up of options used to checkout a repository, combined with
  a set of callbacks updated with cloning progress.
*/
public struct CloneOptions {
  internal let checkoutOptions: CheckoutOptions
  internal let remoteCallbacks: RemoteCallbacks
  internal let localCloneBehavior: LocalCloneBehavior

  public init(
    checkoutOptions: CheckoutOptions = CheckoutOptions(strategy: CheckoutStrategy.SafeCreate),
    remoteCallbacks: RemoteCallbacks = RemoteCallbacks(),
    localCloneBehavior: LocalCloneBehavior = .Automatic
  ) {
    self.checkoutOptions = checkoutOptions
    self.remoteCallbacks = remoteCallbacks
    self.localCloneBehavior = localCloneBehavior
  }
}
