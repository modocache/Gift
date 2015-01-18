import Gift
import Quick
import Nimble

class RepositorySpec: QuickSpec {
  override func spec() {
    describe("initializeEmptyRepository") {
      context("with default settings") {
        it("initializes a repository with a working directory") {
          let newRepoURL = temporaryDirectoryURL().URLByAppendingPathComponent("greenpoint")
          let repository = initializeEmptyRepository(newRepoURL)

          expect(repository.flatMap { $0.gitDirectoryURL }.map { $0.path!.stringByResolvingSymlinksInPath })
            .to(haveSucceeded(newRepoURL.URLByAppendingPathComponent(".git").path!.stringByResolvingSymlinksInPath))
        }
      }
    }

    describe("cloneRepository") {
      context("on the local filesystem") {
        var remoteURL: NSURL!
        var destinationURL: NSURL!
        beforeEach {
          remoteURL = temporaryDirectoryURL().URLByAppendingPathComponent("park-slope")
          destinationURL = temporaryDirectoryURL().URLByAppendingPathComponent("sunset-park")
        }

        context("but the remote does not exist") {
          it("fails") {
            let repository = cloneRepository(remoteURL, destinationURL)
            let path = remoteURL.path!.stringByResolvingSymlinksInPath
            let faiureMessage = "libgit2 error: Failed to resolve path '\(path)': No such file or directory"
            expect(repository).to(haveFailed(faiureMessage))
          }
        }

        context("and the remote exists") {
          beforeEach {
            let _ = initializeEmptyRepository(remoteURL)
          }

          it("is succesful") {
            expect(cloneRepository(remoteURL, destinationURL)).to(haveSucceeded())
          }
        }
      }
    }
  }
}
