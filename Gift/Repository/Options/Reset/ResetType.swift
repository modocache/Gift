/** Options for how to perform a repository reset. */
public enum ResetType: UInt32 {
  /**
    Moves HEAD to a given commit.
    The index and working directory are preserved.
  */
  case Soft = 1

  /**
    Not only moves HEAD to a given commit, but also
    resets the index to that commit as well.
  */
  case Mixed = 2

  /**
    Moves HEAD to a given commit, resets the index to that
    commit, and discards any changes in the working directory.
  */
  case Hard = 3
}
