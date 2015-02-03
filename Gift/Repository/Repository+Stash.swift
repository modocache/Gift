import Foundation
import LlamaKit

public extension Repository {
  /**
    Stash changes in the index into a commit object.
    This commit can be checked out later in order to apply the stash.

    :param: message A message associated with the stash.
    :returns: The result of the operation: either a commit with the stashed
              changes, or an error indicating what went wrong.
  */
  public func stash(message: String) -> Result<Commit, NSError> {
    var objectID = UnsafeMutablePointer<git_oid>.alloc(1)
    var cSignature = giftSignature.cSignature
    let errorCode =  git_stash_save(objectID, cRepository, &cSignature, message, 0)
    if errorCode == GIT_OK.value {
      let commit = Commit.lookup(objectID, cRepository: cRepository)
      objectID.dealloc(1)
      return commit
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_stash_save"))
    }
  }

}
