#import "GIFTRemoteCallbacks.h"
#import "GIFTRemoteCallbacksPayload.h"
#import <git2/remote.h>

const int GIFTRemoteCallbacksPayloadError = -1989;

#pragma mark - Internal Functions

int gift_continueCode(BOOL shouldCancel) {
  return shouldCancel ? -1990 : 0;
}

static GIFTRemoteCallbacksPayload *_payload = nil;

static int gift_transportMessageCallback(const char *str, int len, void *payload) {
  if (payload == NULL) {
    return GIFTRemoteCallbacksPayloadError;
  }

  GIFTRemoteCallbacksPayload *callbacksPayload = (__bridge GIFTRemoteCallbacksPayload *)payload;
  NSString *message;
  if (str != NULL && (message = @(str))) {
    return gift_continueCode(callbacksPayload.transportMessageCallback(message));
  }

  return gift_continueCode(NO);
}

static int gift_transferProgressCallback(const git_transfer_progress *stats, void *payload) {
  if (payload == NULL) {
    return GIFTRemoteCallbacksPayloadError;
  }

  GIFTRemoteCallbacksPayload *callbacksPayload = (__bridge GIFTRemoteCallbacksPayload *)payload;
  return gift_continueCode(callbacksPayload.transferProgressCallback((GIFTTransferProgress){
    .totalObjects = stats->total_objects,
    .indexedObjects = stats->indexed_objects,
    .receivedObjects = stats->received_objects,
    .localObjects = stats->local_objects,
    .totalDeltas = stats->total_deltas,
    .indexedDeltas = stats->indexed_deltas,
    .receivedBytes = stats->received_bytes,
  }));
}

#pragma mark - Public Interface

extern git_remote_callbacks gift_remoteCallbacks(GIFTTransportMessageCallback transportMessageCallback,
                                                 GIFTTransferProgressCallback transferProgressCallback) {
  git_remote_callbacks callbacks = GIT_REMOTE_CALLBACKS_INIT;
  callbacks.sideband_progress = gift_transportMessageCallback;
  callbacks.transfer_progress = gift_transferProgressCallback;

  _payload = [[GIFTRemoteCallbacksPayload alloc] initWithTransportMessageCallback:transportMessageCallback
                                                         transferProgressCallback:transferProgressCallback];
  callbacks.payload = (__bridge void *)_payload;
  return callbacks;
}
