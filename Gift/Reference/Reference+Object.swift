import Foundation
import LlamaKit

internal extension Reference {
  /**
    Returns the underlying object referred to by this reference,
    or a failure indicating what went wrong when looking up that
    object.
  */
  internal var object: Result<Object, NSError> {
    var out = COpaquePointer()
    let errorCode = git_reference_peel(&out, cReference, git_otype(ObjectType.Any.rawValue))
    if errorCode == GIT_OK.value {
      return success(Object(cObject: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_reference_peel"))
    }
  }
}
