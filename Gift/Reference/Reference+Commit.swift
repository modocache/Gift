import Foundation
import LlamaKit

public extension Reference {
  /**
    Returns the commit this reference is referring to,
    or a failure indicating what went wrong when attempting to
    retrieve that commit.
  */
  public var commit: Result<Commit, NSError> {
    var out = COpaquePointer.null()
    let errorCode = git_reference_peel(&out, cReference, git_otype(ObjectType.Commit.rawValue))
    if errorCode == GIT_OK.value {
      return success(Commit(cCommit: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_reference_peel"))
    }
  }
}
