import Foundation
import LlamaKit

/**
  A data structure representing a remote repository.
  This is used to push and pull changes to and from a remote repository.
*/
public final class Remote {
  internal let cRemote: COpaquePointer

  internal init(cRemote: COpaquePointer) {
    self.cRemote = cRemote
  }

  deinit {
    git_remote_free(cRemote)
  }
}

public extension Remote {
  /**
    Returns the name of the remote, or an error indicating what went wrong
    when retrieving the name.
  */
  public var name: Result<String, NSError> {
    let cRemoteName = git_remote_name(cRemote)
    if let remoteName = String.fromCString(cRemoteName) {
      return success(remoteName)
    } else {
      let description = "An error occurred when attempting to convert remote name "
                        + "'\(cRemoteName)', provided by git_remote_name, to a String."
      return failure(NSError.giftError(.StringConversionFailure, description: description))
    }
  }

  /**
    Returns the URL of the remote, or an error indicating what went wrong
    when retrieving the URL.
  */
  public var url: Result<NSURL, NSError> {
    let cRemoteURLString = git_remote_url(cRemote)
    if let remoteURLString = String.fromCString(cRemoteURLString) {
      if let remoteURL = NSURL(string: remoteURLString) {
        return success(remoteURL)
      } else {
        return failure(NSError.giftError(.InvalidURI, description: "Invalid URI: \(remoteURLString)"))
      }
    } else {
      let description = "An error occurred when attempting to convert remote URL "
                        + "'\(cRemoteURLString)', provided by git_remote_url, to a String."
      return failure(NSError.giftError(.StringConversionFailure, description: description))
    }
  }
}
