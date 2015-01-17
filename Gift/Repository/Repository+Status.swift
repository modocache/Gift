import git2
import LlamaKit

public extension Repository {
  /**
    Whether the file at the given path matches the ignore rules.

    :param: path The path of the file being checked.
    :returns: The result of the operation: either a boolean value
              indicating whether the file is ignored, or an error
              indicating what went wrong.
  */
  public func shouldIgnore(path: String) -> Result<Bool> {
    var ignored: Int32 = 0
    let errorCode = git_status_should_ignore(&ignored, cRepository, path)
    if errorCode == GIT_OK.value {
      return success(ignored != 0)
    } else {
      return failure("libgit2 error: git_status_should_ignore failed with code \(errorCode)")
    }
  }
}