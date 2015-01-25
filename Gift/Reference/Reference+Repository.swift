import LlamaKit

internal extension Reference {
  /**
    Returns a pointer to the C struct representing
    the repository this reference belongs to.

    This pointer is not retained here, and so cannot
    be used to initialize a Repository object (which
    would call free on the pointer when it's deinitialized).
  */
  internal var cRepository: COpaquePointer {
    return git_reference_owner(cReference)
  }
}
