import git2

/**
  A set of options used to perform a checkout.
  The designated initializer provides a set of reasonable defaults.

  TODO: These options are incomplete; they do not yet cover the full
        range of options made possible by git_checkout_options.
*/
public struct CheckoutOptions {
  /**
    A collection of git_checkout_strategy_t flags.
    Determines checkout behavior.
  */
  internal let strategy: UInt32

  public init(strategy: UInt32 = GIT_CHECKOUT_SAFE_CREATE.value) {
    self.strategy = strategy
  }
}
