import git2
import LlamaKit

public extension Repository {
  /**
    Creates and returns an index object for the repository.
  */
  public var index: Result<Index> {
    var cIndex = COpaquePointer()
    let errorCode = git_repository_index(&cIndex, cRepository)
    if errorCode == GIT_OK.value {
      return success(Index(cIndex: cIndex))
    } else {
      return failure("libgit2 error: git_repository_index failed")
    }
  }
}
