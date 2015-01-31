import Foundation
import LlamaKit

public typealias StatusClosure = (headToIndex: StatusDelta?, indexToWorkingDirectory: StatusDelta?) -> Bool

public extension Repository {
  /**
    TODO: Documentation.
  */
  public func status(closure: StatusClosure, options: StatusDeltaOptions = StatusDeltaOptions()) -> Result<UInt, NSError> {
    var statusList = COpaquePointer.null()
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
            var headToIndex: StatusDelta?
            if entry.memory.head_to_index != nil {
              headToIndex = StatusDelta(cDiffDelta: entry.memory.head_to_index.memory)
            }
            var indexToWorkingDirectory: StatusDelta?
            if entry.memory.index_to_workdir != nil {
              indexToWorkingDirectory = StatusDelta(cDiffDelta: entry.memory.index_to_workdir.memory)
            }
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
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_status_list_new"))
    }
  }

  /**
    Returns the status of the entry at the given path.

    :param: path The path to the entry relative to the working directory.
    :returns: The result of the operation: either the status of the entry in the
              index and working directories, or an error indicating what went wrong.
  */
  public func status(path: String) -> Result<EntryStatus, NSError> {
    var statusFlags: UInt32 = 0
    let errorCode = git_status_file(&statusFlags, cRepository, path)
    if errorCode == GIT_OK.value {
      return success(EntryStatus(rawValue: UInt(statusFlags)))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_status_file"))
    }
  }

  /**
    Whether the file at the given path matches the ignore rules.

    :param: path The path of the file.
    :returns: The result of the operation: either a boolean value indicating whether
              the file is ignored, or an error indicating what went wrong.
  */
  public func shouldIgnore(path: String) -> Result<Bool, NSError> {
    var ignored: Int32 = 0
    let errorCode = git_status_should_ignore(&ignored, cRepository, path)
    if errorCode == GIT_OK.value {
      return success(ignored != 0)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_status_should_ignore"))
    }
  }
}
