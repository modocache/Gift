/**
  The difference in an entry between one snapshot and another.
  For example, the difference between an entry in HEAD and in the index,
  or between an entry in the index and the working directory.

  In the case of this representing the difference between HEAD and the index,
  `oldStatus` would refer to the status of the entry in HEAD, and `newStatus`
  would refer to status of the entry in the index.
*/
public struct StatusDelta {
  /**
    The status of an entry in the old snapshot.
    For example, when comparing the status of an entry between HEAD and the index,
    this would refer to the status of the entry in HEAD.
  */
  public let oldStatus: Status

  /**
    The status of an entry in the new snapshot.
    For example, when comparing the status of an entry between HEAD and the index,
    this would refer to the status of the entry in the index.
  */
  public let newStatus: Status

  /**
    The type of difference between the old and new snapshots.
    For example, when comparing the status of an entry between the index and working
    directory, and the entry has been modified in the working directory only, this
    would have a value of `StatusDeltaType.Modified`.
  */
  public let type: StatusDeltaType

  /**
    A value indicating how similar the old and new snapshots are, represented
    by a number between 0 and 1. Note, however, that this value is only relevant
    if the type of this status delta is `.Copied` or `.Renamed`. For all other
    types, this value is always zero.
  */
  public let similarity: Double

  internal init(cDiffDelta: git_diff_delta) {
    oldStatus = Status(cDiffFile: cDiffDelta.old_file)
    newStatus = Status(cDiffFile: cDiffDelta.new_file)
    type = StatusDeltaType(rawValue: cDiffDelta.status.value)!
    similarity = Double(cDiffDelta.similarity)/100.0
  }
}
