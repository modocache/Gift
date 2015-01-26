import LlamaKit

public extension Repository {
  /**
    Enumerates the commits in a repository in the given order.
  
    :param: sorting The sorting rules to use when ordering commits to enumerate.
    :param: commitCallback A callback that is called at each step of the enumeration.
                           If an error occurs before or during enumeration, an error
                           is passed to the callback. Otherwise, a commit object is
                           passed to the callback.
  */
  public func commits(sorting: CommitSorting = CommitSorting.Time, commitCallback: (Result<Commit>) -> ()) {
    var walker = COpaquePointer()
    let createWalkerErrorCode = git_revwalk_new(&walker, cRepository)
    if createWalkerErrorCode == GIT_OK.value {
      let pushHeadErrorCode = git_revwalk_push_head(walker)
      if pushHeadErrorCode == GIT_OK.value {
        git_revwalk_sorting(walker, UInt32(sorting.rawValue))
        var objectID = UnsafeMutablePointer<git_oid>.alloc(1)
        while git_revwalk_next(objectID, walker) == GIT_OK.value {
          commitCallback(Commit.lookup(objectID, cRepository: cRepository))
        }
      } else {
        commitCallback(failure(NSError.libGit2Error(pushHeadErrorCode, libGit2PointOfFailure: "git_revwalk_push_head")))
      }
    } else {
      commitCallback(failure(NSError.libGit2Error(createWalkerErrorCode, libGit2PointOfFailure: "git_revwalk_new")))
    }
  }
}