import Foundation
import LlamaKit
import ReactiveCocoa

public extension Repository {
  /**
    Enumerates over all status deltas in a repository.

    :param: options Options for enumerating status deltas. Use this to control whether
                    unmodified files are included in the enumeration, whether to detect
                    renames, and more.
    :returns: A signal that sends subscribers status deltas as they're
              enumerated, or an error to indicate what went wrong during
              the enumeration.
  */
  public func status(options: StatusDeltaOptions = StatusDeltaOptions()) -> RACSignal {
    return RACSignal.createSignal { (subscriber: RACSubscriber!) -> RACDisposable! in
      let disposable = RACDisposable()

      var statusList = COpaquePointer.null()
      var cOptions = options.cOptions
      let errorCode = git_status_list_new(&statusList, self.cRepository, &cOptions)
      if errorCode == GIT_OK.value {
        let statusCount = git_status_list_entrycount(statusList)
        for statusIndex in 0..<statusCount {
          let entry = git_status_byindex(statusList, statusIndex)
          if entry != nil {
            subscriber.sendNext(StatusDeltas(cEntry: entry))
          }
        }
        subscriber.sendCompleted()
      } else {
        subscriber.sendError(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_status_list_new"))
      }

      git_status_list_free(statusList)
      return disposable
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
