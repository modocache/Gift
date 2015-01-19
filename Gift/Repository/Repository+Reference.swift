import LlamaKit

public extension Repository {
  /**
    Retrieves the reference pointed at by HEAD.
  */
  public var headReference: Result<Reference> {
    var out = COpaquePointer()
    let errorCode = git_repository_head(&out, cRepository)

    if errorCode == GIT_OK.value {
      return success(Reference(cReference: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_repository_head"))
    }
  }
}
