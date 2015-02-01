import Gift
import LlamaKit
import Quick
import Nimble

class Index_TreeSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    var index: Result<Index, NSError>!
    beforeEach {
      repository = openFixturesRepository("IndexSpec_EntryCount")
      index = repository.flatMap { $0.index }
    }

    describe("writeTree") {
      it("returns a tree") {
        expect(index.flatMap { $0.writeTree() }.map { $0.entryCount }).to(haveSucceeded(3))
      }
    }
  }
}
