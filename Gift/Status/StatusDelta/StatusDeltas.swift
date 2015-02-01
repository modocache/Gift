/**
  A pair of status deltas used to represent the deltas between
  HEAD and the index, and between the index and the working directory.
*/
public struct StatusDeltas {
  /**
    The status delta between HEAD and the index.
    If there is no delta, and `StatusDeltaBehavior.IncludeUnmodified`
    is not enabled, this is nil.
  */
  public let headToIndex: StatusDelta?

  /**
    The status delta between the index and the working directory.
    If there is no delta, and `StatusDeltaBehavior.IncludeUnmodified`
    is not enabled, this is nil.
  */
  public let indexToWorkingDirectory: StatusDelta?

  internal init(cEntry: UnsafePointer<git_status_entry>) {
    if cEntry.memory.head_to_index != nil {
      headToIndex = StatusDelta(cDiffDelta: cEntry.memory.head_to_index.memory)
    }
    if cEntry.memory.index_to_workdir != nil {
      indexToWorkingDirectory = StatusDelta(cDiffDelta: cEntry.memory.index_to_workdir.memory)
    }
  }
}
