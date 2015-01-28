import Gift
import LlamaKit
import Quick
import Nimble

class Repository_ReferenceSpec: QuickSpec {
  override func spec() {
    var repository: Result<Repository, NSError>!
    beforeEach {
      repository = openFixturesRepository("Repository+ReferenceSpec_OneBranchBesidesMaster")
    }

    describe("setHead") {
      context("when the reference name is resolved to an existing reference") {
        it("sets the head to that reference") {
          let message = repository
            .flatMap { $0.setHead("refs/heads/development") }
            .flatMap { $0.headReference }
            .flatMap { $0.commit }
            .flatMap { $0.message }
          expect(message).to(haveSucceeded("Brooklyn Heights\n"))
        }
      }
    }
  }
}
