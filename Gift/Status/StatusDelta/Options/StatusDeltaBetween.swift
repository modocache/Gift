/** Indicates what should be compared when enumerating file status deltas. */
public enum StatusDeltaBetween: UInt32 {
  /**
    Include status deltas between HEAD and the index,
    as well as between the index and the working directory.
  */
  case All = 0
  /** Only include status deltas between HEAD and the index. */
  case Index = 1
  /** Only include status deltas between the index and the working directory. */
  case WorkingDirectory = 2
}
