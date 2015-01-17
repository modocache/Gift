import Foundation
import git2
import LlamaKit

public extension Repository {
  /**
    Whether the file at the given URL matches the ignore rules.

    :param: fileURL The URL of the file.
    :returns: The result of the operation: either a boolean value
              indicating whether the file is ignored, or an error
              indicating what went wrong.
  */
  public func shouldIgnore(fileURL: NSURL) -> Result<Bool> {
    if let path = fileURL.path?.fileSystemRepresentation() {
      var ignored: Int32 = 0
      let errorCode = git_status_should_ignore(&ignored, cRepository, path)
      if errorCode == GIT_OK.value {
        return success(ignored != 0)
      } else {
        return failure("libgit2 error: git_status_should_ignore failed with code \(errorCode)")
      }
    } else {
      return failure("Invalid fileURL: \(fileURL)")
    }
  }
}