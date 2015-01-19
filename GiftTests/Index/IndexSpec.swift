import Gift
import LlamaKit
import Quick
import Nimble

class IndexSpec: QuickSpec {
  override func spec() {
    var index: Result<Index>!

    describe("entryCount") {
      beforeEach {
        index = openFixturesRepository("IndexSpec_EntryCount").flatMap { $0.index }
      }

      it("returns the number of entries in the index") {
        expect(index.map { $0.entryCount }).to(haveSucceeded(3))
      }
    }
  }
}
