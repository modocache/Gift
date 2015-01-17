import Foundation
import git2
import LlamaKit

public typealias StatusClosure = (headToIndex: StatusDelta, indexToWorkingDirectory: StatusDelta) -> Bool

public extension Repository {
  /**
    TODO: Documentation.
    TODO: Does not work--git_status_list_entrycount always returns 0.
  */
  public func status(closure: StatusClosure, options: StatusOptions = StatusOptions()) -> Result<UInt> {
    var statusList = COpaquePointer()
    var cOptions = options.cOptions
    let errorCode = git_status_list_new(&statusList, cRepository, &cOptions)
    if errorCode == GIT_OK.value {
      let statusCount = git_status_list_entrycount(statusList)
      if statusCount < 1 {
        git_status_list_free(statusList)
        return success(statusCount)
      } else {
        for statusIndex in 0..<statusCount {
          let entry = git_status_byindex(statusList, statusIndex)
          if entry != nil {
            let headToIndex = StatusDelta(cStatusDelta: entry.memory.head_to_index.memory)
            let indexToWorkingDirectory = StatusDelta(cStatusDelta: entry.memory.index_to_workdir.memory)
            if closure(headToIndex: headToIndex, indexToWorkingDirectory: indexToWorkingDirectory) {
              git_status_list_free(statusList)
              return success(statusIndex + 1)
            }
          }
        }
        git_status_list_free(statusList)
        return success(statusCount)
      }
    } else {
      git_status_list_free(statusList)
      return failure("libgit2 error: git_status_list_new failed with code \(errorCode)")
    }
  }

  /**
    Returns the status of the file at the given path.

    :param: path The path of the file.
    :returns: The result of the operation: either the status of the file in the
              index and working directories, or an error indicating what went wrong.
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