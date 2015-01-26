import LlamaKit

/**
  References point to an underlying Git object, but have more
  semantically meaningful names. A branch, for example, is a named
  reference pointing to the latest commit in a series of work.
*/
public class Reference {
  internal let cReference: COpaquePointer

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
    Returns a 40-digit hexadecimal number string representation of the SHA1 of the
    reference. The SHA1 is a unique name obtained by applying the SHA1 hashing
    algorithm to the contents of the reference. This is a string representation of the
    object ID.
  */
  public var SHA: Result<String> {
    return self.object.flatMap { (object: Object) in
      let id = git_object_id(object.cObject)
      if let sha = String.fromCString(git_oid_tostr_s(id)) {
        return success(sha)
      } else {
        let description = "An error occurred when attempting to convert SHA "
                          + "provided by git_oid_tostr_s to a String."
        return failure(NSError.giftError(.StringConversionFailure, description: description))
      }
    }
  }

  /**
    Whether or not the reference is to a remote tracking branch.
  */
  public var isRemote: Bool {
    return git_reference_is_remote(cReference) != 0
  }
}
