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
            .to(beSuccessful(newRepoURL.URLByAppendingPathComponent(".git").path!.stringByResolvingSymlinksInPath))
        }
      }
    }

    describe("cloneRepository") {
      context("with a remote on the local filesystem") {
        var remoteURL: NSURL!
        beforeEach {
          remoteURL = temporaryDirectoryURL().URLByAppendingPathComponent("park-slope")
          let _ = initializeEmptyRepository(remoteURL)
        }

        it("is succesful") {
          let localDestinationURL = temporaryDirectoryURL().URLByAppendingPathComponent("sunset-park")
          let repository = cloneRepository(remoteURL, localDestinationURL)

          expect(repository).to(beSuccessful())
        }
      }
    }
  }
}
