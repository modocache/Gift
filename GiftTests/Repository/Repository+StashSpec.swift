import Gift
import LlamaKit
import Quick
import Nimble

class Repository_StashSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    beforeEach {
      repository = openFixturesRepository("Repository+StashSpec_TwoFilesInIndex")
    }

    describe("stash") {
      it("stashes entries staged in the index into a commit") {
        // First, make sure there are two entries in the index.
        expect(repository.flatMap { $0.index }.map { $0.entryCount }).to(haveSucceeded(2))

        // Stash the changes into a commit object.
        let commit = repository.map { $0.stash("gowanus") }

        // Assert that the index no longer contains any staged entries, since they were stashed.
        expect(repository.flatMap { $0.index }.map { $0.entryCount }).to(haveSucceeded(0))
      }
    }
  }
}
