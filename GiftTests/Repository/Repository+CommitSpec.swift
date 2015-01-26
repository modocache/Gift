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
        var errors: [NSError] = []
        repository.map { $0.commits { (walkedCommit: Commit?, walkedError: NSError?) in
          if let commit = walkedCommit { commits.append(commit) }
          if let error = walkedError { errors.append(error) }
        }}

        expect(countElements(commits)).to(equal(4))
        expect(errors).to(beEmpty())
      }
    }
  }
}