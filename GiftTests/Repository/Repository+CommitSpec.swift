import Gift
import LlamaKit
import Quick
import Nimble

class Repository_CommitSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository>!
    beforeEach {
      repository = openFixturesRepository("Repository+CommitSpec_FourCommits")
    }

    describe("commits") {
      it("enumerates the commits in the repository in the given sorting order") {
        var commits: [Commit] = []
        repository.map { $0.commits { (commit: Result<Commit>) in
          let _ = commit.map { commits.append($0) }
        }}
        expect(countElements(commits)).to(equal(4))
      }
    }
  }
}
