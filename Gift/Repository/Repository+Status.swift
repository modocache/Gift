import Foundation
import LlamaKit

public typealias StatusClosure = (headToIndex: StatusDelta?, indexToWorkingDirectory: StatusDelta?) -> Bool

public extension Repository {
  /**
    TODO: Documentation.
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
            var headToIndex: StatusDelta?
            if entry.memory.head_to_index != nil {
              headToIndex = StatusDelta(cStatusDelta: entry.memory.head_to_index.memory)
            }
            var indexToWorkingDirectory: StatusDelta?
            if entry.memory.index_to_workdir != nil {
              indexToWorkingDirectory = StatusDelta(cStatusDelta: entry.memory.index_to_workdir.memory)
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
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_status_file"))
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
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_status_should_ignore"))
    }
  }
}

// MARK: Private

private extension StatusDelta {
  /**
    Marking this extension and its initializer as internal or public
    causes a segmentation fault in the Swift compiler. In fact, any
    internal or public initializer that references a C struct type causes
    segfaults.

    TODO: File Apple Radar.
  */
  private init(cStatusDelta: git_diff_delta) {
    self.init(
      oldFileDiff: FileDiff(cFileDiff: cStatusDelta.old_file),
      newFileDiff: FileDiff(cFileDiff: cStatusDelta.new_file),
      type: StatusDeltaType(rawValue: cStatusDelta.status.value)!,
      similarity: Double(cStatusDelta.similarity)/100.0
    )
  }
}
