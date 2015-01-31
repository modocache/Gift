import Gift
import ReactiveCocoa
import LlamaKit
import Quick
import Nimble

class Repository_TagSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!

    describe("tags") {
      context("when the repository has tags") {
        beforeEach {
          repository = openFixturesRepository("Repository+TagSpec_ThreeTags")
        }

        it("enumerates them") {
          let references = repository.flatMap { ($0.tags() |> scan([]) { $0 + [$1] } |> first)! }
          let names = references.map { compact($0.map { $0.name }) }.map { $0 as NSArray }
          expect(names).to(haveSucceeded([
            "refs/tags/first",
            "refs/tags/second",
            "refs/tags/third",
          ]))
        }
      }
    }

    describe("tagNames") {
      context("when the repository has no tags") {
        beforeEach {
          repository = openFixturesRepository("Repository+TagSpec_NoTags")
        }

        it("returns an empty list") {
          expect(repository.flatMap { $0.tagNames() }.map { $0 as NSArray })
            .to(haveSucceeded([]))
        }
      }

      context("when the repository has tags") {
        beforeEach {
          repository = openFixturesRepository("Repository+TagSpec_ThreeTags")
        }

        context("and no pattern is specified") {
          it("returns a list of all the tag names") {
            expect(repository.flatMap { $0.tagNames() }.map { $0 as NSArray })
              .to(haveSucceeded(["first", "second", "third"]))
          }
        }

        context("and a pattern is specified") {
          it("returns a list of all tags with a name that matches the pattern") {
            expect(repository.flatMap { $0.tagNames(matchingPattern: "second") }.map { $0 as NSArray })
              .to(haveSucceeded(["second"]))
          }
        }
      }
    }
  }
}
