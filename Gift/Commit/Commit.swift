import LlamaKit

/**
  A snapshot of the index at a given point in time.
  These are used to record changes.
*/
public class Commit {
  private let cCommit: COpaquePointer

  internal init(cCommit: COpaquePointer) {
    self.cCommit = cCommit
  }

  deinit {
    git_commit_free(cCommit)
  }
}

public extension Commit {
  /**
    Returns the full message of a commit, or a failure indicating
    what went wrong when retrieving the message. The returned message
    will be slightly prettified by removing any potential leading newlines.
  */
  public var message: Result<String> {
    let cMessage = git_commit_message(cCommit)
    if let commitMessage = String.fromCString(cMessage) {
      return success(commitMessage)
    } else {
      let description = "An error occurred when attempting to convert commit message "
                        + "'\(cMessage)', provided by git_commit_message, to a String."
      return failure(NSError.giftError(.StringConversionFailure, description: description))
    }
  }
}
