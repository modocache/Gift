import LlamaKit

public extension Commit {
  /**
    Merges another commit into this commit to produce an index.

    :param: commit The commit to merge into this one.
    :param: options A set of options to configure merge behavior.
    :returns: A result that is either: the resulting index, or an error 
              indicating what went wrong.
  */
  public func merge(commit: Commit, options: MergeOptions = MergeOptions()) -> Result<Index, NSError> {
    var out = COpaquePointer.null()
    var cOptions = options.cOptions
    let errorCode = git_merge_commits(&out, cRepository, cCommit, commit.cCommit, &cOptions)
    if errorCode == GIT_OK.value {
      return success(Index(cIndex: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_merge_commits"))
    }
  }
}
