import Foundation
import LlamaKit

public extension Repository {
  /**
    Creates and returns an index object for the repository.
  */
  public var index: Result<Index, NSError> {
    var cIndex = COpaquePointer()
    let errorCode = git_repository_index(&cIndex, cRepository)
    if errorCode == GIT_OK.value {
      return success(Index(cIndex: cIndex))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_repository_index"))
    }
  }
}
