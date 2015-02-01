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
      var remoteURL: NSURL!
      var destinationURL: NSURL!

      context("on the local filesystem") {
        beforeEach {
          remoteURL = temporaryDirectoryURL().URLByAppendingPathComponent("park-slope")
          destinationURL = temporaryDirectoryURL().URLByAppendingPathComponent("sunset-park")
        }

        context("but the remote does not exist") {
          it("fails") {
            let repository = cloneRepository(remoteURL,destinationURL)
            let path = remoteURL.path!.stringByResolvingSymlinksInPath
            let faiureMessage = "Failed to resolve path '\(path)': No such file or directory"
            expect(repository).to(haveFailed(localizedDescription: faiureMessage))
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

      xcontext("from a remote URL") {
        beforeEach {
          remoteURL = NSURL(string: "git://git.libssh2.org/libssh2.git")
          destinationURL = temporaryDirectoryURL().URLByAppendingPathComponent("libssh2")
        }

        context("and the remote exists") {
          it("is succesful") {
            let options = CloneOptions(
              checkoutOptions: CheckoutOptions(
                strategy: CheckoutStrategy.SafeCreate,
                progressCallback: { (path: String!, completedSteps: UInt, totalSteps: UInt) in
                  println("path '\(path)', "
                          + "completedSteps '\(completedSteps)', "
                          + "totalSteps '\(totalSteps)'")
                }
              ),
              remoteCallbacks: RemoteCallbacks(
                transportMessageCallback: { (message) in
                  println("transportMessageCallback: \(message)")
                  return false
                },
                transferProgressCallback: { (progress) in
                  println("transferProgressCallback bytes: \(progress.receivedBytes)")
                  return false
                })
            )

            expect(cloneRepository(remoteURL, destinationURL, options: options))
              .to(haveSucceeded())
          }
        }
      }
    }
  }
}
