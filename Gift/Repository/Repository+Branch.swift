import ReactiveCocoa

public extension Repository {
  /**
    Enumerates references that refer to branches in a repository.
    As the references are enumerated, their values are sent via a signal.

    :param: type The type of branch to include in the enumeration.
    :returns: A signal that will notify subscribers of branches as they are
              enumerated. Dispose of the signal in order to discontinue
              the enueration.
  */
  public func branches(type: BranchType = .Local) -> RACSignal {
    return RACSignal.createSignal { (subscriber: RACSubscriber!) -> RACDisposable! in
      let disposable = RACDisposable()

      // Create a branch iterator. If this fails, notify the subscriber
      // of an error and exit early.
      var out = COpaquePointer()
      let errorCode = git_branch_iterator_new(&out, self.cRepository, git_branch_t(type.rawValue))
      if errorCode == GIT_OK.value {
        let iterator = BranchIterator(cBranchIterator: out)

        // Iterate over each branch reference.
        var next = iterator.next()
        while next.errorCode == GIT_OK.value {
          // For each reference, check if the signal has been disposed of.
          // If so, cancel early.
          if disposable.disposed {
            return disposable
          }
          // Otherwise, continue sending the subscriber references.
          subscriber.sendNext(Reference(cReference: next.cReference))
          next = iterator.next()
        }

        // Iteration completion means one of two things:
        if next.errorCode == GIT_ITEROVER.value {
          // 1. There are no branch references to iterate over, i.e.: GIT_ITEROVER.
          //    If that's the case, notify the subsciber that the signal has completed.
          subscriber.sendCompleted()
        } else {
          // 2. An error occurred while iterating. If that's the case, notify the
          //    subscriber of the error.
          subscriber.sendError(NSError.libGit2Error(next.errorCode, libGit2PointOfFailure: iterator.pointOfFailure))
        }
      } else {
        subscriber.sendError(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_branch_iterator_new"))
      }

      return disposable
    }
  }
}
