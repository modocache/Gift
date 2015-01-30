import Foundation
import LlamaKit
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

      var out = COpaquePointer.null()
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

  /**
    Sets the current HEAD of the repository to the given commit.
    Depending on the reset type specified, this may also reset the index
    and working directory.

    :param: commit The commit HEAD should be reset to.
    :param: resetType A type specifying whether the reset should be "soft",
                      "hard", or "mixed"--each of those being different options
                      for resetting the index and working directory.
    :param: checkoutOptions In the case of a hard commit, these options will be
                            used to determine exactly how files will be reset.
                            These can also be used in order to register progress
                            callbacks. The "checkout strategy" of the options will
                            be overridden based on the reset type.
    :param: signature The identity that will be used to popular the reflog entry.
                      By default, this will be recorded as "com.libgit2.Gift".
    :returns: The result of the operation: either a repository that has been reset to
              point to the given commit, or an error indicating what went wrong.
  */
  public func reset(commit: Commit, resetType: ResetType, checkoutOptions: CheckoutOptions = CheckoutOptions(strategy: CheckoutStrategy.None), signature: Signature = giftSignature) -> Result<Repository, NSError> {
    var cOptions = checkoutOptions.cOptions
    var cSignature = signature.cSignature
    let errorCode = git_reset(cRepository, commit.cCommit, git_reset_t(resetType.rawValue), &cOptions, &cSignature, nil)
    if errorCode == GIT_OK.value {
      return success(self)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_reset"))
    }
  }
}
