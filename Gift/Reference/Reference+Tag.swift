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
  public func tag(name: String, message: String, signature: Signature, force: Bool = false) -> Result<Tag> {
    return self.object.flatMap { (referenceObject: Object) in
      var tagObjectID = UnsafeMutablePointer<git_oid>.alloc(1)
      var cSignature = signature.cSignature
      let tagCreateErrorCode = git_tag_create(
        tagObjectID, self.cRepository, name, referenceObject.cObject, &cSignature, message, force ? 1 : 0)
      if tagCreateErrorCode == GIT_OK.value {
        var tag = COpaquePointer()
        let tagLookupErrorCode = git_tag_lookup(&tag, self.cRepository, tagObjectID)
        if tagLookupErrorCode == GIT_OK.value {
          return success(Tag(cTag: tag))
        } else {
          return failure(NSError.libGit2Error(tagLookupErrorCode, libGit2PointOfFailure: "git_tag_lookup"))
        }
      } else {
        return failure(NSError.libGit2Error(tagCreateErrorCode, libGit2PointOfFailure: "git_tag_create"))
      }
    }
  }
}
