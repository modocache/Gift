import LlamaKit

/**
  A Git object can represent one of four types of data:
  blobs (binary large objects), trees, commits, and annotated
  tags. Git stores these objects in its object database, also
  known as the object store.
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
