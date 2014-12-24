import git2

/**
  A set of options used to initialize a Git repository.
  The designated initializer provides a set of reasonable defaults.

  TODO: These options are incomplete; they do not yet cover the full
        range of options made possible by git_repository_init_options.
*/
public struct RepositoryOptions {
  /** A combination of GIT_REPOSITORY_INIT flags. */
  let flags: UInt32
  /**
  The mode of permissions on the newly created Git repository and its files.
  Either use one of the `git_repository_init_mode_t` constants, or define your own.
  */
  let mode: UInt32

  public init(flags: UInt32 = GIT_REPOSITORY_INIT_MKPATH.value, mode: UInt32 = GIT_REPOSITORY_INIT_SHARED_UMASK.value) {
    self.flags = flags
    self.mode = mode
  }
}
