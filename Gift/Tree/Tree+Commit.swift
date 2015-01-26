import Foundation
import LlamaKit

public extension Tree {
  /**
    Creates a commit object based on the tree.

    :param: message The commit message.
    :param: updateReference The name of the reference that will be updated to point
                            to the new commit. Use "HEAD" to update the HEAD of the
                            current branch and make it point to this commit. If the
                            reference doesn't	exist yet, it will be created. If it
                            does exist, the first	parent must be the tip of this branch.
    :param: author The author's signature for the commit.
    :param: committer The committer's signature for the commit. If nil, the author's
                      signature will be used as the committer's signature as well.
    :param: parents The parents of this commit. This may be an empty array if creating the
                    first commit in a repository.
    :returns: The result of the commit operation: either the newly created commit object,
              or a failure indicating what went wrong.
  */
  public func commit(message: String, updateReference: String = "HEAD", author: Signature, committer: Signature? = nil, parents: [Commit] = []) -> Result<Commit, NSError> {
    var out = UnsafeMutablePointer<git_oid>.alloc(1)
    var authorSignature = author.cSignature
    var committerSignature = committer?.cSignature ?? author.cSignature
    var cParents = parents.map { $0.cCommit }
    let errorCode = git_commit_create(
      out, cRepository,
      updateReference,
      &authorSignature,
      &committerSignature,
      "UTF-8",
      message,
      cTree,
      UInt(countElements(cParents)),
      &cParents
    )

    if errorCode == GIT_OK.value {
      return Commit.lookup(out, cRepository: cRepository)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_commit_create"))
    }
  }
}
