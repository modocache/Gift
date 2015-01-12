import git2
import LlamaKit

/**
  TODO: Documentation.
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
    TODO: Documentation.
  */
  public var name: Result<String> {
    if let name = String.fromCString(git_reference_name(cReference)) {
      return success(name)
    } else {
      return failure("libgit2 error: git_reference_name failed")
    }
  }
}
