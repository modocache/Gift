import LlamaKit

internal extension Object {
  /**
    Returns the object ID of the object.
  */
  internal var objectID: UnsafeMutablePointer<git_oid> {
    return UnsafeMutablePointer(git_object_id(cObject))
  }
}
