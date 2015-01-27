import Foundation
import LlamaKit

internal extension Commit {
  /**
    Looks up a commit object with the given object ID in the given repository.

    :param: objectID The object ID of the commit object.
    :param: cRepository An opaque C struct representing a repository that
                        the commit object ID belongs to.
    :returns: The result of the lookup: either a commit object, or a failure
              indicating what went wrong.
  */
  internal class func lookup(objectID: UnsafeMutablePointer<git_oid>, cRepository: COpaquePointer) -> Result<Commit, NSError> {
    var out = COpaquePointer.null()
    let errorCode = git_commit_lookup(&out, cRepository, objectID)
    if errorCode == GIT_OK.value {
      return success(Commit(cCommit: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_tag_lookup"))
    }
  }
}
