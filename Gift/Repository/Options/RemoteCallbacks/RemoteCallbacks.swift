/** A default value for RemoteCallbacks.transportMessageCallback that does nothing. */
private let transportMessageDoNothing: GIFTTransportMessageCallback = { (message) in false }

/** A default value for RemoteCallbacks.transferProgressCallback that does nothing. */
private let transferProgressDoNothing: GIFTTransferProgressCallback = { (progress) in false }

/**
  Callbacks used to inform the user about
  the progress of a network operation.

  TODO: This struct is incomplete; it does not yet cover the full
        range of options made possible by git_remote_callbacks.
*/
public struct RemoteCallbacks {
  internal let transportMessageCallback: GIFTTransportMessageCallback
  internal let transferProgressCallback: GIFTTransferProgressCallback

  public init(
    transportMessageCallback: GIFTTransportMessageCallback = transportMessageDoNothing,
    transferProgressCallback: GIFTTransferProgressCallback = transferProgressDoNothing
  ) {
    self.transportMessageCallback = transportMessageCallback
    self.transferProgressCallback = transferProgressCallback
  }
}
