import Foundation
import git2

public func initializeEmptyRepository(fileURL: NSURL) {
  git_libgit2_init()
  if let repoPath = fileURL.path?.fileSystemRepresentation() {
    var out = COpaquePointer()
    var options = git_repository_init_options(
      version: 1,
      flags: GIT_REPOSITORY_INIT_MKPATH.value,
      mode: 0,
      workdir_path: nil,
      description: nil,
      template_path: nil,
      initial_head: nil,
      origin_url: nil
    )
    git_repository_init_ext(&out, repoPath, &options)
  }
}
