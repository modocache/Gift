import Foundation
import git2
import LlamaKit

/**
  A data structure representing a Git repository.
*/
public class Repository {
  internal let cRepository: COpaquePointer

  internal init(cRepository: COpaquePointer) {
    self.cRepository = cRepository
  }

  deinit {
    git_repository_free(cRepository)
  }
}

public extension Repository {
  /**
    Returns the repository's .git directory's URL.
    TODO: Describe failure cases.
  */
  public var gitDirectoryURL: Result<NSURL> {
    if let path = String.fromCString(git_repository_path(cRepository)) {
      if let url = NSURL(fileURLWithPath: path, isDirectory: true) {
        return success(url)
      } else {
        return failure("Could not create NSURL from path: \(path)")
      }
    } else {
      return failure("libgit2 error: git_repository_path failed")
    }
  }
}

/**
  Creates a new Git repository at the given directory.

  :param: directoryURL The directory at which the new repository should be created.
                       If this is not a valid directory URL, this function will fail.
  :param: options A set of options used to customize the Git repository that is created.
  :returns: The result of the operation: either a newly created repository, or an error explaining what went wrong.
*/
public func initializeEmptyRepository(directoryURL: NSURL, options: RepositoryOptions) -> Result<Repository> {
  if let repoPath = directoryURL.path?.fileSystemRepresentation() {
    var out = COpaquePointer()
    var cOptions = options.cOptions
    let errorCode = git_repository_init_ext(&out, repoPath, &cOptions)

    if errorCode == GIT_OK.value {
      return success(Repository(cRepository: out))
    } else {
      // TODO: Use giterr_last() for more descriptive error message.
      return failure("libgit2 error: \(errorCode)")
    }
  } else {
    // TODO: Define more comprehensive set of error domains, codes.
    return failure("Invalid directoryURL: \(directoryURL)")
  }
}
