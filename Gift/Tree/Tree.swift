/**
  A tree object represents directory information. It records blob identifiers,
  path names, and a bit of metadata for all the files in a directory.
  It can also recursively reference other (sub)tree objects and thus build a
  complete hierarchy of files and subdirectories.
*/
public class Tree {
  internal let cTree: COpaquePointer

  internal init(cTree: COpaquePointer) {
    self.cTree = cTree
  }

  deinit {
    git_tree_free(cTree)
  }
}

public extension Tree {
  /**
    Returns the number of entries listed in a tree.
  */
  public var entryCount: UInt {
    return git_tree_entrycount(cTree)
  }
}
