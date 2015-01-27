import Foundation
import LlamaKit

public extension Reference {
  /**
    Creates an annotated tag with the given name, message,
    and signature. If the tag is successfully created, a
    reference to that tag is returned. Otherwise, a failure
    indicating what went wrong is returned.

    :param: name The name of the tag to be created.
    :param: message The tag message.
    :param: signature The author, email, and timestamp of the tag to be created.
    :param: force Whether to overwrite any existing tags with the same name.
    :returns: Either a tag, or a failure message indicating why the tag couldn't be created.
  */
  public func tag(name: String, message: String, signature: Signature, force: Bool = false) -> Result<Tag, NSError> {
    return self.object.flatMap { (referenceObject: Object) in
      var out = UnsafeMutablePointer<git_oid>.alloc(1)
      var cSignature = signature.cSignature
      let errorCode = git_tag_create(
        out, self.cRepository, name, referenceObject.cObject, &cSignature, message, force ? 1 : 0)

      if errorCode == GIT_OK.value {
        let tag = Tag.lookup(out, cRepository: self.cRepository)
        out.dealloc(1)
        return tag
      } else {
        return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_tag_create"))
      }
    }
  }
}
