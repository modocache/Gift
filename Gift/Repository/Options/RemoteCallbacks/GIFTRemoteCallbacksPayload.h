#import <Foundation/Foundation.h>
#import "GIFTRemoteCallbacks.h"

/**
 An object used internally by Gift to store Swift callback closures
 that will be passed to C functions.
 */
@interface GIFTRemoteCallbacksPayload : NSObject

@property (nonatomic, copy, readonly) GIFTTransportMessageCallback transportMessageCallback;
@property (nonatomic, copy, readonly) GIFTTransferProgressCallback transferProgressCallback;

- (instancetype)initWithTransportMessageCallback:(GIFTTransportMessageCallback)transportMessageCallback
                        transferProgressCallback:(GIFTTransferProgressCallback)transferProgressCallback;

@end
