/**
  A set of options used to perform a checkout.
  The designated initializer provides a set of reasonable defaults.

  TODO: These options are incomplete; they do not yet cover the full
        range of options made possible by git_checkout_options.
*/
public struct CheckoutOptions {
  internal let strategy: CheckoutStrategy
  internal let progressCallback: GIFTCheckoutProgressCallback!

  public init(
    strategy: CheckoutStrategy,
    progressCallback: GIFTCheckoutProgressCallback! = nil
  ) {
    self.strategy = strategy
    self.progressCallback = progressCallback
  }
}
