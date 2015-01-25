import LlamaKit

/**
  Tags represent specific points in history that are important.
  Git uses two kinds of tags:

    1. Lightweight tags are simply named references to specific
       commits. They're like branches that never change.
    2. Annotated tags are Git objects in their own right. In
       addition to a simple name, they have a message and information
       on their author. They're like a commit with no entries.

  This object represents annotated tags.
*/
public class Tag {
  internal let cTag: COpaquePointer

  internal init(cTag: COpaquePointer) {
    self.cTag = cTag
  }

  deinit {
    git_tag_free(cTag)
  }
}

public extension Tag {
  /**
    Returns the name of the tag, or a failure indicating what
    may have gone wrong when retrieving the tag name.
  */
  public var name: Result<String> {
    let tagName = git_tag_name(cTag)
    if let nameString = String.fromCString(tagName) {
      return success(nameString)
    } else {
      let description = "An error occurred when attempting to convert tag name \(tagName) "
                        + "provided by git_tag_name to a String."
      return failure(NSError.giftError(.StringConversionFailure, description: description))
    }
  }
}
