internal extension CheckoutOptions {
  /**
    Returns a C struct initialized with this options instance's values.
    Used by libgit2 functions.
  */
  internal var cOptions: git_checkout_options {
    return gift_checkoutOptions(UInt32(strategy.rawValue), progressCallback)
  }
}
