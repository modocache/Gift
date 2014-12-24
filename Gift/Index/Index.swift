import git2

/**
  A data structure representing an index, also referred to as
  a "staging area" for changes.
*/
public struct Index {
  private let cIndex: COpaquePointer

  internal init(cIndex: COpaquePointer) {
    self.cIndex = cIndex
  }

  // TODO: git_index_free(cIndex) should be called when this struct is deinitialized.
}

public extension Index {
  /**
    Returns the number of entries in the index.
  */
  public var entryCount: UInt {
    return git_index_entrycount(cIndex)
  }
}
