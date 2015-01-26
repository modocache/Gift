import LlamaKit

public extension Index {
  /**
    Writes the a representation of the index as a tree to disk.
    This method returns a tree object that can be used to, for example,
    create a commit.

    The index must not be bare, has to be associated with an existing
    repository, and must notcontain files in conflict.

    :returns: The result of the write operation: either the written tree
              object, or a failure indicating what went wrong.
  */
  public func writeTree() -> Result<Tree> {
    var out = UnsafeMutablePointer<git_oid>.alloc(1)
    let errorCode = git_index_write_tree(out, cIndex)
    if errorCode == GIT_OK.value {
      return Tree.lookup(out, cRepository: cRepository)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_index_write_tree"))
    }
  }
}
