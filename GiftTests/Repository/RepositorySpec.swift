import Gift
import Quick
import Nimble

class RepositorySpec: QuickSpec {
  override func spec() {
    var tempDirectoryURL: NSURL!
    beforeEach {
      let tempDirectoryPath = NSTemporaryDirectory()
        .stringByAppendingPathComponent("com.libgit2.gift")
        .stringByAppendingPathComponent(NSProcessInfo.processInfo().globallyUniqueString)

      var error: NSError?
      NSFileManager.defaultManager()
        .createDirectoryAtPath(tempDirectoryPath, withIntermediateDirectories: true, attributes: nil, error: &error)
      expect(error).to(beNil())

      tempDirectoryURL = NSURL(fileURLWithPath: tempDirectoryPath)!
    }

    describe("initializeEmptyRepository") {
      context("with default settings") {
        beforeEach {
          // TODO: Removing this initialization (unused) causes references to
          //       RepositoryInitializationOptions() to segfault.
          let _ = RepositoryInitializationOptions(
            optionsSet: RepositoryInitializationOptionSet.MakePath,
            mode: .User
          )
        }

        it("initializes a repository with a working directory") {
          let newRepoURL = tempDirectoryURL.URLByAppendingPathComponent("greenpoint")
          let repository = initializeEmptyRepository(newRepoURL)
          expect(repository.flatMap { $0.gitDirectoryURL }.map { $0.path!.stringByResolvingSymlinksInPath })
            .to(beSuccessful(newRepoURL.URLByAppendingPathComponent(".git").path!.stringByResolvingSymlinksInPath))
        }
      }
    }
  }
}
