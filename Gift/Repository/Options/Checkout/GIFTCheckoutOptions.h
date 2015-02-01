#import <Foundation/Foundation.h>

typedef struct git_checkout_options git_checkout_options;

/**
 A callback function that is executed during a checkout.

 @param checkedOutFilePath A path to the file that is being checked out.
 @param fileIndex The index of the file whose checkout triggered this
                  callback. For example, when the first file has been
                  checked out, this is '0'. The second file is '1', the
                  third is '2', and so on.
 @param fileCount The total number of files to be checked out. When the
                  file index is equal to this file count, it can be
                  inferred that this callback will no longer be called
                  for the current checkout.
 */
typedef void (^GIFTCheckoutProgressCallback)(NSString *checkedOutFilePath,
                                             NSUInteger fileIndex,
                                             NSUInteger fileCount);

/**
 Returns a set of checkout options with the given paramters.
 This function is used internally by Gift.

 @warning This function is necessary in order to allow a Swift closure
          to be used as a progress callback. It is impossible to
          obtain a reference to a C function from Swift that we may
          then use to configure a git_checkout_options struct.

 @param strategyValue The raw value of a CheckoutStrategy options set
                      used to control how a checkout should be performed.
 @param progressCallback An optional progress callback block to be invoked
                         as remote files are checked out. Note that this
                         callback will not be invoked for local checkouts.
 @return A set of checkout options initialized with the given values.
 */
extern git_checkout_options gift_checkoutOptions(unsigned int strategyValue,
                                                 GIFTCheckoutProgressCallback progressCallback);
