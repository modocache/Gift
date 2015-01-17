import git2

extension RepositoryInitializationOptions {
  /**
    Returns a C struct initialized with this options instance's values.
    Used by libgit2 functions.
  */
  internal var cOptions: git_repository_init_options {
    return git_repository_init_options(
      version: 1,
      flags: UInt32(optionsSet.rawValue),
      mode: mode.rawValue,
      workdir_path: nil,
      description: nil,
      template_path: nil,
      initial_head: nil,
      origin_url: nil
    )
  }
}
