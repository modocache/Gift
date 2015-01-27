import Foundation
import LlamaKit

/**
  A data structure representing a Git repository.
*/
public class Repository {
  internal let cRepository: COpaquePointer

  internal init(cRepository: COpaquePointer) {
    self.cRepository = cRepository
  }

  // TODO: When a repository object goes out of scope,
  //       it frees the underlying C struct. This means
  //       Gift cannot use repository objects when they
  //       do not own the underlying struct. Currently,
  //       however, it does.
  // deinit {
  //   git_repository_free(cRepository)
  // }
}

public extension Repository {
  /**
    Returns the repository's .git directory's URL.
    TODO: Describe failure cases.
  */
  public var gitDirectoryURL: Result<NSURL, NSError> {
    if let path = String.fromCString(git_repository_path(cRepository)) {
      if let url = NSURL(fileURLWithPath: path, isDirectory: true) {
        return success(url)
      } else {
        let description = "Could not create NSURL from path '\(path)', provided by git_repository_path."
        return failure(NSError.giftError(.InvalidURI, description: description))
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
public func initializeEmptyRepository(directoryURL: NSURL, options: RepositoryInitializationOptions = RepositoryInitializationOptions()) -> Result<Repository, NSError> {
  if let repoPath = directoryURL.path?.fileSystemRepresentation() {
    var out = COpaquePointer.null()
    var cOptions = options.cOptions
    let errorCode = git_repository_init_ext(&out, repoPath, &cOptions)

    if errorCode == GIT_OK.value {
      return success(Repository(cRepository: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_repository_init_ext"))
    }
  } else {
    return failure(NSError.giftError(.InvalidURI, description: "Invalid directoryURL: '\(directoryURL)'"))
  }
}

/**
  Opens a Git repository at the given fileURL.

  :param: fileURL The URL at which the Git repository is located.
  :returns: The result of the operation: either a Repository object, or an error
            indicating why the repository could not be opened.
*/
public func openRepository(fileURL: NSURL) -> Result<Repository, NSError> {
  if !fileURL.fileURL || fileURL.path == nil {
    return failure(NSError.giftError(.InvalidURI, description: "Invalid fileURL: '\(fileURL)'"))
  } else {
    var out = COpaquePointer.null()
    let errorCode = git_repository_open(&out, fileURL.path!)
    if errorCode == GIT_OK.value {
      return success(Repository(cRepository: out))
    } else {
      return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_repository_open"))
    }
  }
}

/**
  Clones a remote repository.

  :param: originURL The URL at which the remote repository is located.
                    This URL may represent a location on the local file system.
  :param: destinationWorkingDirectory The file system URL the cloned repository will be written to.
  :options: A set of options used to configure how the repository will be cloned.
  :returns: The result of the operation: either the cloned repository, or an error explaining what went wrong.
*/
public func cloneRepository(originURL: NSURL, destinationWorkingDirectory: NSURL, options: CloneOptions = CloneOptions()) -> Result<Repository, NSError> {
  if let url = cPath(originURL) {
    if let localPath = destinationWorkingDirectory.path?.fileSystemRepresentation() {
      var out = COpaquePointer.null()
      var cOptions = options.cOptions
      let errorCode = git_clone(&out, url, localPath, &cOptions)

      if errorCode == GIT_OK.value {
        return success(Repository(cRepository: out))
      } else {
        return failure(NSError.libGit2Error(errorCode, libGit2PointOfFailure: "git_clone"))
      }
    } else {
      return failure(NSError.giftError(.InvalidURI, description: "Invalid destinationWorkingDirectory: \(destinationWorkingDirectory)"))
    }
  } else {
    return failure(NSError.giftError(.InvalidURI, description: "Invalid originURL: \(originURL)"))
  }
}

// MARK: Internal

private func cPath(url: NSURL) -> [CChar]? {
  if url.isFileReferenceURL() {
    return url.path?.fileSystemRepresentation()
  } else {
    return url.absoluteString?.cStringUsingEncoding(NSUTF8StringEncoding)
  }
}
