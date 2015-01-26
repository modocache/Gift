import LlamaKit

internal extension Tree {
  /**
    Looks up a tree object with the given object ID in the given repository.

    :param: objectID The object ID of the tree object.
    :param: cRepository An opaque C struct representing a repository that
                        the tree object ID belongs to.
    :returns: The result of the lookup: either a tree object, or a failure
              indicating what went wrong.
  */
  internal class func lookup(objectID: UnsafeMutablePointer<git_oid>, cRepository: COpaquePointer) -> Result<Tree> {
    var out = COpaquePointer()
    let errorCode = git_tree_lookup(&out, cRepository, objectID)
    if errorCode == GIT_OK.value {
      return success(Tree(cTree: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_tree_lookup"))
    }
  }
}
