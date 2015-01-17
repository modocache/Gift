import git2

/**
  The difference in an entry between one snapshot and another.
  For example, the difference between an entry in HEAD and in the index,
  or between an entry in the index and the working directory.

  In the case of this representing the difference between HEAD and the index,
  `oldFileDiff` would refer to HEAD, and `newFileDiff` would refer to the index.
*/
public struct StatusDelta {
  /**
    TODO: Documentation.
  */
  public let oldFileDiff: FileDiff

  /**
    TODO: Documentation.
  */
  public let newFileDiff: FileDiff

  /**
    TODO: Documentation.
  */
  public let type: StatusDeltaType

  /**
    TODO: Documentation. Only useful with certain types.
  */
  public let similarity: Double

  internal init(cStatusDelta: git_diff_delta) {
    oldFileDiff = FileDiff(cFileDiff: cStatusDelta.old_file)
    newFileDiff = FileDiff(cFileDiff: cStatusDelta.new_file)
    type = StatusDeltaType(rawValue: cStatusDelta.status.value)! // TODO: Raises if status is outside of known range.
    similarity = Double(cStatusDelta.similarity)/100.0
  }
}
