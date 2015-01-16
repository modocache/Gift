import git2
import LlamaKit

/**
  References point to a particular commit, but have more semantically
  meaningful names. A branch, for example, is a named reference
  pointing to the latest commit in a series of work.
*/
public class Reference {
  private let cReference: COpaquePointer

  internal init(cReference: COpaquePointer) {
    self.cReference = cReference
  }

  deinit {
    git_reference_free(cReference)
  }
}

public extension Reference {
  /**
    The name of the reference.
  */
  public var name: Result<String> {
    if let name = String.fromCString(git_reference_name(cReference)) {
      return success(name)
    } else {
      return failure("libgit2 error: git_reference_name failed")
    }
  }

  /**
    Whether or not the reference is to a remote tracking branch.
  */
  public var isRemote: Bool {
    return git_reference_is_remote(cReference) != 0
  }
}
