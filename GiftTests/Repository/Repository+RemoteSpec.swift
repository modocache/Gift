import Gift
import Foundation
import LlamaKit
import Quick
import Nimble

class Repository_RemoteSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    beforeEach {
      let remoteURL = temporaryDirectoryURL().URLByAppendingPathComponent("weeksville")
      initializeEmptyRepository(remoteURL)
      let destinationURL = temporaryDirectoryURL().URLByAppendingPathComponent("ditmas-park")
      repository = cloneRepository(remoteURL, destinationURL)
    }

    describe("createRemote") {
      context("when given a valid URL") {
        var url: NSURL!
        beforeEach {
          url = temporaryDirectoryURL().URLByAppendingPathComponent("east-williamsburg")
        }

        context("but an invalid name") {
          it("fails") {
            expect(repository.flatMap { $0.createRemote("", url: url) })
              .to(haveFailed(domain: libGit2ErrorDomain))
          }
        }

        context("and a valid name") {
          it("creates a remote") {
            repository.flatMap { $0.createRemote("wyckoff-heights", url: url) }
            expect(repository.flatMap { $0.lookupRemote("wyckoff-heights") }.flatMap { $0.url })
              .to(haveSucceeded(url))
          }
        }
      }
    }

    describe("lookupRemote") {
      context("when a remote with the given name does not exist") {
        it("fails") {
          expect(repository.flatMap { $0.lookupRemote("fiske-terrace") })
            .to(haveFailed(domain: libGit2ErrorDomain))
        }
      }

      context("when a remote with the given name exists") {
        it("returns that remote") {
          expect(repository.flatMap { $0.lookupRemote("origin").flatMap { $0.name } })
            .to(haveSucceeded("origin"))
        }
      }
    }

    describe("remoteNames") {
      context("when the repository has no remotes") {
        it("returns an empty list") {
          let url = temporaryDirectoryURL().URLByAppendingPathComponent("kensington")
          let emptyRepository = initializeEmptyRepository(url)
          expect(emptyRepository.flatMap { $0.remoteNames }.map { $0 as NSArray })
            .to(haveSucceeded([]))
        }
      }

      context("when the repository has remotes") {
        it("returns a list of their names") {
          repository.flatMap { $0.createRemote("pigtown", url: NSURL(string: "prospect-park-south")!) }
          expect(repository.flatMap { $0.remoteNames }.map { $0 as NSArray })
            .to(haveSucceeded(["origin", "pigtown"]))
        }
      }
    }
  }
}