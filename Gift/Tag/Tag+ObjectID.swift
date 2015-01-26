import LlamaKit

internal extension Tag {
  /**
    Looks up a commit object with the given object ID in the given repository.

    :param: objectID The object ID of the tag object.
    :param: cRepository An opaque C struct representing a repository that
            the tag object ID belongs to.
    :returns: The result of the lookup: either a tag object, or a failure
              indicating what went wrong.
  */
  internal class func lookup(objectID: UnsafeMutablePointer<git_oid>, cRepository: COpaquePointer) -> Result<Tag> {
    var out = COpaquePointer()
    let errorCode = git_tag_lookup(&out, cRepository, objectID)
    if errorCode == GIT_OK.value {
      return success(Tag(cTag: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_tag_lookup"))
    }
  }
}
