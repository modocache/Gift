#import "GIFTRemoteCallbacksPayload.h"

@implementation GIFTRemoteCallbacksPayload

#pragma mark - Object Initializer

- (instancetype)initWithTransportMessageCallback:(GIFTTransportMessageCallback)transportMessageCallback
                        transferProgressCallback:(GIFTTransferProgressCallback)transferProgressCallback
{
  self = [super init];
  if (self) {
    _transportMessageCallback = [transportMessageCallback copy];
    _transferProgressCallback = [transferProgressCallback copy];
  }
  return self;
}

@end
