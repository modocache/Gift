import git2
import LlamaKit

public extension Repository {
  /**
    The status of the file at the given path.

    :param: path The path of the file.
    :returns: The result of the operation: either a bitmask value that represents the
              status of the file, or an error indicating what went wrong.
  */
  public func status(path: String) -> Result<Status> {
    var statusFlags: UInt32 = 0
    let errorCode = git_status_file(&statusFlags, cRepository, path)
    if errorCode == GIT_OK.value {
      return success(Status(cStatus: git_status_t(statusFlags)))
    } else {
      return failure("libgit2 error: git_status_file failed with code \(errorCode)")
    }
  }

  /**
    Whether the file at the given path matches the ignore rules.

    :param: path The path of the file.
    :returns: The result of the operation: either a boolean value indicating whether
              the file is ignored, or an error indicating what went wrong.
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