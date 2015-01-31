/**
  A collection of options to configure the behavior
  of a merge.
*/
public struct MergeOptions {
  /**
    Similarity to consider a file renamed (default 50). Added files
    will be compared with deleted files to determine their similarity.
    Files that are more similar than the rename threshold
    (percentage-wise) will be treated as a rename.
  */
  internal let renameThreshold: UInt32
  /**
    Maximum similarity sources to examine for renames (default 200).
    If the number of rename candidates (add/delete pairs) is greater
    than this value, inexact rename detection is aborted.

    This setting overrides the `merge.renameLimit` configuration value.
  */
  internal let renameTargetLimit: UInt32

  /** A strategy to determine how to handle conflicts during a merge. */
  internal let strategy: MergeStrategy

  public init(
    renameThreshold: UInt32 = 50,
    renameTargetLimit: UInt32 = 200,
    strategy: MergeStrategy = MergeStrategy.Normal
  ) {
    self.renameThreshold = renameThreshold
    self.renameTargetLimit = renameTargetLimit
    self.strategy = strategy
  }
}
