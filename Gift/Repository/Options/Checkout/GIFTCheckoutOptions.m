#import "GIFTCheckoutOptions.h"
#import <git2/checkout.h>

#pragma mark - Internal Functions

static void gift_checkoutProgressCallback(const char *cPath,
                                          size_t completedSteps,
                                          size_t totalSteps,
                                          void *payload) {
  if (payload == NULL) {
    return;
  }

  NSString *path = nil;
  if (cPath != NULL) {
    path = @(cPath);
  }

  GIFTCheckoutProgressCallback block = (__bridge GIFTCheckoutProgressCallback)payload;
  block(path, completedSteps, totalSteps);
}

#pragma mark - Public Interface

extern git_checkout_options gift_checkoutOptions(unsigned int strategyValue,
                                                 GIFTCheckoutProgressCallback progressCallback) {
  git_checkout_options options = GIT_CHECKOUT_OPTIONS_INIT;
  options.checkout_strategy = strategyValue;
  if (progressCallback != nil) {
    options.progress_cb = gift_checkoutProgressCallback;
    options.progress_payload = (__bridge void *)[progressCallback copy];
  }
  return options;
}
