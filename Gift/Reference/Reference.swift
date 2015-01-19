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
    let referenceName = git_reference_name(cReference)
    if let name = String.fromCString(referenceName) {
      return success(name)
    } else {
      let description = "An error occurred when attempting to convert reference name \(referenceName) "
                        + "provided by git_reference_name to a String."
      return failure(NSError.giftError(.StringConversionFailure, description: description))
    }
  }

  /**
    Whether or not the reference is to a remote tracking branch.
  */
  public var isRemote: Bool {
    return git_reference_is_remote(cReference) != 0
  }
}
