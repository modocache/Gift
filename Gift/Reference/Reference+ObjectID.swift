import Foundation
import LlamaKit

internal extension Reference {
  /**
    Looks up a reference object with the given object ID in the given repository.

    :param: name The name of the reference object.
    :param: cRepository An opaque C struct representing a repository that
                        the reference belongs to.
    :returns: The result of the lookup: either a reference object, or a failure
              indicating what went wrong.
  */
  internal class func lookup(name: String, cRepository: COpaquePointer) -> Result<Reference, NSError> {
    var out = COpaquePointer.null()
    let errorCode = git_reference_lookup(&out, cRepository, name)
    if errorCode == GIT_OK.value {
      return success(Reference(cReference: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_reference_lookup"))
    }
  }
}
