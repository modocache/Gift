/**
  Walkers are used internally to iterate over a list of commits.
*/
internal class CommitWalker {
  internal let cWalker: COpaquePointer
  internal let cRepository: COpaquePointer

  internal init(cWalker: COpaquePointer, cRepository: COpaquePointer, sorting: CommitSorting) {
    self.cWalker = cWalker
    self.cRepository = cRepository
    git_revwalk_sorting(cWalker, UInt32(sorting.rawValue))
  }

  deinit {
    git_revwalk_free(cWalker)
  }
}
