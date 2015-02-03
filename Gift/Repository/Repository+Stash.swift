//import Foundation
import LlamaKit
//import ReactiveCocoa

public extension Repository {

  public func stash(message:String) -> Result<Commit, NSError> {

    var objectID = UnsafeMutablePointer<git_oid>.alloc(1)
    var cSignature = giftSignature.cSignature
    let errorCode =  git_stash_save(objectID, cRepository, &cSignature, message, 0)

    if errorCode == GIT_OK.value {
      return Commit.lookup(objectID, cRepository: cRepository)
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_stash_save"))
    }
  }

}

/**
*
* @param out Object id of the commit containing the stashed state.
* This commit is also the target of the direct reference refs/stash.
*
* @param repo The owning repository.
*
* @param stasher The identity of the person performing the stashing.
*
* @param message Optional description along with the stashed state.
*
* @param flags Flags to control the stashing process. (see GIT_STASH_* above)
*
* @return 0 on success, GIT_ENOTFOUND where there's nothing to stash,
* or error code.
*/
//GIT_EXTERN(int) git_stash_save(
//  git_oid *out,
//  git_repository *repo,
//  const git_signature *stasher,
//  const char *message,
//  unsigned int flags);
