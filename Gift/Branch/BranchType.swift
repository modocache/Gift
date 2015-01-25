/** A classifier used to determine which branches to iterate over. */
public enum BranchType: UInt32 {
  /** Only iterate over local branches. */
  case Local = 1
  /** Only iterate over remote branches. */
  case Remote = 2
  /** Iterate over all branches, both local and remote. */
  case All = 3
}
