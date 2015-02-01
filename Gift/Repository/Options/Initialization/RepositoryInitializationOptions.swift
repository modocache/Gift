/**
  A set of options used to initialize a Git repository.
  The designated initializer provides a set of reasonable defaults.
*/
public struct RepositoryInitializationOptions {
  /**
    A set of options indicating how the repository should be initialized.
  */
  internal let optionsSet: RepositoryInitializationOptionSet

  /**
    The mode of permissions on the newly created Git repository and its files.
  */
  internal let mode: RepositoryInitializationMode

  public init(
    optionsSet: RepositoryInitializationOptionSet = RepositoryInitializationOptionSet.MakePath,
    mode: RepositoryInitializationMode = .User
  ) {
    self.optionsSet = optionsSet
    self.mode = mode
  }
}
