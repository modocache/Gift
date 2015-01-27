import Gift
import LlamaKit
import Quick
import Nimble

class IndexSpec: QuickSpec {
  override func spec() {
    var index: Result<Index, NSError>!

    describe("entryCount") {
      beforeEach {
        index = openFixturesRepository("IndexSpec_EntryCount").flatMap { $0.index }
      }

      it("returns the number of entries in the index") {
        expect(index.map { $0.entryCount }).to(haveSucceeded(3))
      }
    }

    describe("add") {
      context("when there are unstaged entries") {
        beforeEach {
          index = openFixturesRepository("IndexSpec_Add_TwoUnstagedEntries").flatMap { $0.index }
        }

        it("adds all of them using the default parameters") {
          expect(index.map { $0.entryCount }).to(haveSucceeded(1))
          expect(index.flatMap { $0.add() }.map { $0.entryCount }).to(haveSucceeded(3))
        }
      }
    }
  }
}
