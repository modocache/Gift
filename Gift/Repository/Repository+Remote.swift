import Foundation
import LlamaKit

public extension Repository {
  /**
    Adds a remote to the repository.

    :param: name The name of the remote. If this is invalid, this method will fail.
    :param: url The remote URL. If this is invalid, this method will fail.
    :returns: The result of the operation: either the newly created remote,
              or an error indicating what went wrong.
  */
  public func createRemote(name: String, url: NSURL) -> Result<Remote, NSError> {
    if let remoteURL = url.string {
      var out = COpaquePointer.null()
      let errorCode = git_remote_create(&out, cRepository, name, remoteURL)
      if errorCode == GIT_OK.value {
        return success(Remote(cRemote: out))
      } else {
        return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_remote_create"))
      }
    } else {
      return failure(NSError.giftError(.InvalidURI, description: "Invalid URL: \(url)"))
    }
  }

  /**
    Checks this repository's remotes for one with the given name,
    and returns it if it exists.

    :param: name The name of the remote to look up.
    :returns: The result of the operation: either a remote, or an error
              indicating what went wrong.
  */
  public func lookupRemote(name: String) -> Result<Remote, NSError> {
    var out = COpaquePointer.null()
    let errorCode = git_remote_lookup(&out, cRepository, name)
    if errorCode == GIT_OK.value {
      return success(Remote(cRemote: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_remote_lookup"))
    }
  }

  /**
    Returns a list of the names of this repository's remotes, or an error
    indicating what went wrong when retrieving the names.
  */
  public var remoteNames: Result<[String], NSError> {
    var out = git_strarray(strings: nil, count: 0)
    let errorCode = git_remote_list(&out, cRepository)
    if errorCode == GIT_OK.value {
      let names = strings(out)
      git_strarray_free(&out)
      return names
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_remote_list"))
    }
  }
}