import LlamaKit

/**
  A Git object can represent one of four types of data:
  blobs, trees, commits, and annotated tags. Git stores
  these objects in its database.
*/
internal class Object {
  internal let cObject: COpaquePointer

  internal init(cObject: COpaquePointer) {
    self.cObject = cObject
  }

  deinit {
    git_object_free(cObject)
  }
}
