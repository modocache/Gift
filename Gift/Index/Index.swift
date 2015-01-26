/**
  A data structure representing an index, also referred to as
  a "staging area" for changes. The index is a temporary and
  dynamic binary file that describes the directory structure
  of the entire repository. The index captures a version of the
  project’s overall structure at some moment in time.

  The index allows a separation between incremental developmental
  changes and the committal of those changes. Changes are "staged"
  in an index, keeping those changes until they are ready to be
  committed.
*/
public class Index {
  internal let cIndex: COpaquePointer

  internal init(cIndex: COpaquePointer) {
    self.cIndex = cIndex
  }

  deinit {
    git_index_free(cIndex)
  }
}

public extension Index {
  /**
    Returns the number of entries in the index.
  */
  public var entryCount: UInt {
    return git_index_entrycount(cIndex)
  }
}
