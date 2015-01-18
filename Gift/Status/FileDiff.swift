/**
  TODO: Documentation.
*/
public struct FileDiff {
  /**
    The path within the working directory.
  */
  public let path: String

  /**
    TODO: Documentation.
  */
  public let size: UInt

  /**
    TODO: Documentation. A combination of git_diff_flag_t.
    TODO: Convert to an options set.
  */
  public let flags: UInt32

  public let mode: mode_t

  internal init(cFileDiff: git_diff_file) {
    path = NSString(CString: cFileDiff.path, encoding: NSUTF8StringEncoding)! // TODO: Crashes if the git_diff_file path is NULL.
    size = UInt(cFileDiff.size)
    flags = cFileDiff.flags
    mode = cFileDiff.mode
  }
}