/**
  The type of difference in an entry between one snapshot and another.
*/
public enum StatusDeltaType: UInt32 {
  /** No changes have been made to the entry. */
  case Unmodified = 0
  /** The entry does not exist in the old version. */
  case Added = 1
  /** The entry does not exist in the new version. */
  case Deleted = 2
  /** The entry's content has been changed between the old and new versions. */
  case Modified = 3
  /** The entry's content has been renamed between the old and new versions. */
  case Renamed = 4
  /** The entry was copied from another old entry. */
  case Copied = 5
  /** The entry is ignored in the working directory. */
  case Ignored = 6
  /** The entry is untracked in the working directory. */
  case Untracked = 7
  /** The type of the entry has been changed between the old and new versions. */
  case TypeChanged = 8
  /** The entry is unreadable. */
  case Unreadable = 9
}
