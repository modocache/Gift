public extension Repository {
  /**
    Enumerates references that refer to branches in a repository.
    Calls the callback closure for each reference.

    :param: type The type of branch to include in the enumeration.
    :param: branchCallback A closure that is called with each reference.
  */
  public func branches(type: BranchType = .Local, branchCallback: (Reference) -> ()) {
    var iterator = COpaquePointer()
    git_branch_iterator_new(&iterator, cRepository, git_branch_t(type.rawValue))

    var reference = COpaquePointer()
    var branchType = git_branch_t(0)
    while git_branch_next(&reference, &branchType, iterator) == GIT_OK.value {
      branchCallback(Reference(cReference: reference))
    }

    git_branch_iterator_free(iterator)
  }
}
