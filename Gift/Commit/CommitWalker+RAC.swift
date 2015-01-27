import ReactiveCocoa

internal extension CommitWalker {
  /**
    Walks over a series of commits, notifying the subscriber along the way.

    :param: subscriber A subscriber that will be notified of commits or errors
                       as the walker iterates over commits.
    :param: disposable Used to cancel the walk operation.
  */
  internal func walk(subscriber: RACSubscriber!, disposable: RACDisposable!) {
    var errorCode: Int32

    // Begin walking from HEAD. If this operation fails, notify the subsciber
    // of an error and return immediately.
    errorCode = git_revwalk_push_head(cWalker)
    if errorCode != GIT_OK.value {
      subscriber.sendError(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_revwalk_push_head"))
      return
    }

    // Iterate over the commits, storing their object IDs along the way.
    var objectID = UnsafeMutablePointer<git_oid>.alloc(1)
    errorCode = git_revwalk_next(objectID, cWalker)
    while errorCode == GIT_OK.value {
      // For each commit, check if the signal has been disposed of. If it has,
      // return immediately.
      if disposable.disposed {
        objectID.dealloc(1)
        return
      }

      // Lookup the commit with the object ID provided by the walker.
      // If the lookup succeeds, notify the subscriber. Otherwise,
      // let the subscriber know there was an error and halt the walk.
      let commit = Commit.lookup(objectID, cRepository: cRepository)
      switch commit {
      case .Success(let boxedCommit):
        subscriber.sendNext(boxedCommit.unbox)
      case .Failure(let boxedError):
        subscriber.sendError(boxedError.unbox)
        objectID.dealloc(1)
        return
      }

      // Continue walking.
      errorCode = git_revwalk_next(objectID, cWalker)
    }

    // Iteration completion means one of two things:
    objectID.dealloc(1)
    if errorCode == GIT_ITEROVER.value {
      // 1. There are no more commits to iterate over, i.e.: GIT_ITEROVER.
      //    If that's the case, notify the subsciber that the signal has completed.
      subscriber.sendCompleted()
    } else {
      // 2. An error occurred while iterating. If that's the case, notify the
      //    subscriber of the error.
      subscriber.sendError(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_revwalk_next"))
    }
  }
}
