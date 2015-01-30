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

    describe("reset") {
      it("resets HEAD to the given commit") {
        // First, make sure HEAD is set to the fourth commit.
        expect(repository
          .flatMap { $0.headReference }
          .flatMap { $0.commit }
          .flatMap { $0.message }
        ).to(haveSucceeded("Fourth commit.\n"))

        // Grab the first commit.
        let firstCommit = repository
          .map { $0.commits(sorting: CommitSorting.Time | CommitSorting.Reverse).toArray().first as Commit }

        // Reset HEAD to the first commit, then grab that commit.
        let resetHeadCommit: Result<Commit, NSError> = firstCommit.flatMap { (commit: Commit) in
          return repository
            .flatMap { $0.reset(commit, resetType: .Hard) }
            .flatMap { $0.headReference }
            .flatMap { $0.commit }
        }

        // Assert that the commit at HEAD is the first commit in the repository.
        expect(resetHeadCommit.flatMap { $0.message }).to(haveSucceeded("First commit.\n"))
      }
    }
  }
}
