import Foundation
import LlamaKit

public extension Repository {
  /**
    Retrieves the reference pointed at by HEAD.
  */
  public var headReference: Result<Reference, NSError> {
    var out = COpaquePointer.null()
    let errorCode = git_repository_head(&out, cRepository)

    if errorCode == GIT_OK.value {
      return success(Reference(cReference: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_repository_head"))
    }
  }

  /**
    Sets the head of this repository to the reference with the given name.

    :param: referenceName The name of the reference. For example, to set the head
                          to a local branch named "development", this parameter
                          should be specified as "refs/heads/development".
    :param: signature The identity that will be used to popular the reflog entry.
                      By default, this will be recorded as "com.libgit2.Gift".
    :returns: The result of the operation: either a reference to the repository whose
              head has been changed, or an error indicating what went wrong.
  */
  public func setHead(referenceName: String, signature: Signature = giftSignature) -> Result<Repository, NSError> {
    var cSignature = signature.cSignature
    let errorCode = git_repository_set_head(cRepository, referenceName, &cSignature, nil)
    if errorCode == GIT_OK.value {
      return success(self)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_repository_set_head"))
    }
  }
}
