import Gift
import LlamaKit
import ReactiveCocoa
import Quick
import Nimble

/**
  Given an array of results, return an array of successful values,
  discarding any results that were unsuccessful.
*/
private func compact<T, U>(results: [Result<T, U>]) -> [T] {
  var compacted: [T] = []
  results.map { $0.map { compacted.append($0) } }
  return compacted
}

private extension Repository {
  /**
    Maps each branch reference to a name and returns a list of names.
    Used for testing.

    :param: type The type of branches that should be enumerated over.
    :returns: A list of branch names in the order in which they were enumerated.
  */
  private func branchNames(type: BranchType) -> [String] {
    let branchReferences = branches(type: type).toArray() as [Reference]
    return compact(branchReferences.map { $0.name })
  }
}

class Repository_BranchSpec: QuickSpec {
  override func spec() {
    describe("branches") {
      var repository: Result<Repository, NSError>!

      context("when the repository contains several local branches") {
        beforeEach {
          repository = openFixturesRepository("Repository+BranchSpec_ThreeLocalBranches")
        }

        it("iterates over all of them") {
          expect(repository.map { $0.branchNames(.Local) as NSArray }).to(haveSucceeded([
            "refs/heads/master",
            "refs/heads/one",
            "refs/heads/three",
            "refs/heads/two"
          ]))
        }
      }

      context("when the repository contains local and remote branches") {
        beforeEach {
          repository = openFixturesRepository("TestGitRepository")
        }

        it("iterates over remote branches when filtering on remote branches") {
          expect(repository.map { $0.branchNames(.Remote) as NSArray }).to(haveSucceeded([
            "refs/remotes/origin/HEAD",
            "refs/remotes/origin/first-merge",
            "refs/remotes/origin/master",
            "refs/remotes/origin/no-parent",
          ]))
        }

        it("iterates over all branches when not filtering") {
          expect(repository.map { $0.branchNames(.All) as NSArray }).to(haveSucceeded([
            "refs/heads/master",
            "refs/remotes/origin/HEAD",
            "refs/remotes/origin/first-merge",
            "refs/remotes/origin/master",
            "refs/remotes/origin/no-parent",
          ]))
        }
      }
    }
  }
}
