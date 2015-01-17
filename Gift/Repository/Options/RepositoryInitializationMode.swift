import git2

/**
  File mode options for the files created when initializing a repository.
*/
public enum RepositoryInitializationMode: UInt32 {
  /** Permissions used by umask--the default. */
  case User = 0
  /**
    Emulates the permissions used by `git clone --shared=group`.
    The repository is made group-writeable.
  */
  case Group = 0002775
  /**
    Emulates the permissions used by `git clone --shared=all`.
    The repository is made world-readable.
  */
  case All = 0002777
}
