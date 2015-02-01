/**
  Options that specify, when cloning a local repository, whether to fetch an
  object database, or merely copy it (which is faster).
*/
public enum LocalCloneBehavior: UInt32 {
  /** Copy the object database, but fetch when given `file://` URLs. */
  case Automatic = 0

  /** Always copy, even when given `file://` URLs. */
  case AlwaysCopy = 1

  /** Always clone, never copy, for all local repositories. */
  case NeverCopy = 2

  /** Always clone, but do not try to use hardlinks. */
  case NeverCopyAndNoHardlinks = 3
}
