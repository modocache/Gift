import Gift
import LlamaKit
import Quick
import Nimble

class Tree_CommitSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    var index: Result<Index, NSError>!
    var tree: Result<Tree, NSError>!

    describe("commit") {
      context("when the commit has no parents") {
        beforeEach {
          repository = openFixturesRepository("Tree+CommitSpec_InitialCommit")
          index = repository.flatMap { $0.index }
          tree = index.flatMap { $0.writeTree() }
        }

        it("creates a new commit") {
          let commit = tree.flatMap { $0.commit(
            "cadman-plaza",
            author: Signature(name: "redhook", email: "fort-greene")
          )}
          expect(commit.flatMap { $0.message }).to(haveSucceeded("cadman-plaza"))
        }
      }
    }
  }
}
