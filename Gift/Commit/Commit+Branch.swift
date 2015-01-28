import Foundation
import LlamaKit

public extension Commit {
  /**
    Creates a branch that refers to this commit.

    :param: name The name of the new branch. This name must be unique, unless
                 the `force` parameter is specified.
    :param: signature The identity that will be used to popular the reflog entry.
                      By default, this will be recorded as "com.libgit2.Gift".
    :param: force If true, attempts to create branches with a name that already
                  exists will overwrite the previous branch.
    :returns: The result of the operation: either a reference to the newly created
              branch, or an error indicating what went wrong.
  */
  public func createBranch(name: String, signature: Signature = Signature(name: "com.libgit2.Gift", email: ""), force: Bool = false) -> Result<Reference, NSError> {
    var out = COpaquePointer.null()
    var cSignature = signature.cSignature
    let cForce: Int32 = force ? 1 : 0
    let errorCode = git_branch_create(&out, cRepository, name, cCommit, cForce, &cSignature, nil)
    if errorCode == GIT_OK.value {
      return success(Reference(cReference: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_branch_create"))
    }
  }
}
