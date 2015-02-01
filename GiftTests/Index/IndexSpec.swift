import Gift
import LlamaKit
import Quick
import Nimble

class IndexSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    var index: Result<Index, NSError>!

    describe("entryCount") {
      beforeEach {
        repository = openFixturesRepository("IndexSpec_EntryCount")
        index = repository.flatMap { $0.index }
      }

      it("returns the number of entries in the index") {
        expect(index.map { $0.entryCount }).to(haveSucceeded(3))
      }
    }

    describe("add") {
      context("when there are unstaged entries") {
        beforeEach {
          repository = openFixturesRepository("IndexSpec_Add_TwoUnstagedEntries")
          index = repository.flatMap { $0.index }
        }

        it("adds all of them using the default parameters") {
          expect(index.map { $0.entryCount }).to(haveSucceeded(1))
          expect(index.flatMap { $0.add() }.map { $0.entryCount }).to(haveSucceeded(3))
        }
      }
    }
  }
}
