/**
  The status of an entry in a particular snapshot.
  A `StatusDelta` represents the difference in an entry between two
  snapshots by providing the entry's `Status` in the old snapshot,
  as well as its `Status` in the new snapshot.
*/
public struct Status {
  /**
    The object ID of the entry. If the entry represents the absent side of
    a delta, such as the `oldStatus` of a delta of type `StatusDeltaType.Added`,
    then the object ID will be invalid. This will also be indicated by the absence
    of `StatusDescriptorSet.ValidID` on this `Status` struct's descriptors.
  */
  internal let objectID: git_oid

  /** The path to the entry relative to the working directory. */
  public let path: String

  /** The size of the entry in bytes. */
  public let size: UInt

  /**
    A set of descriptors for this status object, used to indicate whether
    it refers to binary or text, and whether it has a valid ID.
  */
  public let descriptors: StatusDescriptorSet

  /** The file mode of the entry. */
  public let mode: mode_t

  internal init(cDiffFile: git_diff_file) {
    objectID = cDiffFile.id

    // Crashes if the git_diff_file path is NULL.
    // Not sure when, if ever, this is the case.
    path = String.fromCString(cDiffFile.path)!

    size = UInt(cDiffFile.size)
    descriptors = StatusDescriptorSet(rawValue: UInt(cDiffFile.flags))
    mode = cDiffFile.mode
  }
}
