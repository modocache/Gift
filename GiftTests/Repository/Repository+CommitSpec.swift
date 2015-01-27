import Gift
import LlamaKit
import Quick
import Nimble

class Repository_CommitSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    beforeEach {
      repository = openFixturesRepository("Repository+CommitSpec_FourCommits")
    }

    describe("commits") {
      it("enumerates the commits in the repository in the given sorting order") {
        expect(repository.map { countElements($0.commits().toArray()) }).to(haveSucceeded(4))
      }
    }
  }
}
