/** Information on the progress of a transfer. */
typedef struct {
  /** The number of objects in the packfile that will downloaded. */
  NSUInteger totalObjects;
  /** The number of objects in the packfile that have been downloaded. */
  NSUInteger receivedObjects;
  /** The number of received objects that have been hashed and indexed. */
  NSUInteger indexedObjects;
  /** The number of locally available objects that have been injected in order to fix a thin pack. */
  NSUInteger localObjects;
  /** The number of deltas that will be downloaded. */
  NSUInteger totalDeltas;
  /** The number of deltas that have been downloaded, hashed, and indexed. */
  NSUInteger indexedDeltas;
  /** The number of bytes of the packfile that have been downloaded so far. */
  NSUInteger receivedBytes;
} GIFTTransferProgress;
