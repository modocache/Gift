#import <Foundation/Foundation.h>
#import <Gift/GIFTTransferProgress.h>

typedef struct git_remote_callbacks git_remote_callbacks;

/**
 A callback function that is called when the remote sends textual progress updates.
 This includes messages such as "Compressing objects: 1% (47/4619)".

 @param message The message sent from the remote.
 @return A boolean indicating whether to stop the network operation.
         Return true to abort the operation, and false to keep going.
 */
typedef BOOL (^GIFTTransportMessageCallback)(NSString *message);

/**
 A callback function that is called when new data is downloaded.

 @param progress A struct containing data on transfer progress, including
                 total bytes received and other useful information.
 @return A boolean indicating whether to stop the network operation.
         Return true to abort the operation, and false to keep going.
 */
typedef BOOL (^GIFTTransferProgressCallback)(GIFTTransferProgress progress);

/**
 Returns a set of remote callbacks with the given parameters.
 This function is used internally by Gift.

 @param transportMessageCallback A callback function that is called when the
                                 remote sends textual progress updates.
 @param transferProgressCallback A callback function that is called when new
                                 data is downloaded.
 @return A set of remote callbacks initialized with the given values.
 */
extern git_remote_callbacks gift_remoteCallbacks(GIFTTransportMessageCallback transportMessageCallback,
                                                 GIFTTransferProgressCallback transferProgressCallback);
