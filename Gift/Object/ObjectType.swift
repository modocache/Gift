/** A classifier for the underlying type of a Git object. */
internal enum ObjectType: Int32 {
  /** An object that could be any of the other enumerated types. */
  case Any = -2
  /** An invalid object. */
  case Bad = -1
  /** A commit object. */
  case Commit = 1
  /** A tree or directory listing object. */
  case Tree = 2
  /** A file revision object. */
  case Blob = 3
  /** An annotated tag object. */
  case Tag = 4
  /** A delta where the base is given by an offset. */
  case DeltaByOffset = 6
  /** A delta where the base is given by an object ID. */
  case DeltaByObjectID = 7
}
