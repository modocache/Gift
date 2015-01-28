import Gift
import LlamaKit
import Quick
import Nimble

class Commit_MergeSpec: QuickSpec {
  override func spec() {
    describe("merge") {
      var master: Result<Commit, NSError>!
      var repository: Result<Repository, NSError>!

      beforeEach {
        repository = openFixturesRepository("Commit+MergeSpec_OneBranchAheadOfMaster")
        master = repository.flatMap { $0.lookupBranch("master") }.flatMap { $0.commit }
      }

      it("merges the commit") {
        let commitToMerge = repository.flatMap { $0.lookupBranch("two") }.flatMap { $0.commit }
        let mergedIndex: Result<Index, NSError> = commitToMerge.flatMap { (toMerge: Commit) in
          return master.flatMap { $0.merge(toMerge) }
        }
        expect(mergedIndex.map { $0.entryCount }).to(haveSucceeded(2))
      }
    }
  }
}
