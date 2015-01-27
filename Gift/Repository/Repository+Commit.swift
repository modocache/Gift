import ReactiveCocoa

public extension Repository {
  /**
    Enumerates the commits in a repository in the given order.
  
    :param: sorting The sorting rules to use when ordering commits to enumerate.
    :returns: A signal that will notify subscribers of commits as they are
              enumerated. Dispose of the signal in order to discontinue
              the enueration.
  */
  public func commits(sorting: CommitSorting = CommitSorting.Time) -> RACSignal {
    return RACSignal.createSignal { (subscriber: RACSubscriber!) -> RACDisposable! in
      let disposable = RACDisposable()

      var out = COpaquePointer()
      let errorCode = git_revwalk_new(&out, self.cRepository)
      if errorCode == GIT_OK.value {
        CommitWalker(cWalker: out, cRepository: self.cRepository, sorting: sorting)
          .walk(subscriber, disposable: disposable)
      } else {
        subscriber.sendError(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_revwalk_new"))
      }

      return disposable
    }
  }
}
