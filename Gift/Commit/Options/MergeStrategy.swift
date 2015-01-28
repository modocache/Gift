/**
  Strategies to determine how to handle conflicts during a merge.
*/
public enum MergeStrategy: UInt32 {
  /**
    When a region of a file is changed in both branches, a conflict
    will be recorded in the index so that `git_checkout` can produce
    a merge file with conflict markers in the working directory.
    This is the default.
  */
  case Normal = 0
  /**
    When a region of a file is changed in both branches, the file
    created in the index will contain the "ours" side of any conflicting
    region.  The index will not record a conflict.
  */
  case Ours = 1
  /**
    When a region of a file is changed in both branches, the file
    created in the index will contain the "theirs" side of any conflicting
    region.  The index will not record a conflict.
  */
  case Theirs = 2
  /**
    When a region of a file is changed in both branches, the file
    created in the index will contain each unique line from each side,
    which has the result of combining both files.  The index will not
    record a conflict.
  */
  case Union = 3
}
