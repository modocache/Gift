/**
  An iterator for branch references.
*/
internal class BranchIterator {
  internal let cBranchIterator: COpaquePointer

  internal init(cBranchIterator: COpaquePointer) {
    self.cBranchIterator = cBranchIterator
  }

  deinit {
    git_branch_iterator_free(cBranchIterator)
  }
}

internal extension BranchIterator {
  /** The libgit2 function used by the branch iterator to enumerate branches. */
  internal var pointOfFailure: String { return "git_branch_next" }

  /**
    Continues to the next branch reference.

    :returns: A tuple containing the error code returned by the libgit2 function,
              an opaque pointer to the next branch reference (if one exists), and its
              branch type (if it exists).
  */
  internal func next() -> (errorCode: Int32, cReference: COpaquePointer, branchType: git_branch_t) {
    var cReference = COpaquePointer.null()
    var branchType = git_branch_t(0)
    let errorCode = git_branch_next(&cReference, &branchType, cBranchIterator)
    return (Int32(errorCode), cReference, branchType)
  }
}
