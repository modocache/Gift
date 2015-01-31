/** Options for enumerating status deltas. */
public struct StatusDeltaOptions {
  /** Indicates what should be compared when enumerating file status deltas. */
  public let between: StatusDeltaBetween

  /** A set of options to customize the behavior of status delta enumeration. */
  public let behavior: StatusDeltaBehavior

  /**
    A list of path or path patterns to files that should be included in the
    status delta enumeration. If none are provided, all files in the repository
    (excluding those specifically excluded by the `behavior` options) are enumerated.
  */
  public let path: [String]

  public init(
    between: StatusDeltaBetween = StatusDeltaBetween.All,
    behavior: StatusDeltaBehavior = StatusDeltaBehavior.IncludeIgnored | StatusDeltaBehavior.IncludeUntracked | StatusDeltaBehavior.RecurseUntrackedDirectories | StatusDeltaBehavior.DetectRenamesBetweenHeadAndIndex | StatusDeltaBehavior.DetectRenamesBetweenIndexAndWorkingDirectory | StatusDeltaBehavior.DetectRenamesAmongRewrittenFiles,
    path: [String] = []
  ) {
    self.between = between
    self.behavior = behavior
    self.path = path
  }
}
